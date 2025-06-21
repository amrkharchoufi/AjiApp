import 'package:ajiapp/settings/size.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class SearchbarWidget extends StatelessWidget {
  final List<String> options;
  final Function(String?) onchanged;
  final String? placeholder;
  const SearchbarWidget(
      {super.key,
      required this.options,
      required this.onchanged,
      this.placeholder});

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<String>(
      popupProps: PopupProps.menu(
        menuProps: MenuProps(
          backgroundColor: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        showSearchBox: true, // Enables search in the dropdown
        searchFieldProps: TextFieldProps(
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search, color: Colors.black54),
            hintText: placeholder,
            border: InputBorder.none, // Removes the default border
          ),
        ),
        fit: FlexFit.loose,
      ),
      items: options,
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          fillColor: const Color.fromARGB(255, 255, 255, 255),
          filled: true,
          prefixIcon: Icon(Icons.search, color: Colors.black54), // Search icon
          hintText: placeholder,
          contentPadding: EdgeInsets.symmetric(
              horizontal: ScreenSize.width / 15,
              vertical: ScreenSize.width / 25),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(ScreenSize.width / 10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      dropdownButtonProps: DropdownButtonProps(
        icon: Icon(Icons.arrow_drop_down, color: Colors.black54),
      ),
      onChanged: onchanged,
    );
  }
}
