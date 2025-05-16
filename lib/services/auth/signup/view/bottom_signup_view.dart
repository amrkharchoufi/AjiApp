import 'package:ajiapp/backend/authentification_functions.dart';
import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignupBottomSheetView extends StatefulWidget {
  const SignupBottomSheetView({super.key});

  @override
  State<SignupBottomSheetView> createState() => _SignupBottomSheetViewState();
}

class _SignupBottomSheetViewState extends State<SignupBottomSheetView> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pwd = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool visible = true;

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenSize.width / 15,
            vertical: ScreenSize.height / 30,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset("assets/images/ajiapplogo.svg",
                  width: ScreenSize.width / 3, height: ScreenSize.width / 3),
              const SizedBox(height: 10),
              Text(
                'Create an account',
                style: TextStyle(
                  fontSize: ScreenSize.width / 17,
                  fontWeight: FontWeight.bold,
                  fontFamily: "SFDisplay",
                ),
              ),
              const SizedBox(height: 10),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildTextField(
                      label: 'Username',
                      controller: _username,
                      icon: Icons.account_circle_outlined,
                      validatorText: '*Username required',
                    ),
                    const SizedBox(height: 15),
                    _buildTextField(
                      label: 'Phone number',
                      controller: _phone,
                      icon: Icons.phone_outlined,
                      validatorText: '*Phone number required',
                    ),
                    const SizedBox(height: 15),
                    _buildTextField(
                      label: 'Email Address',
                      controller: _email,
                      icon: Icons.email_outlined,
                      validatorText: '*Email required',
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: _pwd,
                      obscureText: visible,
                      validator: (value) {
                        if (value == null || value.length < 6) {
                          return '*Password must be at least 6 characters';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: Icon(visible
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              visible = !visible;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          signup(
                            context,
                            _email.text.trim(),
                            _pwd.text.trim(),
                            _username.text.trim(),
                            _phone.text.trim(),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ajired,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: ScreenSize.width / 4,
                            vertical: ScreenSize.width / 28),
                      ),
                      child: Text(
                        "Continue",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenSize.width / 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: ScreenSize.width / 3.6,
                            vertical: ScreenSize.width / 40),
                      ),
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          color: ajired,
                          fontSize: ScreenSize.width / 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    required String validatorText,
  }) {
    return TextFormField(
      controller: controller,
      validator: (value) =>
          value == null || value.isEmpty ? validatorText : null,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        suffixIcon: controller.text.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  controller.clear();
                  setState(() {});
                },
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
