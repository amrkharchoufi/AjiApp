// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:get/get.dart';
import 'package:ajiapp/services/followyourteam_service/controller/team_details_controller.dart';

class FootballStandingsWidget extends GetWidget<TeamDetailsController> {
  const FootballStandingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Obx(() {
      if (controller.isLoadingStandings.value) {
        return Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: ajired),
            SizedBox(height: 16),
            Text('Loading standings...')
          ],
        ));
      }

      if (controller.standingsError.value.isNotEmpty) {
        return Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, color: ajired, size: 48),
            SizedBox(height: 16),
            Text(controller.standingsError.value,
                style: TextStyle(color: ajired)),
          ],
        ));
      }

      if (controller.standings.isEmpty) {
        return Center(child: Text('No standings data available'));
      }

      // Get only the teams in the same group as the fixture teams
      final Map<String, List<StandingItem>> groupedStandings =
          _getGroupedStandings();

      if (groupedStandings.isEmpty) {
        return Center(
            child: Text('No group standings available for these teams'));
      }

      return Column(
        children: [
          // if (controller.leagueInfo.value != null) _buildLeagueHeader(),
          SizedBox(height: 10),
          // Build standings tables for each relevant group
          ...groupedStandings.entries.map((entry) {
            return Column(
              children: [
                // Group header
                if (groupedStandings.length >
                    1) // Only show group headers if there's more than one group
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    padding: EdgeInsets.all(8),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: ajired.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      entry.key,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: ajired,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                // Standings table for this group
                _buildStandingsTable(entry.value),
                SizedBox(height: 20),
              ],
            );
          }),
        ],
      );
    });
  }

  // Group the standings by group and filter to only show relevant groups
  Map<String, List<StandingItem>> _getGroupedStandings() {
    // Find the home and away team groups
    String? homeTeamGroup, awayTeamGroup;

    for (var standing in controller.standings) {
      if (standing.team.name == controller.fixture.homeTeam.name) {
        homeTeamGroup = standing.group;
      }
      if (standing.team.name == controller.fixture.awayTeam.name) {
        awayTeamGroup = standing.group;
      }

      // Break early if we found both teams
      if (homeTeamGroup != null && awayTeamGroup != null) {
        break;
      }
    }

    Map<String, List<StandingItem>> relevantGroups = {};

    // If both teams are in the same group, only show that group
    if (homeTeamGroup != null &&
        awayTeamGroup != null &&
        homeTeamGroup == awayTeamGroup) {
      final groupTeams = controller.standings
          .where((item) => item.group == homeTeamGroup)
          .toList();

      if (groupTeams.isNotEmpty) {
        relevantGroups[homeTeamGroup] = groupTeams;
      }
    }
    // If teams are in different groups or we couldn't find one of them
    else {
      // Add the home team's group if we found it
      if (homeTeamGroup != null) {
        final homeGroupTeams = controller.standings
            .where((item) => item.group == homeTeamGroup)
            .toList();

        if (homeGroupTeams.isNotEmpty) {
          relevantGroups[homeTeamGroup] = homeGroupTeams;
        }
      }

      // Add the away team's group if we found it and it's different
      if (awayTeamGroup != null && awayTeamGroup != homeTeamGroup) {
        final awayGroupTeams = controller.standings
            .where((item) => item.group == awayTeamGroup)
            .toList();

        if (awayGroupTeams.isNotEmpty) {
          relevantGroups[awayTeamGroup] = awayGroupTeams;
        }
      }

      // If we couldn't find any groups, try to find the teams directly
      if (relevantGroups.isEmpty) {
        // Try to find teams by name
        final List<String> teamNames = [
          controller.fixture.homeTeam.name,
          controller.fixture.awayTeam.name
        ];

        for (var standing in controller.standings) {
          if (teamNames.contains(standing.team.name) &&
              standing.group != null) {
            if (!relevantGroups.containsKey(standing.group)) {
              relevantGroups[standing.group!] = controller.standings
                  .where((item) => item.group == standing.group)
                  .toList();
            }
          }
        }
      }
    }

    // Sort teams in each group by rank
    relevantGroups.forEach((group, teams) {
      teams.sort((a, b) => a.rank.compareTo(b.rank));
    });

    return relevantGroups;
  }

  // Widget _buildLeagueHeader() {
  //   return Container(
  //     margin: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
  //     padding: EdgeInsets.all(12),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(12),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.black.withOpacity(0.1),
  //           blurRadius: 4,
  //           offset: Offset(0, 2),
  //         ),
  //       ],
  //     ),
  //     child: Row(
  //       children: [
  //         if (controller.leagueInfo.value!['logo'] != null)
  //           CachedNetworkImage(
  //             imageUrl: controller.leagueInfo.value!['logo'],
  //             width: 40,
  //             height: 40,
  //             placeholder: (context, url) => Container(
  //               width: 40,
  //               height: 40,
  //               color: Colors.grey[200],
  //             ),
  //             errorWidget: (context, url, error) => Icon(Icons.sports_soccer),
  //           ),
  //         SizedBox(width: 12),
  //         Expanded(
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text(
  //                 controller.leagueInfo.value!['name'] ?? 'Unknown League',
  //                 style: TextStyle(
  //                   fontWeight: FontWeight.bold,
  //                   fontSize: 16,
  //                 ),
  //               ),
  //               Text(
  //                 '${controller.leagueInfo.value!['country'] ?? 'Unknown'} - Season ${controller.leagueInfo.value!['season'] ?? ''}',
  //                 style: TextStyle(
  //                   color: Colors.grey[600],
  //                   fontSize: 14,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         if (controller.leagueInfo.value!['flag'] != null)
  //           CachedNetworkImage(
  //             imageUrl: controller.leagueInfo.value!['flag'],
  //             width: 30,
  //             height: 20,
  //             placeholder: (context, url) => Container(
  //               width: 30,
  //               height: 20,
  //               color: Colors.grey[200],
  //             ),
  //             errorWidget: (context, url, error) => Icon(Icons.flag),
  //           ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildStandingsTable(List<StandingItem> standings) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // Table header
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                _buildHeaderCell('#', width: 40),
                _buildHeaderCell('Team',
                    flex: 3, alignment: Alignment.centerLeft),
                _buildHeaderCell('P', width: 35),
                _buildHeaderCell('W', width: 35),
                _buildHeaderCell('D', width: 35),
                _buildHeaderCell('L', width: 35),
                _buildHeaderCell('GD', width: 40),
                _buildHeaderCell('Pts', width: 40),
              ],
            ),
          ),
          // Divider

          // Table rows
          ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(vertical: 2),
            physics: NeverScrollableScrollPhysics(),
            itemCount: standings.length,
            itemBuilder: (context, index) {
              final standing = standings[index];
              final isHighlighted =
                  controller.fixture.homeTeam.name == standing.team.name ||
                      controller.fixture.awayTeam.name == standing.team.name;

              return Container(
                color: isHighlighted ? Colors.grey[300] : null,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      _buildCell(
                        standing.rank.toString(),
                        width: 40,
                        textColor: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            children: [
                              CachedNetworkImage(
                                imageUrl: standing.team.logo,
                                width: 24,
                                height: 24,
                                placeholder: (context, url) => Container(
                                  width: 24,
                                  height: 24,
                                  color: Colors.grey[200],
                                ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.sports_soccer, size: 24),
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  standing.team.name,
                                  style: TextStyle(
                                    fontWeight: isHighlighted
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    color:
                                        isHighlighted ? ajired : Colors.black,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      _buildCell(standing.all.played.toString(), width: 35),
                      _buildCell(standing.all.win.toString(), width: 35),
                      _buildCell(standing.all.draw.toString(), width: 35),
                      _buildCell(standing.all.lose.toString(), width: 35),
                      _buildCell(standing.goalsDiff.toString(), width: 40),
                      _buildCell(
                        standing.points.toString(),
                        width: 40,
                        fontWeight: FontWeight.bold,
                        textColor: Colors.black,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          // Show qualification info for this group if available
        ],
      ),
    );
  }

  Widget _buildHeaderCell(String text,
      {double? width, int? flex, Alignment alignment = Alignment.center}) {
    return width != null
        ? SizedBox(
            width: width,
            child:
                _buildAlignedText(text, FontWeight.bold, alignment: alignment),
          )
        : Expanded(
            flex: flex ?? 1,
            child:
                _buildAlignedText(text, FontWeight.bold, alignment: alignment),
          );
  }

  Widget _buildCell(String text,
      {double? width,
      int? flex,
      Color? textColor,
      FontWeight? fontWeight,
      }) {
    final textWidget = Text(
      text,
      style: TextStyle(
        color: textColor ?? Colors.black87,
        fontWeight: fontWeight ?? FontWeight.normal,
      ),
      textAlign: TextAlign.center,
    );

    return width != null
        ? SizedBox(
            width: width,
            child: Center(child: textWidget),
          )
        : Expanded(
            flex: flex ?? 1,
            child: Center(child: textWidget),
          );
  }

  Widget _buildAlignedText(String text, FontWeight fontWeight,
      {Alignment alignment = Alignment.center}) {
    return Align(
      alignment: alignment,
      child: Text(
        text,
        style: TextStyle(
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}
