import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:ajiapp/views/accomodation_view.dart';
import 'package:ajiapp/views/available_soon.dart';
import 'package:ajiapp/views/e-sim_view.dart';
import 'package:ajiapp/views/food_view.dart.dart';
import 'package:ajiapp/views/transportation_view.dart';
import 'package:ajiapp/views/visa_view.dart';
import 'package:ajiapp/views/visit_morroco_view.dart';
import 'package:ajiapp/widgets/service_widget.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ServicesWidget extends StatelessWidget {
  const ServicesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      duration: Duration(milliseconds: 1600),
      child: Wrap(
        direction: Axis.horizontal,
        spacing: ScreenSize.width / 25,
        runSpacing: ScreenSize.width / 25,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => EsimView(),
                ),
              );
            },
            child: ServiceWidget(
                width: ScreenSize.width / 3.7,
                height: ScreenSize.width / 3.7,
                text: "e-sim",
                imgicon: false,
                icon: Icons.call_outlined,
                img: SvgPicture.asset(
                  "assets/icons/Phone.svg",
                  width: ScreenSize.width / 12,
                )),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => VisaView(),
                ),
              );
            },
            child: ServiceWidget(
              width: ScreenSize.width / 3.7,
              height: ScreenSize.width / 3.7,
              text: "Visa",
              imgicon: false,
              icon: Icons.call_outlined,
              img: SvgPicture.asset(
                "assets/icons/Visa_icon.svg",
                width: ScreenSize.width / 14,
                color: ajired,
              ),
            ),
          ),
          GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AvailableSoon(),
                  ),
                );
              },
              child: ServiceWidget(
                width: ScreenSize.width / 3.7,
                height: ScreenSize.width / 3.7,
                text: "Tickets",
                imgicon: false,
                icon: Icons.call_outlined,
                img: SvgPicture.asset(
                  "assets/icons/Ticket_icon.svg",
                  width: ScreenSize.width / 17,
                  color: ajired,
                ),
              )),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AvailableSoon(),
                ),
              );
            },
            child: ServiceWidget(
              width: ScreenSize.width / 3.7,
              height: ScreenSize.width / 3.7,
              text: "Flights",
              imgicon: false,
              icon: Icons.call_outlined,
              img: SvgPicture.asset(
                "assets/icons/flight_icon.svg",
                color: ajired,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AccomodationView(),
                ),
              );
            },
            child: ServiceWidget(
              width: ScreenSize.width / 3.7,
              height: ScreenSize.width / 3.7,
              text: "Accommodation",
              imgicon: false,
              icon: FontAwesomeIcons.house,
              img: SvgPicture.asset("assets/icons/home_service_icon.svg"),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Transportationview(),
                ),
              );
            },
            child: ServiceWidget(
              width: ScreenSize.width / 3.7,
              height: ScreenSize.width / 3.7,
              text: "Transportation",
              imgicon: false,
              icon: Icons.call_outlined,
              img: SvgPicture.asset("assets/icons/car_icon.svg"),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => VisitMorrocoView(),
                ),
              );
            },
            child: ServiceWidget(
              width: ScreenSize.width / 3.7,
              height: ScreenSize.width / 3.7,
              text: "Visit Morocco",
              imgicon: false,
              icon: Icons.call_outlined,
              img: SvgPicture.asset(
                "assets/icons/visit_icon.svg",
                width: ScreenSize.width / 17,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => FoodHomePage(),
                ),
              );
            },
            child: ServiceWidget(
              width: ScreenSize.width / 3.7,
              height: ScreenSize.width / 3.7,
              text: "Food",
              imgicon: false,
              icon: Icons.call_outlined,
              img: SvgPicture.asset("assets/icons/food.svg"),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AvailableSoon(),
                ),
              );
            },
            child: ServiceWidget(
              width: ScreenSize.width / 3.7,
              height: ScreenSize.width / 3.7,
              text: "Important\nContacts",
              imgicon: false,
              icon: Icons.call_outlined,
              img: SvgPicture.asset("assets/icons/alert.svg"),
            ),
          )
        ],
      ),
    );
  }
}
