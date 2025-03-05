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
    final framePath =
        Path.combine(PathOperation.difference, outerPath, innerPath);
    
    canvas.drawPath(framePath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

Path _getOuterPath(Size size) {
  final path = Path();
  final _xScaling = size.width / 150; 
  final _yScaling = size.height / 250; 
  path.lineTo(144.896 * _xScaling, 252 * _yScaling);
  path.cubicTo(
    144.896 * _xScaling,
    252 * _yScaling,
    9.15173 * _xScaling,
    252 * _yScaling,
    9.15173 * _xScaling,
    252 * _yScaling,
  );
  path.cubicTo(
    4.146 * _xScaling,
    252 * _yScaling,
    0.0727008 * _xScaling,
    247.928 * _yScaling,
    0.0727008 * _xScaling,
    242.923 * _yScaling,
  );
  path.cubicTo(
    0.0727008 * _xScaling,
    242.923 * _yScaling,
    0.0727008 * _xScaling,
    156.47 * _yScaling,
    0.0727008 * _xScaling,
    156.47 * _yScaling,
  );
  path.cubicTo(
    0.0727008 * _xScaling,
    151.465 * _yScaling,
    4.146 * _xScaling,
    147.393 * _yScaling,
    9.15173 * _xScaling,
    147.393 * _yScaling,
  );
  path.cubicTo(
    9.15173 * _xScaling,
    147.393 * _yScaling,
    11.0166 * _xScaling,
    147.393 * _yScaling,
    11.0166 * _xScaling,
    147.393 * _yScaling,
  );
  path.cubicTo(
    5.61827 * _xScaling,
    137.04 * _yScaling,
    2.08481 * _xScaling,
    125.755 * _yScaling,
    0.710687 * _xScaling,
    114.519 * _yScaling,
  );
  path.cubicTo(
    -0.0254509 * _xScaling,
    108.386 * _yScaling,
    -0.85974 * _xScaling,
    95.9229 * _yScaling,
    1.98666 * _xScaling,
    81.1051 * _yScaling,
  );
  path.cubicTo(
    2.03573 * _xScaling,
    80.7617 * _yScaling,
    2.13389 * _xScaling,
    80.222 * _yScaling,
    2.23204 * _xScaling,
    79.5351 * _yScaling,
  );
  path.cubicTo(
    2.77187 * _xScaling,
    75.8551 * _yScaling,
    3.85154 * _xScaling,
    68.25 * _yScaling,
    7.48315 * _xScaling,
    59.5654 * _yScaling,
  );
  path.cubicTo(
    16.1696 * _xScaling,
    38.8108 * _yScaling,
    29.2728 * _xScaling,
    27.2313 * _yScaling,
    35.5545 * _xScaling,
    21.6869 * _yScaling,
  );
  path.cubicTo(
    35.9471 * _xScaling,
    21.3435 * _yScaling,
    36.2907 * _xScaling,
    21.0491 * _yScaling,
    36.5851 * _xScaling,
    20.7547 * _yScaling,
  );
  path.cubicTo(
    47.9707 * _xScaling,
    10.6472 * _yScaling,
    61.6629 * _xScaling,
    3.53271 * _yScaling,
    76.2384 * _xScaling,
    0.147196 * _yScaling,
  );
  path.cubicTo(
    76.2384 * _xScaling,
    0.147196 * _yScaling,
    76.9745 * _xScaling,
    0 * _yScaling,
    76.9745 * _xScaling,
    0 * _yScaling,
  );
  path.cubicTo(
    76.9745 * _xScaling,
    0 * _yScaling,
    77.7107 * _xScaling,
    0.147196 * _yScaling,
    77.7107 * _xScaling,
    0.147196 * _yScaling,
  );
  path.cubicTo(
    92.2862 * _xScaling,
    3.48365 * _yScaling,
    105.978 * _xScaling,
    10.6472 * _yScaling,
    117.364 * _xScaling,
    20.8037 * _yScaling,
  );
  path.cubicTo(
    117.658 * _xScaling,
    21.0981 * _yScaling,
    118.002 * _xScaling,
    21.3925 * _yScaling,
    118.395 * _xScaling,
    21.736 * _yScaling,
  );
  path.cubicTo(
    124.676 * _xScaling,
    27.2804 * _yScaling,
    137.78 * _xScaling,
    38.8108 * _yScaling,
    146.466 * _xScaling,
    59.6145 * _yScaling,
  );
  path.cubicTo(
    150.048 * _xScaling,
    68.25 * _yScaling,
    151.177 * _xScaling,
    75.8551 * _yScaling,
    151.717 * _xScaling,
    79.5351 * _yScaling,
  );
  path.cubicTo(
    151.815 * _xScaling,
    80.222 * _yScaling,
    151.913 * _xScaling,
    80.8107 * _yScaling,
    151.962 * _xScaling,
    81.1542 * _yScaling,
  );
  path.cubicTo(
    154.858 * _xScaling,
    95.972 * _yScaling,
    154.024 * _xScaling,
    108.435 * _yScaling,
    153.238 * _xScaling,
    114.568 * _yScaling,
  );
  path.cubicTo(
    151.864 * _xScaling,
    125.804 * _yScaling,
    148.331 * _xScaling,
    137.04 * _yScaling,
    142.932 * _xScaling,
    147.442 * _yScaling,
  );
  path.cubicTo(
    142.932 * _xScaling,
    147.442 * _yScaling,
    144.896 * _xScaling,
    147.442 * _yScaling,
    144.896 * _xScaling,
    147.442 * _yScaling,
  );
  path.cubicTo(
    149.901 * _xScaling,
    147.442 * _yScaling,
    153.975 * _xScaling,
    151.514 * _yScaling,
    153.975 * _xScaling,
    156.519 * _yScaling,
  );
  path.cubicTo(
    153.975 * _xScaling,
    156.519 * _yScaling,
    153.975 * _xScaling,
    242.972 * _yScaling,
    153.975 * _xScaling,
    242.972 * _yScaling,
  );
  path.cubicTo(
    153.975 * _xScaling,
    247.977 * _yScaling,
    149.901 * _xScaling,
    252.049 * _yScaling,
    144.896 * _xScaling,
    252.049 * _yScaling,
  );
  path.cubicTo(
    144.896 * _xScaling,
    252.049 * _yScaling,
    144.896 * _xScaling,
    252 * _yScaling,
    144.896 * _xScaling,
    252 * _yScaling,
  );
  return path;
}

Path _getInnerPath(Size size) {
  final path = Path();
  final _xScaling = size.width / 150; 
  final _yScaling = size.height / 250; 

  path.lineTo(9.15173 * _xScaling, 153.771 * _yScaling);
  path.cubicTo(
    7.67946 * _xScaling,
    153.771 * _yScaling,
    6.45256 * _xScaling,
    154.998 * _yScaling,
    6.45256 * _xScaling,
    156.47 * _yScaling,
  );
  path.cubicTo(
    6.45256 * _xScaling,
    156.47 * _yScaling,
    6.45256 * _xScaling,
    242.923 * _yScaling,
    6.45256 * _xScaling,
    242.923 * _yScaling,
  );
  path.cubicTo(
    6.45256 * _xScaling,
    244.395 * _yScaling,
    7.67946 * _xScaling,
    245.622 * _yScaling,
    9.15173 * _xScaling,
    245.622 * _yScaling,
  );
  path.cubicTo(
    9.15173 * _xScaling,
    245.622 * _yScaling,
    144.896 * _xScaling,
    245.622 * _yScaling,
    144.896 * _xScaling,
    245.622 * _yScaling,
  );
  path.cubicTo(
    146.368 * _xScaling,
    245.622 * _yScaling,
    147.595 * _xScaling,
    244.395 * _yScaling,
    147.595 * _xScaling,
    242.923 * _yScaling,
  );
  path.cubicTo(
    147.595 * _xScaling,
    242.923 * _yScaling,
    147.595 * _xScaling,
    156.47 * _yScaling,
    147.595 * _xScaling,
    156.47 * _yScaling,
  );
  path.cubicTo(
    147.595 * _xScaling,
    154.998 * _yScaling,
    146.368 * _xScaling,
    153.771 * _yScaling,
    144.896 * _xScaling,
    153.771 * _yScaling,
  );
  path.cubicTo(
    144.896 * _xScaling,
    153.771 * _yScaling,
    134.835 * _xScaling,
    153.771 * _yScaling,
    134.835 * _xScaling,
    153.771 * _yScaling,
  );
  path.cubicTo(
    133.559 * _xScaling,
    153.771 * _yScaling,
    132.774 * _xScaling,
    152.397 * _yScaling,
    133.412 * _xScaling,
    151.269 * _yScaling,
  );
  path.cubicTo(
    133.412 * _xScaling,
    151.269 * _yScaling,
    134.786 * _xScaling,
    148.963 * _yScaling,
    134.786 * _xScaling,
    148.963 * _yScaling,
  );
  path.cubicTo(
    141.215 * _xScaling,
    138.07 * _yScaling,
    145.435 * _xScaling,
    125.902 * _yScaling,
    146.908 * _xScaling,
    113.734 * _yScaling,
  );
  path.cubicTo(
    147.595 * _xScaling,
    107.993 * _yScaling,
    148.38 * _xScaling,
    96.2664 * _yScaling,
    145.681 * _xScaling,
    82.3318 * _yScaling,
  );
  path.cubicTo(
    145.583 * _xScaling,
    81.8411 * _yScaling,
    145.484 * _xScaling,
    81.2033 * _yScaling,
    145.386 * _xScaling,
    80.4182 * _yScaling,
  );
  path.cubicTo(
    144.896 * _xScaling,
    77.0327 * _yScaling,
    143.865 * _xScaling,
    69.9182 * _yScaling,
    140.577 * _xScaling,
    62.0678 * _yScaling,
  );
  path.cubicTo(
    132.43 * _xScaling,
    42.6379 * _yScaling,
    120.112 * _xScaling,
    31.7453 * _yScaling,
    114.174 * _xScaling,
    26.4953 * _yScaling,
  );
  path.cubicTo(
    113.781 * _xScaling,
    26.1519 * _yScaling,
    113.438 * _xScaling,
    25.8575 * _yScaling,
    113.094 * _xScaling,
    25.5631 * _yScaling,
  );
    path.cubicTo(
    102.69 * _xScaling,
    16.2897 * _yScaling,
    90.225 * _xScaling,
    9.71495 * _yScaling,
    76.9745 * _xScaling,
    6.5257 * _yScaling,
  );
  path.cubicTo(
    63.7241 * _xScaling,
    9.71495 * _yScaling,
    51.2588 * _xScaling,
    16.2897 * _yScaling,
    40.8547 * _xScaling,
    25.5631 * _yScaling,
  );
  path.cubicTo(
    40.5112 * _xScaling,
    25.8575 * _yScaling,
    40.1677 * _xScaling,
    26.1519 * _yScaling,
    39.7751 * _xScaling,
    26.4953 * _yScaling,
  );
  path.cubicTo(
    33.8369 * _xScaling,
    31.7453 * _yScaling,
    21.5188 * _xScaling,
    42.6379 * _yScaling,
    13.3723 * _xScaling,
    62.0678 * _yScaling,
  );
  path.cubicTo(
    10.0842 * _xScaling,
    69.9673 * _yScaling,
    9.05358 * _xScaling,
    77.0818 * _yScaling,
    8.56282 * _xScaling,
    80.4673 * _yScaling,
  );
  path.cubicTo(
    8.46467 * _xScaling,
    81.2523 * _yScaling,
    8.36652 * _xScaling,
    81.8902 * _yScaling,
    8.26837 * _xScaling,
    82.3318 * _yScaling,
  );
  path.cubicTo(
    5.5692 * _xScaling,
    96.2664 * _yScaling,
    6.35441 * _xScaling,
    107.993 * _yScaling,
    7.04147 * _xScaling,
    113.734 * _yScaling,
  );
  path.cubicTo(
    8.51375 * _xScaling,
    125.853 * _yScaling,
    12.7343 * _xScaling,
    138.021 * _yScaling,
    19.1632 * _xScaling,
    148.963 * _yScaling,
  );
  path.cubicTo(
    19.1632 * _xScaling,
    148.963 * _yScaling,
    20.5373 * _xScaling,
    151.269 * _yScaling,
    20.5373 * _xScaling,
    151.269 * _yScaling,
  );
  path.cubicTo(
    21.1753 * _xScaling,
    152.348 * _yScaling,
    20.3901 * _xScaling,
    153.771 * _yScaling,
    19.1141 * _xScaling,
    153.771 * _yScaling,
  );
  path.cubicTo(
    19.1141 * _xScaling,
    153.771 * _yScaling,
    9.15173 * _xScaling,
    153.771 * _yScaling,
    9.15173 * _xScaling,
    153.771 * _yScaling,
  );
  path.cubicTo(
    9.15173 * _xScaling,
    153.771 * _yScaling,
    9.15173 * _xScaling,
    153.771 * _yScaling,
    9.15173 * _xScaling,
    153.771 * _yScaling,
  );
  return path;
}