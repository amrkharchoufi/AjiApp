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
                    )),
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
                  padding:
                      EdgeInsets.symmetric(horizontal: ScreenSize.width / 50),
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
                          maxLines: 1,
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
                          maxLines: 1,
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
    final framePath =
        Path.combine(PathOperation.difference, outerPath, innerPath);

    canvas.drawPath(framePath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

Path _getOuterPath(Size size) {
  final path = Path();
  final xScaling = size.width / 150;
  final yScaling = size.height / 250;
  path.lineTo(144.896 * xScaling, 252 * yScaling);
  path.cubicTo(
    144.896 * xScaling,
    252 * yScaling,
    9.15173 * xScaling,
    252 * yScaling,
    9.15173 * xScaling,
    252 * yScaling,
  );
  path.cubicTo(
    4.146 * xScaling,
    252 * yScaling,
    0.0727008 * xScaling,
    247.928 * yScaling,
    0.0727008 * xScaling,
    242.923 * yScaling,
  );
  path.cubicTo(
    0.0727008 * xScaling,
    242.923 * yScaling,
    0.0727008 * xScaling,
    156.47 * yScaling,
    0.0727008 * xScaling,
    156.47 * yScaling,
  );
  path.cubicTo(
    0.0727008 * xScaling,
    151.465 * yScaling,
    4.146 * xScaling,
    147.393 * yScaling,
    9.15173 * xScaling,
    147.393 * yScaling,
  );
  path.cubicTo(
    9.15173 * xScaling,
    147.393 * yScaling,
    11.0166 * xScaling,
    147.393 * yScaling,
    11.0166 * xScaling,
    147.393 * yScaling,
  );
  path.cubicTo(
    5.61827 * xScaling,
    137.04 * yScaling,
    2.08481 * xScaling,
    125.755 * yScaling,
    0.710687 * xScaling,
    114.519 * yScaling,
  );
  path.cubicTo(
    -0.0254509 * xScaling,
    108.386 * yScaling,
    -0.85974 * xScaling,
    95.9229 * yScaling,
    1.98666 * xScaling,
    81.1051 * yScaling,
  );
  path.cubicTo(
    2.03573 * xScaling,
    80.7617 * yScaling,
    2.13389 * xScaling,
    80.222 * yScaling,
    2.23204 * xScaling,
    79.5351 * yScaling,
  );
  path.cubicTo(
    2.77187 * xScaling,
    75.8551 * yScaling,
    3.85154 * xScaling,
    68.25 * yScaling,
    7.48315 * xScaling,
    59.5654 * yScaling,
  );
  path.cubicTo(
    16.1696 * xScaling,
    38.8108 * yScaling,
    29.2728 * xScaling,
    27.2313 * yScaling,
    35.5545 * xScaling,
    21.6869 * yScaling,
  );
  path.cubicTo(
    35.9471 * xScaling,
    21.3435 * yScaling,
    36.2907 * xScaling,
    21.0491 * yScaling,
    36.5851 * xScaling,
    20.7547 * yScaling,
  );
  path.cubicTo(
    47.9707 * xScaling,
    10.6472 * yScaling,
    61.6629 * xScaling,
    3.53271 * yScaling,
    76.2384 * xScaling,
    0.147196 * yScaling,
  );
  path.cubicTo(
    76.2384 * xScaling,
    0.147196 * yScaling,
    76.9745 * xScaling,
    0 * yScaling,
    76.9745 * xScaling,
    0 * yScaling,
  );
  path.cubicTo(
    76.9745 * xScaling,
    0 * yScaling,
    77.7107 * xScaling,
    0.147196 * yScaling,
    77.7107 * xScaling,
    0.147196 * yScaling,
  );
  path.cubicTo(
    92.2862 * xScaling,
    3.48365 * yScaling,
    105.978 * xScaling,
    10.6472 * yScaling,
    117.364 * xScaling,
    20.8037 * yScaling,
  );
  path.cubicTo(
    117.658 * xScaling,
    21.0981 * yScaling,
    118.002 * xScaling,
    21.3925 * yScaling,
    118.395 * xScaling,
    21.736 * yScaling,
  );
  path.cubicTo(
    124.676 * xScaling,
    27.2804 * yScaling,
    137.78 * xScaling,
    38.8108 * yScaling,
    146.466 * xScaling,
    59.6145 * yScaling,
  );
  path.cubicTo(
    150.048 * xScaling,
    68.25 * yScaling,
    151.177 * xScaling,
    75.8551 * yScaling,
    151.717 * xScaling,
    79.5351 * yScaling,
  );
  path.cubicTo(
    151.815 * xScaling,
    80.222 * yScaling,
    151.913 * xScaling,
    80.8107 * yScaling,
    151.962 * xScaling,
    81.1542 * yScaling,
  );
  path.cubicTo(
    154.858 * xScaling,
    95.972 * yScaling,
    154.024 * xScaling,
    108.435 * yScaling,
    153.238 * xScaling,
    114.568 * yScaling,
  );
  path.cubicTo(
    151.864 * xScaling,
    125.804 * yScaling,
    148.331 * xScaling,
    137.04 * yScaling,
    142.932 * xScaling,
    147.442 * yScaling,
  );
  path.cubicTo(
    142.932 * xScaling,
    147.442 * yScaling,
    144.896 * xScaling,
    147.442 * yScaling,
    144.896 * xScaling,
    147.442 * yScaling,
  );
  path.cubicTo(
    149.901 * xScaling,
    147.442 * yScaling,
    153.975 * xScaling,
    151.514 * yScaling,
    153.975 * xScaling,
    156.519 * yScaling,
  );
  path.cubicTo(
    153.975 * xScaling,
    156.519 * yScaling,
    153.975 * xScaling,
    242.972 * yScaling,
    153.975 * xScaling,
    242.972 * yScaling,
  );
  path.cubicTo(
    153.975 * xScaling,
    247.977 * yScaling,
    149.901 * xScaling,
    252.049 * yScaling,
    144.896 * xScaling,
    252.049 * yScaling,
  );
  path.cubicTo(
    144.896 * xScaling,
    252.049 * yScaling,
    144.896 * xScaling,
    252 * yScaling,
    144.896 * xScaling,
    252 * yScaling,
  );
  return path;
}

Path _getInnerPath(Size size) {
  final path = Path();
  final xScaling = size.width / 150;
  final yScaling = size.height / 250;

  path.lineTo(9.15173 * xScaling, 153.771 * yScaling);
  path.cubicTo(
    7.67946 * xScaling,
    153.771 * yScaling,
    6.45256 * xScaling,
    154.998 * yScaling,
    6.45256 * xScaling,
    156.47 * yScaling,
  );
  path.cubicTo(
    6.45256 * xScaling,
    156.47 * yScaling,
    6.45256 * xScaling,
    242.923 * yScaling,
    6.45256 * xScaling,
    242.923 * yScaling,
  );
  path.cubicTo(
    6.45256 * xScaling,
    244.395 * yScaling,
    7.67946 * xScaling,
    245.622 * yScaling,
    9.15173 * xScaling,
    245.622 * yScaling,
  );
  path.cubicTo(
    9.15173 * xScaling,
    245.622 * yScaling,
    144.896 * xScaling,
    245.622 * yScaling,
    144.896 * xScaling,
    245.622 * yScaling,
  );
  path.cubicTo(
    146.368 * xScaling,
    245.622 * yScaling,
    147.595 * xScaling,
    244.395 * yScaling,
    147.595 * xScaling,
    242.923 * yScaling,
  );
  path.cubicTo(
    147.595 * xScaling,
    242.923 * yScaling,
    147.595 * xScaling,
    156.47 * yScaling,
    147.595 * xScaling,
    156.47 * yScaling,
  );
  path.cubicTo(
    147.595 * xScaling,
    154.998 * yScaling,
    146.368 * xScaling,
    153.771 * yScaling,
    144.896 * xScaling,
    153.771 * yScaling,
  );
  path.cubicTo(
    144.896 * xScaling,
    153.771 * yScaling,
    134.835 * xScaling,
    153.771 * yScaling,
    134.835 * xScaling,
    153.771 * yScaling,
  );
  path.cubicTo(
    133.559 * xScaling,
    153.771 * yScaling,
    132.774 * xScaling,
    152.397 * yScaling,
    133.412 * xScaling,
    151.269 * yScaling,
  );
  path.cubicTo(
    133.412 * xScaling,
    151.269 * yScaling,
    134.786 * xScaling,
    148.963 * yScaling,
    134.786 * xScaling,
    148.963 * yScaling,
  );
  path.cubicTo(
    141.215 * xScaling,
    138.07 * yScaling,
    145.435 * xScaling,
    125.902 * yScaling,
    146.908 * xScaling,
    113.734 * yScaling,
  );
  path.cubicTo(
    147.595 * xScaling,
    107.993 * yScaling,
    148.38 * xScaling,
    96.2664 * yScaling,
    145.681 * xScaling,
    82.3318 * yScaling,
  );
  path.cubicTo(
    145.583 * xScaling,
    81.8411 * yScaling,
    145.484 * xScaling,
    81.2033 * yScaling,
    145.386 * xScaling,
    80.4182 * yScaling,
  );
  path.cubicTo(
    144.896 * xScaling,
    77.0327 * yScaling,
    143.865 * xScaling,
    69.9182 * yScaling,
    140.577 * xScaling,
    62.0678 * yScaling,
  );
  path.cubicTo(
    132.43 * xScaling,
    42.6379 * yScaling,
    120.112 * xScaling,
    31.7453 * yScaling,
    114.174 * xScaling,
    26.4953 * yScaling,
  );
  path.cubicTo(
    113.781 * xScaling,
    26.1519 * yScaling,
    113.438 * xScaling,
    25.8575 * yScaling,
    113.094 * xScaling,
    25.5631 * yScaling,
  );
  path.cubicTo(
    102.69 * xScaling,
    16.2897 * yScaling,
    90.225 * xScaling,
    9.71495 * yScaling,
    76.9745 * xScaling,
    6.5257 * yScaling,
  );
  path.cubicTo(
    63.7241 * xScaling,
    9.71495 * yScaling,
    51.2588 * xScaling,
    16.2897 * yScaling,
    40.8547 * xScaling,
    25.5631 * yScaling,
  );
  path.cubicTo(
    40.5112 * xScaling,
    25.8575 * yScaling,
    40.1677 * xScaling,
    26.1519 * yScaling,
    39.7751 * xScaling,
    26.4953 * yScaling,
  );
  path.cubicTo(
    33.8369 * xScaling,
    31.7453 * yScaling,
    21.5188 * xScaling,
    42.6379 * yScaling,
    13.3723 * xScaling,
    62.0678 * yScaling,
  );
  path.cubicTo(
    10.0842 * xScaling,
    69.9673 * yScaling,
    9.05358 * xScaling,
    77.0818 * yScaling,
    8.56282 * xScaling,
    80.4673 * yScaling,
  );
  path.cubicTo(
    8.46467 * xScaling,
    81.2523 * yScaling,
    8.36652 * xScaling,
    81.8902 * yScaling,
    8.26837 * xScaling,
    82.3318 * yScaling,
  );
  path.cubicTo(
    5.5692 * xScaling,
    96.2664 * yScaling,
    6.35441 * xScaling,
    107.993 * yScaling,
    7.04147 * xScaling,
    113.734 * yScaling,
  );
  path.cubicTo(
    8.51375 * xScaling,
    125.853 * yScaling,
    12.7343 * xScaling,
    138.021 * yScaling,
    19.1632 * xScaling,
    148.963 * yScaling,
  );
  path.cubicTo(
    19.1632 * xScaling,
    148.963 * yScaling,
    20.5373 * xScaling,
    151.269 * yScaling,
    20.5373 * xScaling,
    151.269 * yScaling,
  );
  path.cubicTo(
    21.1753 * xScaling,
    152.348 * yScaling,
    20.3901 * xScaling,
    153.771 * yScaling,
    19.1141 * xScaling,
    153.771 * yScaling,
  );
  path.cubicTo(
    19.1141 * xScaling,
    153.771 * yScaling,
    9.15173 * xScaling,
    153.771 * yScaling,
    9.15173 * xScaling,
    153.771 * yScaling,
  );
  path.cubicTo(
    9.15173 * xScaling,
    153.771 * yScaling,
    9.15173 * xScaling,
    153.771 * yScaling,
    9.15173 * xScaling,
    153.771 * yScaling,
  );
  return path;
}
