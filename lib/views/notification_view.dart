import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:flutter/material.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
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
        padding: EdgeInsets.all(ScreenSize.width/20),
        width: ScreenSize.width,
        height: ScreenSize.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Your Notification", style: TextStyle(
              color: green,
              fontSize:ScreenSize.width/13.5,
              fontWeight: FontWeight.bold
            ),),
            SizedBox(height: ScreenSize.width/20,),
            Stack(
              children:[ Container(
                padding: EdgeInsets.all(ScreenSize.width/20),
                width: ScreenSize.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Text("Your flight is in 2 days, don’t forget to get your e-sim", style: TextStyle(
                  color: Colors.black,
                  fontSize:ScreenSize.width/25,
                ),),
              ),
              Positioned(
                right: ScreenSize.width/40,
                bottom: ScreenSize.width/60,
                child: Container(
                  decoration: BoxDecoration(
                  border: Border.all(width: 1,color: gold), // Background color
                 shape: BoxShape.circle, // Makes it circular
                ),
                child: Icon(Icons.east, color: gold),
                 ),
              )
              ]
            ),
            SizedBox(height: ScreenSize.width/20,),
            Stack(
              children:[ Container(
                padding: EdgeInsets.all(ScreenSize.width/20),
                width: ScreenSize.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Text("Tomorrow’s match: Morocco vs Algeria. Don’t forget to grab your ticket", style: TextStyle(
                  color: Colors.black,
                  fontSize:ScreenSize.width/25,
                ),),
              ),
              Positioned(
                right: ScreenSize.width/40,
                bottom: ScreenSize.width/60,
                child: Container(
                  decoration: BoxDecoration(
                  border: Border.all(width: 1,color: gold), // Background color
                 shape: BoxShape.circle, // Makes it circular
                ),
                child: Icon(Icons.east, color: gold),
                 ),
              )
              ]
            )
          ],
        ),
      ),
    );
  }
}