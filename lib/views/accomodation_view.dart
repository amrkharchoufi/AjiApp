import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:ajiapp/widgets/morrcandoor_widget.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class AccomodationView extends StatefulWidget {
  const AccomodationView({super.key});

  @override
  State<AccomodationView> createState() => _AccomodationViewState();
}

class _AccomodationViewState extends State<AccomodationView> {

final List<String> cities = [
    "Rabat",
    "Sale",
    "Casablanca",
    "Marrakech",
  ];



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
                        Image(image: Svg("assets/images/logowhite.svg"),),
                        SizedBox(width: ScreenSize.width/25,),
                        Text("Accomodation", style: TextStyle(
                          color: Colors.white,
                          fontSize:ScreenSize.width/13.5,
                          fontWeight: FontWeight.bold
                        ),)
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: ScreenSize.height/120,),
              Padding(
                padding:  EdgeInsets.all(ScreenSize.height/60),
                child: Column(
                  children: [
                  SizedBox(
                    width: ScreenSize.width/1.2,
                    child: DropdownSearch<String>(
                       popupProps: PopupProps.menu(
                       showSearchBox: true, // Enables search in the dropdown
                       searchFieldProps: TextFieldProps(
                       decoration: InputDecoration(
                           prefixIcon: Icon(Icons.search, color: Colors.black54),
                           hintText: "Search for a city",
                           border: InputBorder.none, // Removes the default border
                       ),
                    ),
                    fit: FlexFit.loose,
                    ),
                      items: cities,
                      dropdownDecoratorProps: DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                       prefixIcon: Icon(Icons.search, color: Colors.black54), // Search icon
                       hintText: "Search for a city",
                       contentPadding: EdgeInsets.symmetric(horizontal: ScreenSize.width/10, vertical: ScreenSize.width/30),
                       border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(ScreenSize.width/10),
                        borderSide: BorderSide.none,
                        ),
                     ),
                                    ),
                     dropdownButtonProps: DropdownButtonProps(
                     icon: Icon(Icons.arrow_drop_down, color: Colors.black54),
                       ),
                     onChanged: (value) => {
                    
                     },
                      ),
                  ),
                  SizedBox(height: ScreenSize.width/15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: ScreenSize.width/6,
                            height: ScreenSize.width/6,
                            decoration: BoxDecoration(
                              color: ajired,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Image(image: Svg("assets/icons/hotel_icon.svg"),
                            ),
                          ),
                          Text("Hotels", style: TextStyle(
                            color: Colors.black,
                            fontSize: ScreenSize.width/25,
                            
                          ),)
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                          width: ScreenSize.width/6,
                            height: ScreenSize.width/6,
                            decoration: BoxDecoration(
                              color: ajired,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Image(image: Svg("assets/icons/bed_icon.svg"),
                            ),
                          ),
                          Text("Airbnb", style: TextStyle(
                            color: Colors.black,
                            fontSize: ScreenSize.width/25,
                            
                          ),)
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: ScreenSize.width/6,
                            height: ScreenSize.width/6,
                            decoration: BoxDecoration(
                              color: ajired,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Image(image: Svg("assets/icons/Home_icon.svg"),
                            ),
                          ),
                          Text("Stay here", style: TextStyle(
                            color: Colors.black,
                            fontSize: ScreenSize.width/25,
                            
                          ),)
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                          width: ScreenSize.width/6,
                            height: ScreenSize.width/6,
                            decoration: BoxDecoration(
                              color: ajired,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Image(image: Svg("assets/icons/more_icon.svg"),
                            ),
                          ),
                          Text("More", style: TextStyle(
                            color: Colors.black,
                            fontSize: ScreenSize.width/25,
                            
                          ),)
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: ScreenSize.width/15,),
                  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Featured",
                      style: TextStyle(
                          fontFamily: "SFDisplay",
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "View all",
                      style: TextStyle(
                        fontFamily: "SFDisplay",
                        fontSize: 19,
                      ),
                    ),
                  ],
                ),
              
              SizedBox(
                height: 15,
              ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        FeatureCard(title: "STAY HERE", subtitle: "Book premier appartment in the city", backgroundImage: AssetImage("assets/images/hotel1.jpg"), description: "Book Now"),
                        SizedBox(width: 10),
                        FeatureCard(title: "Bracelo", subtitle: "an Hotel where comfort is a priotrity", backgroundImage: AssetImage("assets/images/hotel2.jpg"), description: "Book Now")
                      ],
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