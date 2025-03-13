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
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ServiceView extends StatefulWidget {
  const ServiceView({super.key});

  @override
  State<ServiceView> createState() => _ServiceViewState();
}

class _ServiceViewState extends State<ServiceView> {
  @override
Widget build(BuildContext context) {
    ScreenSize.init(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications,color: ajired,  size: ScreenSize.width / 13,),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.account_circle_outlined,
                        color: ajired,size: ScreenSize.width / 12,),
          ),
        ],
      ),
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
              Stack(
                children: [
                  Image.asset("assets/images/shape.png",
                  width: ScreenSize.width,
                    fit: BoxFit.fitWidth,
                  ),
                  Positioned(
                    left: ScreenSize.width/20,
                    top: ScreenSize.height/20,
                    child: Row(
                      children: [
                        SvgPicture.asset("assets/images/logowhite.svg"),
                        SizedBox(width: ScreenSize.width/25,),
                        Text("Services", style: TextStyle(
                          color: Colors.white,
                          fontSize:ScreenSize.width/13.5,
                          fontWeight: FontWeight.bold
                        ),)
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: ScreenSize.height/10,),
              FadeInUp(
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
                          img: SvgPicture.asset("assets/icons/Phone.svg")),
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
                          img: SvgPicture.asset("assets/icons/Visa_icon.svg",width: ScreenSize.width/15,
                          color: ajired,),
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
                          img:SvgPicture.asset("assets/icons/Ticket_icon.svg",width: ScreenSize.width/13,
                          color: ajired,),
                          
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
                          img:  SvgPicture.asset("assets/icons/flight_icon.svg",width: ScreenSize.width/15,
                          color: ajired,),
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
                          img: SvgPicture.asset("assets/icons/Home.svg"),
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
                          img:  SvgPicture.asset("assets/icons/visit_icon.svg"),
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
                          img:SvgPicture.asset("assets/icons/food.svg"),
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
              ),
            
            ],
          ),
        ),
      )
    );
  }
}