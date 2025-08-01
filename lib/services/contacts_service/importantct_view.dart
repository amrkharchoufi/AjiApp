import 'package:ajiapp/settings/size.dart';
import 'package:ajiapp/widgets/call_widget.dart';
import 'package:ajiapp/widgets/myappbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class ImportantctView extends StatelessWidget {
  const ImportantctView({super.key});
  Future<void> launchurl() async {
    final url = 'https://ajiapp.com/';

    await launch(url);
  }

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
        physics: const ClampingScrollPhysics(),
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 8),
                    child: GestureDetector(
                      onTap: () {
                        launchurl();
                      },
                      child: Container(
                        width: double.infinity,
                        height: SizeConfig.getBlockSizeVertical(7.5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              // ignore: deprecated_member_use
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 2,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Contact",
                              style: TextStyle(
                                fontSize: SizeConfig.getBlockSizeHorizontal(6),
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              width: SizeConfig.getBlockSizeHorizontal(1.5),
                            ),
                            SvgPicture.asset(
                              "assets/icons/aji_icon.svg",
                            ),
                          ],
                        ),
                      ),
                    )),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                  child: CallWidget(name: 'Police', number: "19"),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                  child: CallWidget(name: 'Ambulance', number: "150"),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                  child: CallWidget(name: 'Fire Fighters', number: "15"),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                  child: CallWidget(name: 'Embassies', number: "177"),
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
