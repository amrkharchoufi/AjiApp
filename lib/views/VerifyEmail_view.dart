import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:ajiapp/widgets/otpinput_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class VerifyemailView extends StatefulWidget {
  const VerifyemailView({super.key});

  @override
  State<VerifyemailView> createState() => _VerifyemailViewState();
}

class _VerifyemailViewState extends State<VerifyemailView> {
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Verify your Email',
                  style: TextStyle(
                      fontSize: ScreenSize.width / 17,
                      fontWeight: FontWeight.bold,
                      fontFamily: "SFDisplay"),
                ),
                SizedBox(
                  height: ScreenSize.height / 20,
                ),
                Text(
                  'Please Enter The 4 Digit Code Sent To\n admin@gmail.com',
                  style: TextStyle(
                      color: Colors.black, fontSize: ScreenSize.width / 25),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: ScreenSize.height / 15,
                ),
                OTPInputField(
                  length: 4,
                  onCompleted: (value) {
                    // Action to be taken after input is completed
                  },
                ),
                SizedBox(
                  height: ScreenSize.height / 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    // Action when button is pressed
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
        ],
      ),
    ));
  }
}
