import 'package:ajiapp/widgets/date_time_field_widget.dart';
import 'package:ajiapp/widgets/input_field_widget.dart';
import 'package:ajiapp/widgets/section_title_widget.dart';
import 'package:flutter/material.dart';

class CityToCityScreen extends StatefulWidget {
  const CityToCityScreen({super.key});

  @override
  CityToCityScreenState createState() => CityToCityScreenState();
}

class CityToCityScreenState extends State<CityToCityScreen> {
  // Text controllers
  final pickUpController = TextEditingController();
  final dropOffController = TextEditingController();
  final passengerController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final returnDateController = TextEditingController();
  final returnTimeController = TextEditingController();

  // Track if user wants a return trip
  bool isReturn = false;

  @override
  void dispose() {
    pickUpController.dispose();
    dropOffController.dispose();
    passengerController.dispose();
    dateController.dispose();
    timeController.dispose();
    returnDateController.dispose();
    returnTimeController.dispose();
    super.dispose();
  }

  // Méthode pour choisir la date
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

  // Méthode pour choisir l’heure
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
    return Column(
      children: [
        // Titre principal (optionnel selon votre UI)
        const SizedBox(height: 16),

        Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: const Color.fromARGB(84, 158, 158, 158),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color:
                    Colors.black.withAlpha((0.1 * 255).toInt()), // 10% opacity
                blurRadius: 6,
                offset: const Offset(0, 3),
              )
            ],
          ),
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                const SizedBox(height: 10),
                const Text(
                  "Reservation",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),

                // Pick Up Location
                InputFieldWidget(
                  label: "Pick Up Location",
                  hint: "Address, Airport, Hotel",
                  controller: pickUpController,
                ),
                const SizedBox(height: 20),

                // Drop Off Location
                InputFieldWidget(
                  label: "Drop Off Location",
                  hint: "Address, Airport, Hotel",
                  controller: dropOffController,
                ),
                const SizedBox(height: 20),

                // Passenger
                InputFieldWidget(
                  label: "Passenger",
                  hint: "Number Of Passengers",
                  controller: passengerController,
                ),
                const SizedBox(height: 20),

                // Section Title: Pick Up Date
                const SectionTitleWidget(title: "Pick Up Date"),
                const SizedBox(height: 10),

                // Row for Date & Time
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

                const SizedBox(height: 10),

                // Checkbox Row
                Row(
                  children: [
                    Checkbox(
                      value: isReturn,
                      onChanged: (val) {
                        setState(() => isReturn = val ?? false);
                      },
                    ),
                    const Text("I'd like to return"),
                  ],
                ),

                // Conditionally show "Return Date" section
                if (isReturn) ...[
                  const SizedBox(height: 10),
                  const SectionTitleWidget(title: "Return Date"),
                  const SizedBox(height: 10),
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
                ],

                const SizedBox(height: 20),

                // Search Button
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
                      // Implement search logic
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
        ),
      ],
    );
  }
}
