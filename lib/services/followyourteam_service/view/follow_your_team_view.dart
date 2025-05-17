// ignore_for_file: deprecated_member_use

import 'package:ajiapp/services/followyourteam_service/controller/fixture_controller.dart';
import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:ajiapp/widgets/match_widget.dart';
import 'package:ajiapp/widgets/myappbar_widget.dart';
import 'package:ajiapp/widgets/searchbar.dart';
import 'package:ajiapp/widgets/stadium_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FollowYourTeamView extends StatefulWidget {
  const FollowYourTeamView({super.key});

  @override
  State<FollowYourTeamView> createState() => _FollowYourTeamViewState();
}

class _FollowYourTeamViewState extends State<FollowYourTeamView> {
  final FixtureController controller = Get.put(FixtureController());
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return Scaffold(
      body: Container(
        width: ScreenSize.width,
        height: ScreenSize.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  MyappbarWidget(title: "Follow Your Team"),
                  _buildTabSelector(),
                  _buildSearchBar(),
                  _buildContentHeader(),
                  _buildContentBody(),
                ],
              ),
            ),
            MyappbarWidget(title: "Follow Your Team"),
          ],
        ),
      ),
    );
  }

  // Build the team/stadium selector tabs
  Widget _buildTabSelector() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      height: 50,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            spreadRadius: 1,
            blurStyle: BlurStyle.outer,
          ),
        ],
      ),
      child: Row(
        children: [
          _buildTabOption("Teams", true),
          Spacer(),
          _buildTabOption("Stadiums", false),
        ],
      ),
    );
  }

  // Build individual tab options
  Widget _buildTabOption(String title, bool isTeamsTab) {
    return Obx(() {
      final isSelected = controller.selectedIndex.value == isTeamsTab;

      return Expanded(
        child: GestureDetector(
          onTap: () {
            if (controller.selectedIndex.value != isTeamsTab) {
              controller.onchanged();
            }
          },
          child: Container(
            height: 30,
            margin: EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
              color: isSelected ? Colors.white : Colors.transparent,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  color: isSelected ? ajired : Colors.grey,
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  // Build the search bar
  Widget _buildSearchBar() {
    return Obx(() {
      return SizedBox(
        width: ScreenSize.width / 1.4,
        height: 52,
        child: controller.selectedIndex.value
            ? SearchbarWidget(
                options: controller.teamsnames.toList(),
                onchanged: (value) {
                  controller.searchTeam(value!);
                },
                placeholder: "Search your team",
              )
            : SearchbarWidget(
                options: controller.stadiums,
                onchanged: (value) {
                  controller.searchTeam(value!);
                },
                placeholder: "Search Stadium",
              ),
      );
    });
  }

  // Build the content section header
  Widget _buildContentHeader() {
    return Padding(
      padding: EdgeInsets.only(left: ScreenSize.width / 20, top: 10, bottom: 5),
      child: Obx(() {
        return Align(
          alignment: Alignment.centerLeft,
          child: Text(
            controller.selectedIndex.value ? "Upcoming" : "Stadiums",
            style: TextStyle(
              fontSize: ScreenSize.width / 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      }),
    );
  }

  // Build the main content body
  Widget _buildContentBody() {
    return Obx(() {
      // Show loading indicator if loading initial data
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
    
      // Show error message if there's an error
      else if (controller.error.isNotEmpty) {
        return Center(child: Text(controller.error.value));
      }
    
      // Show content based on selected tab
      else {
        return controller.selectedIndex.value
            ? _buildMatchesList()
            : _buildStadiumsList();
      }
    });
  }

  // Build the list of matches with optimization
  Widget _buildMatchesList() {
    return Obx(() {
      final fixtures = controller.fixtures;

      if (fixtures.isEmpty) {
        return const Center(child: Text("No matches found"));
      }

      return Column(
        children: [
          ...List.generate(
            fixtures.length,
            (index) {
              return MatchWidget(
                key: ValueKey(fixtures[index].id),
                fixture: fixtures[index],
              );
            },
          ),
        ],
      );
    });
  }

  // Build the list of stadiums
  Widget _buildStadiumsList() {
    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: controller.stadiumsinfo.length,
      itemBuilder: (context, index) {
        final stadium = controller.stadiumsinfo[index];
        return StadiumWidget(
          key: ValueKey("stadium-${stadium.name}"),
          ImagePath: stadium.imageUrl!,
          MatchTitleaway: stadium.name!,
          Matchplace: stadium.city!,
          width: ScreenSize.width,
          height: ScreenSize.height / 6,
        );
      },
    );
  }
}
