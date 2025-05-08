import 'package:ajiapp/settings/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class CallWidget extends StatelessWidget {
  final String name;
  final String? img;
  final String number;
  const CallWidget(
      {super.key, required this.name, this.img, required this.number});

 Future<void> _launchDialer(String number) async {
    final Uri dialUri = Uri(scheme: 'tel', path: number);
    if (await canLaunchUrl(dialUri)) {
      await launchUrl(dialUri);
    } else {
      throw 'Could not launch $dialUri';
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GestureDetector(
      onTap: () {
        _launchDialer(number);
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
        child: img == null
            ? Center(
                child: Text(
                  name,
                  style: TextStyle(
                    fontSize: SizeConfig.getBlockSizeHorizontal(6),
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name,
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
                    img!,
                  ),
                ],
              ),
      ),
    );
  }
}
