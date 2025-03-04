import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

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
      body: SingleChildScrollView(
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
                      Image(image: Svg("assets/images/logowhite.svg"),),
                      SizedBox(width: ScreenSize.width/25,),
                      Text("Coming Up", style: TextStyle(
                        color: Colors.white,
                        fontSize:ScreenSize.width/13.5,
                        fontWeight: FontWeight.bold
                      ),)
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: ScreenSize.height/60,),
          
          ],
        ),
      )
    );
  }
}