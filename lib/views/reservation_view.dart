import 'package:flutter/material.dart';

class ReservationScreen extends StatefulWidget {
  const ReservationScreen({super.key});

  @override
  ReservationScreenState createState() => ReservationScreenState();
}

class ReservationScreenState extends State<ReservationScreen> {
  final _formKey = GlobalKey<FormState>();

  final pickUpController = TextEditingController();
  final dropOffController = TextEditingController();
  final passengerController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final returnDateController = TextEditingController();
  final returnTimeController = TextEditingController();

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

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // final reservationData = {
      //   "Pick Up": pickUpController.text,
      //   "Drop Off": dropOffController.text,
      //   "Passengers": passengerController.text,
      //   "Date": dateController.text,
      //   "Time": timeController.text,
      //   "Return": isReturn ? "Yes" : "No",
      //   if (isReturn) "Return Date": returnDateController.text,
      //   if (isReturn) "Return Time": returnTimeController.text,
      // };
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      padding:
          EdgeInsets.symmetric(horizontal: size.width * 0.05, vertical: 20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const Text(
              "Reservation",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildInputField(
                "Pick Up", "Address, Airport, Hotel", pickUpController),
            const SizedBox(height: 15),
            _buildInputField(
                "Drop Off", "Address, Airport, Hotel", dropOffController),
            const SizedBox(height: 15),
            _buildInputField(
                "Passengers", "Number of Passengers", passengerController,
                keyboardType: TextInputType.number),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(child: _buildDateTimeField("Date", dateController)),
                const SizedBox(width: 10),
                Expanded(child: _buildDateTimeField("Time", timeController)),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Checkbox(
                  value: isReturn,
                  onChanged: (val) => setState(() => isReturn = val ?? false),
                ),
                const Text("I'd like to return"),
              ],
            ),
            if (isReturn) ...[
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(child: Divider(color: Colors.grey)),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text("Return Date",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Expanded(child: Divider(color: Colors.grey)),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                      child: _buildDateTimeField("Date", returnDateController)),
                  const SizedBox(width: 10),
                  Expanded(
                      child: _buildDateTimeField("Time", returnTimeController)),
                ],
              ),
            ],
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[800],
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: _submitForm,
              child: const Text("Search",
                  style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(
      String label, String hint, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text}) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: (value) =>
          value == null || value.trim().isEmpty ? "$label is required" : null,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  Widget _buildDateTimeField(String label, TextEditingController controller) {
    return GestureDetector(
      onTap: () async {
        if (label == "Date") {
          final pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2100),
          );
          if (pickedDate != null && mounted) {
            setState(() => controller.text =
                "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}");
          }
        } else {
          final pickedTime = await showTimePicker(
              context: context, initialTime: TimeOfDay.now());
          if (pickedTime != null && mounted) {
            setState(() => controller.text = pickedTime.format(context));
          }
        }
      },
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        ),
        enabled: false,
      ),
    );
  }
}
