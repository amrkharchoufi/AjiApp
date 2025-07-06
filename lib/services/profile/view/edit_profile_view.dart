import 'package:ajiapp/services/profile/controller/profile_controller.dart';
import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final ProfileController controller = Get.put(ProfileController());
  final TextEditingController _username = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final GlobalKey<FormState> mykey = GlobalKey();
  bool visible = true;
  bool remeberme = false;
  String? selectedCountry;
  @override
  void initState() {
    _username.text = controller.currentuser.name;
    _phone.text = controller.currentuser.phone;
    if (controller.currentuser.country != "unknown") {
      selectedCountry = controller.currentuser.country;
    }
    super.initState();
  }

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
                      'Edit profile',
                      style: TextStyle(
                          fontSize: ScreenSize.width / 17,
                          fontWeight: FontWeight.bold,
                          fontFamily: "SFDisplay"),
                    ),
                    SizedBox(
                      height: ScreenSize.height / 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Username*',
                          style: TextStyle(
                              color: Colors.black45,
                              fontSize: ScreenSize.width / 25),
                        ),
                        SizedBox(
                          height: ScreenSize.height / 120,
                        ),
                        TextFormField(
                          controller: _username,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '*Username Required';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Username',
                            prefixIcon:
                                Icon(Icons.email_outlined), // Email icon
                            suffixIcon: _username.text.isNotEmpty
                                ? IconButton(
                                    icon: Icon(Icons.clear),
                                    onPressed: () {
                                      _username.clear();
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
                          'Phone number*',
                          style: TextStyle(
                              color: Colors.black45,
                              fontSize: ScreenSize.width / 25),
                        ),
                        SizedBox(
                          height: ScreenSize.height / 120,
                        ),
                        TextFormField(
                          controller: _phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '*phone number Required';
                            }
                            return null;
                          },
                          obscureText: visible,
                          decoration: InputDecoration(
                            labelText: 'Phone number',
                            prefixIcon: Icon(Icons.lock_outline), // Email icon
                            suffixIcon: _phone.text.isNotEmpty
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
                        SizedBox(
                          height: ScreenSize.height / 65,
                        ),
                        Text(
                          'Country*',
                          style: TextStyle(
                              color: Colors.black45,
                              fontSize: ScreenSize.width / 25),
                        ),
                        SizedBox(
                          height: ScreenSize.height / 120,
                        ),
                        DropdownButtonFormField<String>(
                          value: selectedCountry,
                          decoration: InputDecoration(
                            labelText: 'Country',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          hint: Text('Select a country'),
                          items: controller.countries.map((country) {
                            return DropdownMenuItem<String>(
                              value: country,
                              child: Text(country),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() => selectedCountry = value!);
                          },
                          validator: (value) =>
                              value == null ? 'Please select a country' : null,
                        ),
                        const SizedBox(height: 15),
                      ],
                    ),
                    SizedBox(
                      height: ScreenSize.height / 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (mykey.currentState!.validate()) {
                          setState(() {
                            controller.Updateuser(_username.text.trim(),
                                _phone.text.trim(), selectedCountry!, context);
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
                            horizontal: ScreenSize.width / 5,
                            vertical: ScreenSize.width / 40), // Button size
                      ),
                      child: Text(
                        "Save changes",
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
                        Get.back();
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
