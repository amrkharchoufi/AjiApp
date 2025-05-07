import 'package:ajiapp/settings/size.dart';
import 'package:ajiapp/widgets/call_widget.dart';
import 'package:ajiapp/widgets/myappbar_widget.dart';
import 'package:flutter/material.dart';

class ImportantctView extends StatelessWidget {
  const ImportantctView({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return Scaffold(
        body: Container(
          width: ScreenSize.width,
          height: ScreenSize.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                MyappbarWidget(
                  title: "Important Contacts",
                ),
                SizedBox(
                  height: ScreenSize.height / 15,
                ),
                Column(
                  children: [
                    Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 8),
                    child: CallWidget(name: 'Contact',img: "assets/icons/aji_icon.svg",number: "0661777073",),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 8),
                    child: CallWidget(name: 'Police',number: "19"),
                  ),
                  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 8),
                    child: CallWidget(name: 'Ambulance',number: "150"),
                  ),
                  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 8),
                    child: CallWidget(name: 'Fire Fighters',number: "15"),
                  ),
                  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 8),
                    child: CallWidget(name: 'Embassies',number: "177"),
                  ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}