import 'package:ajiapp/backend/authentification_functions.dart';
import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CreatepasswordView extends StatefulWidget {
  const CreatepasswordView({super.key});

  @override
  State<CreatepasswordView> createState() => _CreatepasswordViewState();
}

class _CreatepasswordViewState extends State<CreatepasswordView> {
  final TextEditingController _newpwd = TextEditingController();
  final TextEditingController _pwd = TextEditingController();
  final TextEditingController _renewpwd = TextEditingController();
  final GlobalKey<FormState> mykey = GlobalKey();
  bool visiblep = true;
  bool visiblenp = true;
  bool visiblernp = true;
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
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Create New Password',
                        style: TextStyle(
                            fontSize: ScreenSize.width / 17,
                            fontWeight: FontWeight.bold,
                            fontFamily: "SFDisplay"),
                      ),
                      SizedBox(
                        height: ScreenSize.height / 30,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Password*',
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
                            obscureText: visiblep,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              prefixIcon:
                                  Icon(Icons.lock_outline), // Email icon
                              suffixIcon: _pwd.text.isNotEmpty
                                  ? IconButton(
                                      icon: Icon(Icons.visibility),
                                      onPressed: () {
                                        visiblep = !visiblep;
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
                            height: ScreenSize.height / 40,
                          ),
                          Text(
                            'New Password*',
                            style: TextStyle(
                                color: Colors.black45,
                                fontSize: ScreenSize.width / 25),
                          ),
                          SizedBox(
                            height: ScreenSize.height / 120,
                          ),
                          TextFormField(
                            controller: _newpwd,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '*Password Required';
                              }
                              return null;
                            },
                            obscureText: visiblenp,
                            decoration: InputDecoration(
                              labelText: 'New Password',
                              prefixIcon:
                                  Icon(Icons.lock_outline), // Email icon
                              suffixIcon: _newpwd.text.isNotEmpty
                                  ? IconButton(
                                      icon: Icon(Icons.visibility),
                                      onPressed: () {
                                        visiblenp = !visiblenp;
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
                            height: ScreenSize.height / 40,
                          ),
                          Text(
                            'Re-enter New Password*',
                            style: TextStyle(
                                color: Colors.black45,
                                fontSize: ScreenSize.width / 25),
                          ),
                          SizedBox(
                            height: ScreenSize.height / 120,
                          ),
                          TextFormField(
                            controller: _renewpwd,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '*Password Required';
                              } else {
                                if (value != _newpwd.text.trim()) {
                                  return '*Incorrect Password';
                                }
                              }
                              return null;
                            },
                            obscureText: visiblernp,
                            decoration: InputDecoration(
                              labelText: 'Re-enter New Password',
                              prefixIcon:
                                  Icon(Icons.lock_outline), // Email icon
                              suffixIcon: _renewpwd.text.isNotEmpty
                                  ? IconButton(
                                      icon: Icon(Icons.visibility),
                                      onPressed: () {
                                        visiblernp = !visiblernp;
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
                              updateUserPassword(_pwd.text.trim(),
                                  _newpwd.text.trim(), context);
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
                              horizontal: ScreenSize.width / 3.3,
                              vertical: ScreenSize.width / 40), // Button size
                        ),
                        child: Text(
                          "Save",
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
            ),
          ],
        ),
      ),
    ));
  }
}
