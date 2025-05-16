import 'package:ajiapp/backend/authentification_functions.dart';
import 'package:ajiapp/services/auth/login/controller/login_controller.dart';
import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:ajiapp/services/auth/common/forgotpassword_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LoginBottomSheetView extends StatefulWidget {
  const LoginBottomSheetView({super.key});

  @override
  State<LoginBottomSheetView> createState() => _LoginBottomSheetViewState();
}

class _LoginBottomSheetViewState extends State<LoginBottomSheetView> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pwd = TextEditingController();
  final GlobalKey<FormState> mykey = GlobalKey();
  bool visible = true;
  bool rememberMe = false;

  @override
  void initState() {
    loadSavedCredentials(_email, _pwd);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.put(LoginController());
    ScreenSize.init(context);
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: ScreenSize.width / 15,
              vertical: ScreenSize.height / 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset("assets/images/ajiapplogo.svg",
                  width: ScreenSize.width / 3, height: ScreenSize.width / 3),
              const SizedBox(height: 10),
              Text(
                'Login with email address',
                style: TextStyle(
                  fontSize: ScreenSize.width / 17,
                  fontWeight: FontWeight.bold,
                  fontFamily: "SFDisplay",
                ),
              ),
              const SizedBox(height: 10),
              Form(
                key: mykey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _email,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '*E-mail Required';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Email Address',
                        prefixIcon: const Icon(Icons.email_outlined),
                        suffixIcon: _email.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  _email.clear();
                                  setState(() {});
                                },
                              )
                            : null,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: _pwd,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '*Password Required';
                        }
                        return null;
                      },
                      obscureText: visible,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                                activeColor: ajired,
                                value: rememberMe,
                                onChanged: (bool? value) {
                                  setState(() {
                                    rememberMe = value ?? false;
                                  });
                                }),
                            const Text(
                              'Remember me',
                              style: TextStyle(color: Colors.black45),
                            )
                          ],
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ForgotpasswordView()),
                            );
                          },
                          child: Text('Forgot Password?',
                              style: TextStyle(color: ajired)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        if (mykey.currentState!.validate()) {
                          login(context, _email.text.trim(), _pwd.text.trim(),
                              rememberMe);
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Doesn't have an account?",
                            style: TextStyle(color: Colors.black45)),
                        TextButton(
                          onPressed: () {
                            controller.showLoginBottomSheet(context);
                          },
                          child:
                              Text('Sign Up', style: TextStyle(color: ajired)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Expanded(child: Divider()),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text('or',
                              style: TextStyle(color: Colors.black45)),
                        ),
                        const Expanded(child: Divider()),
                      ],
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () {
                        loginWithGoogle(context);
                      },
                      child: Text('Login with Google Account',
                          style: TextStyle(color: ajired)),
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
}
