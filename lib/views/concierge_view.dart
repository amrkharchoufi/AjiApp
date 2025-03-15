import 'package:ajiapp/widgets/date_time_field_widget.dart';
import 'package:ajiapp/widgets/input_field_widget.dart';
import 'package:ajiapp/widgets/section_title_widget.dart';
import 'package:flutter/material.dart';

class CarServiceView extends StatefulWidget {
  const CarServiceView({super.key});

  @override
  _CarServiceViewState createState() => _CarServiceViewState();
}

class _CarServiceViewState extends State<CarServiceView>
    with TickerProviderStateMixin {
  // Controllers
  final pickUpController = TextEditingController();
  final dropOffController = TextEditingController();
  final passengerController = TextEditingController();

  final dateController = TextEditingController();
  final timeController = TextEditingController();

  final pickUpDateController = TextEditingController();
  final pickUpTimeController = TextEditingController();

  final returnDateController = TextEditingController();
  final returnTimeController = TextEditingController();

  TabController? tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    // On n’oublie pas de libérer les contrôleurs et le TabController
    pickUpController.dispose();
    dropOffController.dispose();
    passengerController.dispose();
    dateController.dispose();
    timeController.dispose();
    pickUpDateController.dispose();
    pickUpTimeController.dispose();
    returnDateController.dispose();
    returnTimeController.dispose();
    tabController?.dispose();
    super.dispose();
  }

  /// Méthode pour picker une date
  Future<void> _pickDate(TextEditingController controller) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && mounted) {
      setState(() {
        controller.text = "${pickedDate.day.toString().padLeft(2, '0')}/"
            "${pickedDate.month.toString().padLeft(2, '0')}/"
            "${pickedDate.year}";
      });
    }
  }

  /// Méthode pour picker l’heure
  Future<void> _pickTime(TextEditingController controller) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null && mounted) {
      setState(() {
        controller.text = "${pickedTime.hour.toString().padLeft(2, '0')}:"
            "${pickedTime.minute.toString().padLeft(2, '0')}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: size.width * 0.1,
        ),
        Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: const Color.fromARGB(84, 158, 158, 158),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TabBar(
                controller: tabController,
                indicator: BoxDecoration(color: Colors.white),
                indicatorColor: Colors.transparent,
                dividerColor: Colors.transparent,
                labelColor: Colors.black,
                labelPadding: const EdgeInsets.all(5),
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: const [
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.directions_bus_outlined),
                        SizedBox(width: 8),
                        Text("Transfers"),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.directions_car_filled_sharp),
                        SizedBox(width: 8),
                        Text("Car servers"),
                      ],
                    ),
                  ),
                ],
              ),

              // Contenu des onglets
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(10),
                height: 490, // Ajustez selon votre UI
                child: TabBarView(
                  controller: tabController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    /// PREMIER ONGLET : TRANSFERS
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 20),

                          // Pick Up
                          InputFieldWidget(
                            label: "Pick Up Location",
                            hint: "Address, Airport, Hotel",
                            controller: pickUpController,
                          ),
                          const SizedBox(height: 20),

                          // Drop Off
                          InputFieldWidget(
                            label: "Drop Off Location",
                            hint: "Address, Airport, Hotel",
                            controller: dropOffController,
                          ),
                          const SizedBox(height: 20),

                          // Passengers
                          InputFieldWidget(
                            label: "Passenger",
                            hint: "Number of Passengers",
                            controller: passengerController,
                            inputType: TextInputType.number,
                          ),
                          const SizedBox(height: 20),

                          // Pick Up Date
                          const SectionTitleWidget(title: "Pick Up Date"),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: DateTimeFieldWidget(
                                  label: "Date",
                                  hintText: "03/04/2025",
                                  controller: dateController,
                                  onTap: () => _pickDate(dateController),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: DateTimeFieldWidget(
                                  label: "Time",
                                  hintText: "00 : 00",
                                  controller: timeController,
                                  onTap: () => _pickTime(timeController),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),

                          // Bouton Search
                          SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff97051D),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                // logique de recherche
                              },
                              child: const Text(
                                "Search",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// DEUXIÈME ONGLET : CAR SERVICE
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 20),

                          // Pick Up
                          InputFieldWidget(
                            label: "Pick Up Location",
                            hint: "Address",
                            controller: pickUpController,
                          ),
                          const SizedBox(height: 20),

                          // Pick Up Date
                          const SectionTitleWidget(title: "Pick Up Date"),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: DateTimeFieldWidget(
                                  label: "Date",
                                  hintText: "03/04/2025",
                                  controller: pickUpDateController,
                                  onTap: () => _pickDate(pickUpDateController),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: DateTimeFieldWidget(
                                  label: "Time",
                                  hintText: "00 : 00",
                                  controller: pickUpTimeController,
                                  onTap: () => _pickTime(pickUpTimeController),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),

                          // Return Date
                          const SectionTitleWidget(title: "Return Date"),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: DateTimeFieldWidget(
                                  label: "Date",
                                  hintText: "03/04/2025",
                                  controller: returnDateController,
                                  onTap: () => _pickDate(returnDateController),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: DateTimeFieldWidget(
                                  label: "Time",
                                  hintText: "00 : 00",
                                  controller: returnTimeController,
                                  onTap: () => _pickTime(returnTimeController),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),

                          // Bouton Search
                          SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff97051D),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                // logique de recherche
                              },
                              child: const Text(
                                "Search",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
