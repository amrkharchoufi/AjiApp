import 'package:ajiapp/settings/size.dart';
import 'package:ajiapp/views/accomodation_service/accomodation_view.dart';
import 'package:ajiapp/views/common/available_soon.dart';
import 'package:ajiapp/views/e-sim_service/e-sim_view.dart';
import 'package:ajiapp/views/followyourteam_service/view/follow_your_team_view.dart';
import 'package:ajiapp/views/food_service/food_view.dart.dart';
import 'package:ajiapp/views/contacts_service/importantct_view.dart';
import 'package:ajiapp/views/transport_service/transportation_view.dart';
import 'package:ajiapp/views/visa_service/visa_view.dart';
import 'package:ajiapp/views/tourisme_service/visit_morroco_view.dart';
import 'package:ajiapp/widgets/service_widget.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';


class ServicesWidget extends StatelessWidget {
  final double? rownb;
   const ServicesWidget({super.key, this.rownb});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    List<Widget> Services=[
    GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => VisitMorrocoView(),
                ),
              );
            },
            child: ServiceWidget( 
              golden: false,
              width: ScreenSize.width / 3.7,
              height: ScreenSize.width / 3.7,
              text: "Visit Morocco",
              customzie: SizeConfig.getBlockSizeHorizontal(6),
              img: 
                "assets/icons/visit_icon.svg",
            
            ),
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
              golden: false,
              width: ScreenSize.width / 3.7,
              height: ScreenSize.width / 3.7,
              text: "Visa",
              
              img: 
                "assets/icons/visa_icon.svg",
              
            ),
          ),
            GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => FollowYourTeamView(),
                ),
              );
            },
            child: ServiceWidget(
              golden: false,
              width: ScreenSize.width / 3.7,
              height: ScreenSize.width / 3.7,
              text: "Follow your\n team",
            
              img: 
                "assets/icons/ball_icon.svg",
              
            ),
          ),
      
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => EsimView(),
                ),
              );
            },
            child: ServiceWidget(
              golden: false,
                width: ScreenSize.width / 3.7,
                height: ScreenSize.width / 3.7,
                text: "E-sim",
                
                img: 
                  "assets/icons/Phone.svg",
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
              golden: false,
              width: ScreenSize.width / 3.7,
              height: ScreenSize.width / 3.7,
              text: "Hotels",
              
              img: "assets/icons/hotelicon.svg",
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ImportantctView(),
                ),
              );
            },
            child: ServiceWidget(
              golden: false,
              width: ScreenSize.width / 3.7,
              height: ScreenSize.width / 3.7,
              text: "Important\nContacts",
            
              img: "assets/icons/contact_icon.svg",
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
              golden: false,
              width: ScreenSize.width / 3.7,
              height: ScreenSize.width / 3.7,
              text: "Food",
          customzie: SizeConfig.getBlockSizeHorizontal(9.5),
              img: "assets/icons/food.svg",
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
                golden: false,
                width: ScreenSize.width / 3.7,
                height: ScreenSize.width / 3.7,
                text: "Tickets",
                customzie: SizeConfig.getBlockSizeHorizontal(9),
                img: 
                  "assets/icons/ticket_icon.svg",
                
              )),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Transportationview(),
                ),
              );
            },
            child: ServiceWidget(
              golden: false,
              width: ScreenSize.width / 3.7,
              height: ScreenSize.width / 3.7,
              text: "Transportation",
             customzie: SizeConfig.getBlockSizeHorizontal(9),
              img: "assets/icons/car_icon.svg"
            ),
          ),
      
  ];
    return FadeInUp(
      duration: Duration(milliseconds: 1600),
      child: Wrap(
        direction: Axis.horizontal,
        spacing: ScreenSize.width / 25,
        runSpacing: ScreenSize.width / 25,
        children: [
          for(int i=0;i<rownb!*3;i++)...[
            Services[i],
          ]
        ]
      ),
    );
  }
}
