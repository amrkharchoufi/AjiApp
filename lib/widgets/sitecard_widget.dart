import 'package:ajiapp/settings/size.dart';
import 'package:flutter/material.dart';

class SiteCard extends StatelessWidget {
  final String title;
  final ImageProvider backgroundImage;

  const SiteCard({
    super.key,
    required this.title,
    required this.backgroundImage,
  });

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return Container(
      width: ScreenSize.width / 1.5,
      height: ScreenSize.height / 3.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.2 * 255).toInt()),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            // Background image
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: backgroundImage,
                  fit: BoxFit.fill,
                ),
              ),
            ),

            // Gradient overlay
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  // This creates the gradient overlay effect
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      const Color.fromARGB(122, 0, 0, 0),
                      const Color.fromARGB(132, 0, 0, 0),
                      const Color.fromARGB(141, 0, 0, 0),
                      const Color.fromARGB(200, 0, 0, 0),
                      const Color.fromARGB(226, 0, 0, 0),
                    ],
                    stops: [0.0, 0.6, 0.7, 0.8, 0.9, 1.0],
                  ),
                ),
              ),
            ),

            // Title text
            Positioned(
              bottom: ScreenSize.width / 30,
              left: ScreenSize.width / 30,
              right: ScreenSize.width / 30,
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: ScreenSize.width / 25,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
