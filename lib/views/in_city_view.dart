import 'package:ajiapp/widgets/search_bar.dart';
import 'package:flutter/material.dart';

class InCityScreen extends StatelessWidget {
  const InCityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final searchController = TextEditingController();

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.04, vertical: size.height * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: size.height * 0.03),

          // Barre de recherche spécifique à "In City"
            SearchBarWidget(
              size: MediaQuery.of(context).size,
              controller: searchController,
              hintText: "Search cars in city...",
              onChanged: (value) {
                print("User is searching for: $value");
                // Ajoute ta logique de recherche ici
              },
            ),          
          SizedBox(height: size.height * 0.03),

          // Titre clair avant la liste de voitures
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Available Cars",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              TextButton(
                style: ButtonStyle(
                foregroundColor: WidgetStateProperty.all<Color>(
                  const Color.fromARGB(255, 0, 0, 0),
                ), 
              ),
                onPressed: () {
                  // Logique pour afficher toutes les voitures disponibles
                },
                child: const Text("View all"),
              ),
            ],
          ),

          SizedBox(height: size.height * 0.02),

          // Widget affichant la liste des voitures disponibles
  
        ],
      ),
    );
  }
}
