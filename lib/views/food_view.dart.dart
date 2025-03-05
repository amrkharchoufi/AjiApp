import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import '../widgets/featured_section.dart';
import '../widgets/delivery_section.dart';
import '../widgets/restaurant_section.dart';

class FoodHomePage extends StatelessWidget {
  const FoodHomePage({super.key});

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
          ),),
          child:SingleChildScrollView(
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
                          Text("Food", style: TextStyle(
                            color: Colors.white,
                            fontSize:ScreenSize.width/13.5,
                            fontWeight: FontWeight.bold
                          ),)
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: ScreenSize.height/150,),
                
                SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FeaturedSection(),
                        DeliverySection(),
                        RestaurantSection(),
                        const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Center(
                            child: Text("Version 1.1.2", style: TextStyle(color: Colors.grey)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),)
    );
  }
}
