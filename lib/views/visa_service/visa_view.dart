import 'package:ajiapp/settings/size.dart';
import 'package:ajiapp/views/visa_service/with_visa.dart';
import 'package:ajiapp/views/visa_service/without_visa_view.dart';
import 'package:ajiapp/widgets/myappbar_widget.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class VisaView extends StatefulWidget {
  const VisaView({super.key});

  @override
  State<VisaView> createState() => _VisaViewState();
}

class _VisaViewState extends State<VisaView> {
  final List<String> nationalities = [
    "Algeria",
    "Benin",
    "Cameroon",
    "Egypt",
    "Ghana",
    "Ivory Coast",
    "Morocco",
    "Senegal",
  ];
  final Map<String, bool> nationalityvisa = {
    "Algeria": true,
    "Benin": false,
    "Cameroon": false,
    "Egypt": true,
    "Ghana": false,
    "Ivory Coast": false,
    "Morocco": true,
    "Senegal": false,
  };

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
                  title: "Visa",
                ),
                SizedBox(
                  height: ScreenSize.height / 120,
                ),
                Padding(
                  padding: EdgeInsets.all(ScreenSize.height / 60),
                  child: Column(
                    children: [
                      Text(
                        "Get visa information before your next trip to Morroco",
                        style: TextStyle(
                            
                            fontSize: ScreenSize.width / 21,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Search your nationality to find out the documents you need for your visa application",
                        style: TextStyle(
                          
                          fontSize: ScreenSize.width / 25,
                        ),
                      ),
                      SizedBox(
                        height: ScreenSize.width / 10,
                      ),
                      SizedBox(
                        width: ScreenSize.width / 1.2,
                        child: DropdownSearch<String>(
                          popupProps: PopupProps.menu(
                            menuProps: MenuProps(
                             backgroundColor: Colors.white,
                             borderRadius: BorderRadius.circular(
                                  25), 
                             ),
                            showSearchBox:
                                true, // Enables search in the dropdown
                            searchFieldProps: TextFieldProps(
                              decoration: InputDecoration(
                                prefixIcon:
                                    Icon(Icons.search, color: Colors.black54),
                                hintText: "Nationality",
                                border: InputBorder
                                    .none, // Removes the default border
                              ),
                            ),
                            fit: FlexFit.loose,
                          ),
                          items: nationalities,
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              fillColor: const Color.fromARGB(255, 255, 255, 255),
                              filled: true,
                              prefixIcon: Icon(Icons.search,
                                  color: Colors.black54), // Search icon
                              hintText: "Nationality",
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: ScreenSize.width / 15,
                                  vertical: ScreenSize.width / 25),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    ScreenSize.width / 10),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          dropdownButtonProps: DropdownButtonProps(
                            icon: Icon(Icons.arrow_drop_down,
                                color: Colors.black54),
                          ),
                          onChanged: (value) => {
                            if (nationalityvisa[value] == true)
                              {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => WithoutVisaView(
                                      country: value!,
                                    ),
                                  ),
                                )
                              }
                            else
                              {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => WithVisa(
                                      country: value!,
                                    ),
                                  ),
                                )
                              }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
