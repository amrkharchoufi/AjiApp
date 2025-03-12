import 'package:ajiapp/widgets/available_cars_widget.dart';
import 'package:ajiapp/widgets/search_bar.dart';
import 'package:ajiapp/widgets/top_brands_widget.dart';
import 'package:flutter/material.dart';


class RentCarView extends StatelessWidget {
  const RentCarView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final searchController = TextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: size.height * 0.02),
    
    
        SearchBarWidget(
          size: MediaQuery.of(context).size,
          controller: searchController,
          hintText: "Search cars in city...",
          onChanged: (value) {
          
            
          },
        ),
    
        SizedBox(height: size.height * 0.04),
        TopBrandsWidget(
          onBrandTap: (brandName) {
            
          
          },
        ),
    
        SizedBox(height: size.height * 0.03),
        AvailableCarsWidget(
          onCarTap: (car) {
          
            
          },
        ),
      ],
    );
  }
}
