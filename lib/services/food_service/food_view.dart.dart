// import 'package:ajiapp/services/common/Map_view.dart';
// import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:ajiapp/widgets/available%20_soon_widget.dart';
import 'package:ajiapp/widgets/myappbar_widget.dart';
import 'package:flutter/material.dart';
// import 'package:get/get.dart';
class FoodHomePage extends StatelessWidget {
  const FoodHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return Scaffold(
        // floatingActionButton: FloatingActionButton.extended(
        //   backgroundColor: ajired,
        //   onPressed: () {
        //     Get.to(MapView());
        //   },
        //   label:
        //       const Text("View on Map", style: TextStyle(color: Colors.white)),
        //   icon: const Icon(
        //     Icons.map,
        //     color: Colors.white,
        //   ),
        // ),
        body: Container(
          width: ScreenSize.width,
          height: ScreenSize.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: 
              SingleChildScrollView(
                child: Column(
                  children: [
                    MyappbarWidget(
                      title: "Food",
                    ),
                    SizedBox(height: ScreenSize.height/5,),
                    Available_SoonWidget(),
                    ],
                ),
              ),
          
        ));
  }
}
