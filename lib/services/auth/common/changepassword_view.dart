import 'package:ajiapp/backend/authentification_functions.dart';
import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Changepassword extends StatefulWidget {
  const Changepassword({super.key});

  @override
  State<Changepassword> createState() => _ChangepasswordState();
}

class _ChangepasswordState extends State<Changepassword> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pwd = TextEditingController();
  final GlobalKey<FormState> mykey = GlobalKey();

  bool visible = true;
  bool remeberme = false;
  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        width: ScreenSize.width,
        height: ScreenSize.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/secondbackground.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SvgPicture.asset("assets/images/ajiapplogo.svg",
                width: ScreenSize.width / 3, height: ScreenSize.width / 3),
            SizedBox(height: ScreenSize.height / 18),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: ScreenSize.width / 15,
                  vertical: ScreenSize.height / 20),
              width: ScreenSize.width,
              height: ScreenSize.height * 0.75,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(ScreenSize.width * 0.1),
                    topRight: Radius.circular(ScreenSize.width * 0.1)),
              ),
              child: Form(
                key: mykey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Change email',
                      style: TextStyle(
                          fontSize: ScreenSize.width / 17,
                          fontWeight: FontWeight.bold,
                          fontFamily: "SFDisplay"),
                    ),
                    SizedBox(
                      height: ScreenSize.height / 20,
                    ),
                    Text(
                      'Please Enter Your new Email Address To \nRecieve a Verification Code',
                      style: TextStyle(
                          color: Colors.black, fontSize: ScreenSize.width / 25),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: ScreenSize.height / 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'New Email Address*',
                          style: TextStyle(
                              color: Colors.black45,
                              fontSize: ScreenSize.width / 25),
                        ),
                        SizedBox(
                          height: ScreenSize.height / 120,
                        ),
                        TextFormField(
                          controller: _email,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '*E-mail Required';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'New Email Address',
                            prefixIcon:
                                Icon(Icons.email_outlined), // Email icon
                            suffixIcon: _email.text.isNotEmpty
                                ? IconButton(
                                    icon: Icon(Icons.clear),
                                    onPressed: () {
                                      _email.clear();
                                      setState(() {});
                                    },
                                  )
                                : null,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.black),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: ScreenSize.height / 65,
                        ),
                        Text(
                          'Current Password*',
                          style: TextStyle(
                              color: Colors.black45,
                              fontSize: ScreenSize.width / 25),
                        ),
                        SizedBox(
                          height: ScreenSize.height / 120,
                        ),
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
                            prefixIcon: Icon(Icons.lock_outline), // Email icon
                            suffixIcon: _pwd.text.isNotEmpty
                                ? IconButton(
                                    icon: Icon(Icons.visibility),
                                    onPressed: () {
                                      visible = !visible;
                                      setState(() {});
                                    },
                                  )
                                : null,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: ScreenSize.height / 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (mykey.currentState!.validate()) {
                          setState(() {
                            changeEmail(
                                _email.text.trim(), _pwd.text.trim(), context);
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ajired, // Custom color
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(20.0), // Rounded edges
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: ScreenSize.width / 4,
                            vertical: ScreenSize.width / 40), // Button size
                      ),
                      child: Text(
                        "Continue",
                        style: TextStyle(
                          color: Colors.white, // White text
                          fontSize: ScreenSize.width / 20, // Text size
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: ScreenSize.height / 60,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white, // Custom color
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(20.0), // Rounded edges
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: ScreenSize.width / 3.6,
                            vertical: ScreenSize.width / 40), // Button size
                      ),
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          color: ajired, // White text
                          fontSize: ScreenSize.width / 20, // Text size
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
