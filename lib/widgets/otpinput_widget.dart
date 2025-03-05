import 'package:ajiapp/settings/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OTPInputField extends StatefulWidget {
  final int length;
  final Function(String)? onCompleted;

  const OTPInputField({Key? key, this.length = 4, this.onCompleted}) : super(key: key);

  @override
  _OTPInputFieldState createState() => _OTPInputFieldState();
}

class _OTPInputFieldState extends State<OTPInputField> {
  late List<TextEditingController> controllers;
  late List<FocusNode> focusNodes;

  @override
  void initState() {
    super.initState();
    controllers = List.generate(widget.length, (index) => TextEditingController());
    focusNodes = List.generate(widget.length, (index) => FocusNode());
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onChanged(String value, int index) {
    if (value.isNotEmpty) {
      if (index < widget.length - 1) {
        FocusScope.of(context).requestFocus(focusNodes[index + 1]);
      } else {
        focusNodes[index].unfocus(); // Close keyboard on last input
        _submitOTP();
      }
    }
  }

  void _onBackspace(String value, int index) {
    if (value.isEmpty && index > 0) {
      FocusScope.of(context).requestFocus(focusNodes[index - 1]);
    }
  }

  void _submitOTP() {
    String otp = controllers.map((controller) => controller.text).join();
    if (widget.onCompleted != null) {
      widget.onCompleted!(otp);
    }
  }

  Widget _buildNumberBox(int index) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 5),
    width: 50,
    height: 60,
    decoration: BoxDecoration(
      border: Border.all(color: ajired),
      borderRadius: BorderRadius.circular(10),
    ),
    child: RawKeyboardListener( // Wrap with RawKeyboardListener
      focusNode: FocusNode(), // Need a focus node to listen for keys
      onKey: (event) {
        if (event.logicalKey == LogicalKeyboardKey.backspace &&
            controllers[index].text.isEmpty &&
            index > 0) {
          FocusScope.of(context).requestFocus(focusNodes[index - 1]);
        }
      },
      child: TextFormField(
        controller: controllers[index],
        focusNode: focusNodes[index],
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 24),
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: InputDecoration(
          counterText: "", // Hide counter
          border: InputBorder.none,
        ),
        onChanged: (value) => _onChanged(value, index),
        onTap: () => controllers[index].selection = TextSelection.fromPosition(
          TextPosition(offset: controllers[index].text.length),
        ),
        onEditingComplete: () => FocusScope.of(context).unfocus(),
        onFieldSubmitted: (value) => _onChanged(value, index),
      ),
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.length, (index) => _buildNumberBox(index)),
    );
  }
}
