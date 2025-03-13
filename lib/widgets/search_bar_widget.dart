import 'package:ajiapp/settings/size.dart';
import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {


  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return Center(
      child: SizedBox(
        width: ScreenSize.width * 0.8,
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                spreadRadius: 1,
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
            borderRadius: BorderRadius.circular(30),
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search The Car',
              hintStyle:
                  TextStyle(color: Colors.grey.shade500, fontSize: ScreenSize.width * 0.04),
              prefixIcon: Icon(Icons.search, color: Colors.black54, size: ScreenSize.width * 0.06),
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(vertical: ScreenSize.height * 0.015),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
