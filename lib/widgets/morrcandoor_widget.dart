import 'package:ajiapp/settings/size.dart';
import 'package:flutter/material.dart';

class FeatureCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final ImageProvider backgroundImage;
  final String description;

  const FeatureCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.backgroundImage,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return SizedBox(
      width: ScreenSize.width / 2.1,
      height: ScreenSize.width / 1.35,
      child: CustomPaint(
        painter: DoorFramePainter(),
        child: ClipPath(
          clipper: DoorContentClipper(),
          child: Stack(
            children: [
              // Background image
              Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  image: DecorationImage(
                    image: backgroundImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Gradient overlay
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: ScreenSize.width / 4,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.9),
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
                  padding: EdgeInsets.symmetric(horizontal:ScreenSize.width / 50),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(179, 0, 0, 0),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          title,
                          style: TextStyle(
                            fontFamily: "SFDisplay",
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: ScreenSize.width / 25,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(height: ScreenSize.width / 100),
                      Flexible(
                        child: Text(
                          subtitle,
                          style: TextStyle(
                            fontFamily: "SFDisplay",
                            color: Colors.white,
                            fontSize: ScreenSize.width / 30,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(height: ScreenSize.width / 100),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              description,
                              style: TextStyle(
                                fontFamily: "SFDisplay",
                                color: Colors.white,
                                fontSize: ScreenSize.width / 30,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_rounded,
                            color: Colors.white,
                            size: ScreenSize.width / 25,
                          )
                        ],
                      ),
                    ],
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

class DoorContentClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) => _getInnerPath(size);

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class DoorFramePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final outerPath = _getOuterPath(size);
    final innerPath = _getInnerPath(size);
    final framePath = Path.combine(PathOperation.difference, outerPath, innerPath);
    
    canvas.drawPath(framePath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

Path _getOuterPath(Size size) {
  final path = Path();
  final scaleX = size.width / 154;
  final scaleY = size.height / 252;

  path.moveTo(144.921 * scaleX, 252 * scaleY);
  path.lineTo(9.177 * scaleX, 252 * scaleY);
  path.cubicTo(4.171 * scaleX, 252 * scaleY, 0.098 * scaleX, 247.928 * scaleY,
      0.098 * scaleX, 242.923 * scaleY);
  path.lineTo(0.098 * scaleX, 156.47 * scaleY);
  path.cubicTo(0.098 * scaleX, 151.465 * scaleY, 4.171 * scaleX,
      147.393 * scaleY, 9.177 * scaleX, 147.393 * scaleY);
  path.cubicTo(5.644 * scaleX, 137.04 * scaleY, 2.11 * scaleX, 125.755 * scaleY,
      0.736 * scaleX, 114.519 * scaleY);
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
  path.close();
  return path;
}

Path _getInnerPath(Size size) {
  final path = Path();
  final scaleX = size.width / 154;
  final scaleY = size.height / 252;

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
  path.close();
  return path;
}