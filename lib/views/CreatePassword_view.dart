import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class CreatepasswordView extends StatefulWidget {
  const CreatepasswordView({super.key});

  @override
  State<CreatepasswordView> createState() => _CreatepasswordViewState();
}

class _CreatepasswordViewState extends State<CreatepasswordView> {
  TextEditingController _email = TextEditingController();
  TextEditingController _pwd = TextEditingController();

  bool visible = true;
  bool remeberme = false;
  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return Scaffold(
        body: Container(
      width: ScreenSize.width,
      height: ScreenSize.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background1.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Image(image: Svg("assets/images/logobig.svg")),
          SizedBox(height: ScreenSize.height / 15),
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
                  height: ScreenSize.height / 30,),
                  Text('Enter Your New Password ',style: TextStyle(color: Colors.black,fontSize: ScreenSize.width/25),textAlign: TextAlign.center,),
                SizedBox(
                  height: ScreenSize.height / 40,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Email Address*',style: TextStyle(color: Colors.black45,fontSize: ScreenSize.width/25),),
                    SizedBox(height: ScreenSize.height / 120,),
                    SizedBox(
                      height: ScreenSize.height / 20,
                      child: TextField(
                        controller: _email,
                        decoration: InputDecoration(
                          labelText: 'Email Address',
                          prefixIcon: Icon(Icons.email_outlined), // Email icon
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
                    ),
                    SizedBox(height: ScreenSize.height / 40,),
                    Text('Password*',style: TextStyle(color: Colors.black45,fontSize: ScreenSize.width/25),),
                    SizedBox(height: ScreenSize.height / 120,),
                    SizedBox(
                      height: ScreenSize.height / 20,
                      child: TextField(
                        controller: _pwd,
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
                    ),
                    
                  ],
                ),
                SizedBox(
                  height: ScreenSize.height / 20,),
              
          ElevatedButton(
      onPressed: () {
        // Action when button is pressed
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: ajired, // Custom color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0), // Rounded edges
        ),
        padding: EdgeInsets.symmetric(horizontal: ScreenSize.width/3.3, vertical: ScreenSize.width/40), // Button size
      ),
      child: Text(
        "Save",
        style: TextStyle(
          color: Colors.white, // White text
          fontSize: ScreenSize.width/20, // Text size
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    SizedBox(
                  height: ScreenSize.height / 60,),
    ElevatedButton(
      onPressed: () {
      Navigator.pop(context);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white, // Custom color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0), // Rounded edges
        ),
        padding: EdgeInsets.symmetric(horizontal: ScreenSize.width/3.6, vertical: ScreenSize.width/40), // Button size
      ),
      child: Text(
        "Cancel",
        style: TextStyle(
          color: ajired, // White text
          fontSize: ScreenSize.width/20, // Text size
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    
              ],
            ),
          ),
        ],
      ),
    ));
  }
}