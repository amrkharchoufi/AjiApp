import 'package:ajiapp/settings/size.dart';
import 'package:flutter/material.dart';

class FeatureCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final ImageProvider backgroundImage;
  final String description;

  const FeatureCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.backgroundImage,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ScreenSize.width / 2.2,
      height: ScreenSize.width / 1.4,
      child: CustomPaint(
        painter: DoorFramePainter(),
        child: ClipPath(
          clipper: DoorContentClipper(),
          child: Stack(
            children: [
              // Background image
              Container(
                decoration: BoxDecoration(
                  color: Colors.black, // Fallback color
                  image: DecorationImage(
                    image: backgroundImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Gradient overlay for text readability
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 70,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black,
                      ],
                    ),
                  ),
                ),
              ),
              // Text content
              Positioned(
                bottom: ScreenSize.width / 30,
                left: ScreenSize.width / 30,
                right: ScreenSize.width / 30,
                child: Container(
                  // margin: EdgeInsets.all(ScreenSize.width / 60),
                  padding: EdgeInsets.all(ScreenSize.width / 70),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(179, 0, 0, 0),
                      borderRadius: BorderRadius.circular(15)),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          softWrap: false,
                          style: TextStyle(
                            fontFamily: "SFDisplay",
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: ScreenSize.width / 25,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          subtitle,
                          softWrap: false,
                          style: TextStyle(
                            fontFamily: "SFDisplay",
                            color: Colors.white,
                            fontSize: ScreenSize.width / 30,
                          ),
                        ),
                        SizedBox(height: 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              description,
                              style: TextStyle(
                                fontFamily: "SFDisplay",
                                color: Colors.white,
                                fontSize: ScreenSize.width / 30,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Clipper for the content inside the door frame
class DoorContentClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return _getInnerPath(size);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

// Painter for the door frame (white border)
class DoorFramePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Create outer and inner paths
    final outerPath = _getOuterPath(size);
    final innerPath = _getInnerPath(size);

    // Create combined path for the frame
    final framePath =
        Path.combine(PathOperation.difference, outerPath, innerPath);

    // Paint for the white frame
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    // Draw the frame
    canvas.drawPath(framePath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Helper function to create the outer door path (from your SVG)
Path _getOuterPath(Size size) {
  final path = Path();

  // Scale factors to adjust SVG coordinates to widget size
  final scaleX = size.width / 154;
  final scaleY = size.height / 252;

  // Recreate the outer path from your SVG
  path.moveTo(144.921 * scaleX, 252 * scaleY);
  path.lineTo(9.177 * scaleX, 252 * scaleY);
  path.cubicTo(4.171 * scaleX, 252 * scaleY, 0.098 * scaleX, 247.928 * scaleY,
      0.098 * scaleX, 242.923 * scaleY);
  path.lineTo(0.098 * scaleX, 156.47 * scaleY);
  path.cubicTo(0.098 * scaleX, 151.465 * scaleY, 4.171 * scaleX,
      147.393 * scaleY, 9.177 * scaleX, 147.393 * scaleY);
  // Add the rest of your outer path points here...

  // For simplicity, I'm using an approximation of your path
  // In a real implementation, you would convert all points from your SVG
  path.cubicTo(5.644 * scaleX, 137.04 * scaleY, 2.11 * scaleX, 125.755 * scaleY,
      0.736 * scaleX, 114.519 * scaleY);

  // Top arch section
  path.cubicTo(0 * scaleX, 108.386 * scaleY, -0.834 * scaleX, 95.923 * scaleY,
      2.012 * scaleX, 81.105 * scaleY);

  path.cubicTo(16.195 * scaleX, 38.811 * scaleY, 29.298 * scaleX,
      27.231 * scaleY, 35.58 * scaleX, 21.687 * scaleY);

  path.cubicTo(47.996 * scaleX, 10.647 * scaleY, 61.688 * scaleX,
      3.533 * scaleY, 76.264 * scaleX, 0.147 * scaleY);

  path.lineTo(77 * scaleX, 0 * scaleY);
  path.lineTo(77.736 * scaleX, 0.147 * scaleY);

  path.cubicTo(92.312 * scaleX, 3.484 * scaleY, 106.004 * scaleX,
      10.647 * scaleY, 117.389 * scaleX, 20.804 * scaleY);

  path.cubicTo(124.702 * scaleX, 27.28 * scaleY, 137.805 * scaleX,
      38.811 * scaleY, 146.491 * scaleX, 59.615 * scaleY);

  path.cubicTo(154.883 * scaleX, 95.972 * scaleY, 154.049 * scaleX,
      108.435 * scaleY, 153.264 * scaleX, 114.568 * scaleY);

  path.cubicTo(151.89 * scaleX, 125.804 * scaleY, 148.356 * scaleX,
      137.04 * scaleY, 142.958 * scaleX, 147.442 * scaleY);

  path.lineTo(144.921 * scaleX, 147.442 * scaleY);

  path.cubicTo(149.927 * scaleX, 147.442 * scaleY, 154 * scaleX,
      151.514 * scaleY, 154 * scaleX, 156.519 * scaleY);

  path.lineTo(154 * scaleX, 242.972 * scaleY);

  path.cubicTo(154 * scaleX, 247.977 * scaleY, 149.927 * scaleX,
      252.049 * scaleY, 144.921 * scaleX, 252.049 * scaleY);

  path.lineTo(144.921 * scaleX, 252 * scaleY);
  path.close();

  return path;
}

// Helper function to create the inner door path (from your SVG)
Path _getInnerPath(Size size) {
  final path = Path();

  // Scale factors to adjust SVG coordinates to widget size
  final scaleX = size.width / 154;
  final scaleY = size.height / 252;

  // Recreate the inner path from your SVG
  path.moveTo(9.177 * scaleX, 153.771 * scaleY);
  path.cubicTo(7.705 * scaleX, 153.771 * scaleY, 6.478 * scaleX,
      154.998 * scaleY, 6.478 * scaleX, 156.47 * scaleY);

  path.lineTo(6.478 * scaleX, 242.923 * scaleY);

  path.cubicTo(6.478 * scaleX, 244.395 * scaleY, 7.705 * scaleX,
      245.622 * scaleY, 9.177 * scaleX, 245.622 * scaleY);

  path.lineTo(144.921 * scaleX, 245.622 * scaleY);

  path.cubicTo(146.393 * scaleX, 245.622 * scaleY, 147.62 * scaleX,
      244.395 * scaleY, 147.62 * scaleX, 242.923 * scaleY);

  path.lineTo(147.62 * scaleX, 156.47 * scaleY);

  path.cubicTo(147.62 * scaleX, 154.998 * scaleY, 146.393 * scaleX,
      153.771 * scaleY, 144.921 * scaleX, 153.771 * scaleY);

  // Add the rest of your inner path points here...
  // For simplicity, I'm using a simplified version of the top arc
  // In a real implementation, you would convert all points from your SVG

  path.lineTo(134.86 * scaleX, 153.771 * scaleY);

  path.cubicTo(141.24 * scaleX, 138.07 * scaleY, 145.461 * scaleX,
      125.902 * scaleY, 146.933 * scaleX, 113.734 * scaleY);

  path.cubicTo(147.62 * scaleX, 107.993 * scaleY, 145.706 * scaleX,
      82.332 * scaleY, 140.602 * scaleX, 62.068 * scaleY);

  path.cubicTo(132.456 * scaleX, 42.638 * scaleY, 120.138 * scaleX,
      31.745 * scaleY, 114.199 * scaleX, 26.495 * scaleY);

  path.cubicTo(102.716 * scaleX, 16.29 * scaleY, 90.251 * scaleX,
      9.715 * scaleY, 77 * scaleX, 6.526 * scaleY);

  path.cubicTo(63.75 * scaleX, 9.715 * scaleY, 51.284 * scaleX, 16.29 * scaleY,
      40.88 * scaleX, 25.563 * scaleY);

  path.cubicTo(33.862 * scaleX, 31.745 * scaleY, 21.544 * scaleX,
      42.638 * scaleY, 13.398 * scaleX, 62.068 * scaleY);

  path.cubicTo(5.595 * scaleX, 96.266 * scaleY, 6.38 * scaleX, 107.993 * scaleY,
      7.067 * scaleX, 113.734 * scaleY);

  path.cubicTo(8.539 * scaleX, 125.853 * scaleY, 12.76 * scaleX,
      138.021 * scaleY, 19.189 * scaleX, 148.963 * scaleY);

  path.lineTo(19.14 * scaleX, 153.771 * scaleY);
  path.lineTo(9.177 * scaleX, 153.771 * scaleY);
  path.close();

  return path;
}
