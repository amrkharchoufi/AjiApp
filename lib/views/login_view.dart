import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:ajiapp/views/ClientSpace.dart';
import 'package:ajiapp/views/SignUp_view.dart';
import 'package:ajiapp/views/forgotpassword_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
            height: ScreenSize.height * 0.65,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(ScreenSize.width * 0.1),
                  topRight: Radius.circular(ScreenSize.width * 0.1)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Login with email address',
                  style: TextStyle(
                      fontSize: ScreenSize.width / 17,
                      fontWeight: FontWeight.bold,
                      fontFamily: "SFDisplay"),
                ),
                SizedBox(
                  height: ScreenSize.height / 40,
                ),
                TextField(
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
                TextField(
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(
                      activeColor: ajired,
                      value: remeberme,
                      onChanged: (bool? value) {
                        remeberme = value!;
                        setState(() {});
                      }),
                  Text('Remember me',style: TextStyle(color: Colors.black45),)
                ],
              ),
              TextButton(onPressed: () { 
                Navigator.push(context,MaterialPageRoute(builder: (context)=>ForgotpasswordView()),);
               },
              child: Text('Forgot Password?',style: TextStyle(color: ajired),)),
            ],
          ),
          ElevatedButton(
      onPressed: () {
        Navigator.pop(context);
        Navigator.push( context, MaterialPageRoute(builder: (context) => Clientspace()),);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: ajired, // Custom color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0), // Rounded edges
        ),
        padding: EdgeInsets.symmetric(horizontal: ScreenSize.width/4, vertical: ScreenSize.width/28), // Button size
      ),
      child: Text(
        "Continue",
        style: TextStyle(
          color: Colors.white, // White text
          fontSize: ScreenSize.width/20, // Text size
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Doesn't have an account?",style: TextStyle(color: Colors.black45,fontSize: ScreenSize.width/35),),
        TextButton(onPressed: (){
          Navigator.push( context, MaterialPageRoute(builder: (context) => SignupView()),);
        }, child: Text('Sign Up',style: TextStyle(color: ajired,fontSize: ScreenSize.width/35),))
      ],
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          width: ScreenSize.width/3,
          child: Divider()),
        Text('or',style: TextStyle(color: Colors.black45),),
        SizedBox(
          width: ScreenSize.width/3,
          child: Divider()),
      ],
    ),
    TextButton(onPressed: (){}, child: Text('Login with Google Account',style: TextStyle(color: ajired,fontSize: ScreenSize.width/35),))
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
