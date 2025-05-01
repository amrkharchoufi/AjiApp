import 'package:flutter/material.dart';

class buildDateTimeField extends StatefulWidget {
  const buildDateTimeField({super.key});

  @override
  DateTimeFieldWidgetState createState() => DateTimeFieldWidgetState();
}

class DateTimeFieldWidgetState extends State<buildDateTimeField> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  Widget _buildDateTimeField(
    String label,
    String hintText,
    TextEditingController controller,
  ) {
    return GestureDetector(
      onTap: () async {
        if (label == "Date") {
          // Show Date Picker
          DateTime? pickedDate = await showDatePicker(
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
        } else {
          // Show Time Picker
          TimeOfDay? pickedTime = await showTimePicker(
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
      },
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: label,
          hintText: hintText,
          labelStyle: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        ),
        enabled: false, // Prevent direct typing
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildDateTimeField("Date", "Select Date", _dateController),
        SizedBox(height: 20),
        _buildDateTimeField("Time", "Select Time", _timeController),
      ],
    );
  }
}
