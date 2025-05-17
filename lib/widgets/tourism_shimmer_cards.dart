// lib/widgets/tourism_shimmer_cards.dart
import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TourismShimmerCards extends StatelessWidget {
  final bool isSpotCard; // True for spot card, false for tour card

  const TourismShimmerCards({super.key, this.isSpotCard = true});

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    final cardWidth = ScreenSize.width / 1.06;
    final cardHeight = ScreenSize.height / 2.3;

    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        clipBehavior: Clip.hardEdge,
        width: cardWidth,
        height: cardHeight,
        margin: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(width: 0.5, color: gold),
        ),
        child: isSpotCard
            ? _buildSpotCardLayout(cardWidth, cardHeight)
            : _buildTourCardLayout(cardWidth, cardHeight),
      ),
    );
  }

  // Layout for tourist spot card
  Widget _buildSpotCardLayout(double cardWidth, double cardHeight) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // Image placeholder
        Container(
          width: cardWidth / 2,
          height: cardHeight,
          color: Colors.white,
        ),
        // Content placeholder
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title placeholder
                Container(
                  height: 24,
                  width: double.infinity,
                  color: Colors.white,
                ),
                SizedBox(height: 16),

                // Description placeholder (multiple lines)
                Container(
                  height: 12,
                  width: double.infinity,
                  color: Colors.white,
                ),
                SizedBox(height: 8),
                Container(
                  height: 12,
                  width: double.infinity,
                  color: Colors.white,
                ),
                SizedBox(height: 8),
                Container(
                  height: 12,
                  width: double.infinity * 0.7,
                  color: Colors.white,
                ),

                Spacer(),

                // Location placeholder
                Row(
                  children: [
                    Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 8),
                    Container(
                      height: 12,
                      width: 80,
                      color: Colors.white,
                    ),
                  ],
                ),

                SizedBox(height: 12),

                // Rating placeholder
                Row(
                  children: [
                    Container(
                      height: 16,
                      width: 40,
                      color: Colors.white,
                    ),
                    SizedBox(width: 8),
                    Container(
                      height: 16,
                      width: 16,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16),

                // Button placeholder
                Container(
                  height: 40,
                  width: 120,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Layout for tour card
  Widget _buildTourCardLayout(double cardWidth, double cardHeight) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image placeholder
        Container(
          width: cardWidth,
          height: cardHeight / 2.5,
          color: Colors.white,
        ),

        Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title placeholder
              Container(
                height: 24,
                width: double.infinity,
                color: Colors.white,
              ),
              SizedBox(height: 16),

              // Details row placeholder
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 16,
                    width: 60,
                    color: Colors.white,
                  ),
                  Container(
                    height: 16,
                    width: 60,
                    color: Colors.white,
                  ),
                  Container(
                    height: 16,
                    width: 60,
                    color: Colors.white,
                  ),
                ],
              ),

              SizedBox(height: 16),

              // Description placeholder
              Container(
                height: 12,
                width: double.infinity,
                color: Colors.white,
              ),
              SizedBox(height: 8),
              Container(
                height: 12,
                width: double.infinity,
                color: Colors.white,
              ),

              SizedBox(height: 16),

              // Price and button row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 24,
                    width: 80,
                    color: Colors.white,
                  ),
                  Container(
                    height: 40,
                    width: 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
