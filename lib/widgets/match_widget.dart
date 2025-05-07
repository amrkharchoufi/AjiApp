import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:ajiapp/services/followyourteam_service/model/fixture_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class MatchWidget extends StatelessWidget {
  final FixtureSimple fixture;
  const MatchWidget({super.key, required this.fixture});
  

  @override
  Widget build(BuildContext context) {
    DateTime matchDate = DateTime.parse(fixture.date);
    String dayAndDate = DateFormat('EEEE MMM d').format(matchDate); // Sunday Dec 21
    String time = DateFormat('hh:mm a').format(matchDate);
    
    SizeConfig().init(context);
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: SizeConfig.getBlockSizeVertical(1.5),
        horizontal: SizeConfig.getBlockSizeHorizontal(5),
      ),
      padding: EdgeInsets.symmetric(
        vertical: SizeConfig.getBlockSizeVertical(2),
        horizontal: SizeConfig.getBlockSizeHorizontal(4),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// Home Team Logo
          Container(
            clipBehavior: Clip.hardEdge,
            width: SizeConfig.getBlockSizeHorizontal(15),
              height: SizeConfig.getBlockSizeHorizontal(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: CachedNetworkImage(
              imageUrl: fixture.homeTeam.logo,
              
              fit: BoxFit.cover,
            ),
          ),

          /// Team Names and "Vs"
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: SizeConfig.getBlockSizeHorizontal(16),
                      child: Text(
                        fixture.homeTeam.name,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: SizeConfig.getBlockSizeHorizontal(3.5),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      'Vs',
                      style: TextStyle(
                        fontSize: SizeConfig.getBlockSizeHorizontal(4),
                        fontWeight: FontWeight.bold,
                        color: ajired,
                      ),
                    ),
                    SizedBox(
                      width: SizeConfig.getBlockSizeHorizontal(16),
                      child: Text(
                        fixture.awayTeam.name,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: SizeConfig.getBlockSizeHorizontal(3.5),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                                 dayAndDate,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                  fontSize: SizeConfig.getBlockSizeHorizontal(3),
                                  fontWeight: FontWeight.w500
                                 ),
                    ),
                    Text(
                                 time,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                  fontSize: SizeConfig.getBlockSizeHorizontal(3),
                                 color: Colors.black54,
                                 ),
                    ),
                  ],
                )
              ],
            ),
          ),

          Container(
            clipBehavior: Clip.hardEdge,
            width: SizeConfig.getBlockSizeHorizontal(15),
            height: SizeConfig.getBlockSizeHorizontal(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13),
            ),
            child: CachedNetworkImage(
              imageUrl: fixture.awayTeam.logo,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
