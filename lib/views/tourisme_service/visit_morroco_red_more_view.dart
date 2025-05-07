import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:ajiapp/widgets/myappbar_widget.dart';
import 'package:flutter/material.dart';

class VisitMorrocoRedMoreView extends StatefulWidget {
  const VisitMorrocoRedMoreView({super.key});

  @override
  State<VisitMorrocoRedMoreView> createState() =>
      _VisitMorrocoRedMoreViewState();
}

class _VisitMorrocoRedMoreViewState extends State<VisitMorrocoRedMoreView> {
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
            child: Column(
              children: [
                MyappbarWidget(
                  title: "Visit Morocco",
                ),
                SizedBox(
                  height: ScreenSize.height / 120,
                ),
                Container(
                  width: ScreenSize.width / 1.1,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(17)),
                  child: Column(
                    children: [
                      SizedBox(
                          height: ScreenSize.width / 1.2,
                          width: ScreenSize.width,
                          child: Image.asset(
                            "assets/images/hassantower.jpeg",
                            fit: BoxFit.fitWidth,
                          )),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: ScreenSize.width / 20,
                          vertical: ScreenSize.width / 20,
                        ),
                        width: ScreenSize.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(17)),
                        child: Column(
                          children: [
                            Text(
                              "Hassan Tower",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: ScreenSize.width / 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: ScreenSize.width / 40,
                            ),
                            Row(
                              children: [
                                Icon(Icons.watch_later_outlined),
                                Text(
                                  "6:30 AM–10:45 PM",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: ScreenSize.width / 35,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: ScreenSize.width / 40,
                            ),
                            Row(
                              children: [
                                Text(
                                  "4.6",
                                  style: TextStyle(
                                      
                                      fontSize: ScreenSize.width / 25,
                                      color: Colors.black),
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                ),
                                Text(
                                  "(9.3k)",
                                  style: TextStyle(
                                      
                                      fontSize: ScreenSize.width / 30,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: ScreenSize.width / 40,
                            ),
                            Text(
                              "Hassan Tower is a historical landmark in Rabat, Morocco, and one of the city's most iconic sites. It was commissioned by Sultan Yacoub al-Mansour in the 12th century as part of an ambitious project to build the largest mosque in the world. However, construction stopped after his death, leaving behind the striking 44-meter-tall red sandstone minaret and a vast esplanade filled with stone columns—silent reminders of what could have been.Despite its unfinished state, Hassan Tower remains a symbol of Morocco’s rich history and architectural heritage. The structure features intricate geometric designs and horseshoe arches, characteristic of Almohad architecture. Nearby, the Mausoleum of Mohammed V adds to the site’s grandeur, with its beautifully decorated white marble walls and green-tiled roof.The area surrounding Hassan Tower is peaceful and open, offering visitors a chance to admire the blend of history and craftsmanship. Overlooking the Bouregreg River, it provides a scenic setting for reflection and exploration. A visit to this historic monument offers not just a glimpse into Morocco’s past but also a deeper appreciation of its enduring cultural beauty.",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: ScreenSize.width / 35,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: ScreenSize.width / 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: ajired,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: ScreenSize.width / 12,
                                    ),
                                  ),
                                  child: Text(
                                    "View On Map",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: (ScreenSize.width / 22),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: ScreenSize.width / 10,
                ),
              ],
            ),
          ),
        ));
  }
}
