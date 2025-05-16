import 'package:ajiapp/routing.dart';
import 'package:ajiapp/services/followyourteam_service/model/fixture_model.dart';
import 'package:ajiapp/services/followyourteam_service/model/stadium_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FixtureController extends GetxController {
  final int leagueid = 6;
  final int season = 2023;
  final String api_token = "eb019172e018ad81e65c44fa21d24227";

  var fixtures = <FixtureSimple>[].obs;
  var newfixtures = <FixtureSimple>[].obs;
  var searchfixtures = <FixtureSimple>[].obs;
  var stadiums = <String>["Prince Moulay Abdellah Stadium"].obs;
  var stadiumsinfo = <StadiumModel>[
    StadiumModel(
      name: "Prince Moulay Abdellah Stadium",
      imageUrl: "assets/images/stadium.jpg",
      city: "Rabat",
    ),
    StadiumModel(
      name: "Prince Moulay Abdellah Stadium",
      imageUrl: "assets/images/stadium.jpg",
      city: "Rabat",
    ),
  ].obs;
  var isLoading = true.obs;
  var error = ''.obs;
  RxBool selectedIndex = true.obs;
  @override
  void onInit() {
    fetchFixtures();
    super.onInit();
  }

  void fetchFixtures() async {
    var url =
        'https://v3.football.api-sports.io/fixtures?league=$leagueid&season=$season';
    var headers = {
      'x-apisports-key': api_token,
    };

    try {
      isLoading.value = true;
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final List<dynamic> fixtureJson = jsonData['response'];

        fixtures.value =
            fixtureJson.map((json) => FixtureSimple.fromJson(json)).toList();
        searchfixtures.value =
            fixtureJson.map((json) => FixtureSimple.fromJson(json)).toList();
      } else {
        error.value = 'Failed: ${response.statusCode}';
      }
    } catch (e) {
      error.value = 'Error: $e';
    } finally {
      isLoading.value = false;
    }
  }

  void searchTeam(String teamname) {
    if (teamname.isNotEmpty) {
      fixtures.value = searchfixtures
          .where((fixture) =>
              fixture.homeTeam.name
                  .toLowerCase()
                  .contains(teamname.toLowerCase()) ||
              fixture.awayTeam.name
                  .toLowerCase()
                  .contains(teamname.toLowerCase()))
          .toList();
    } else {
      fetchFixtures();
    }
  }

  Set<String> get teamsnames {
    final names = <String>[];
    for (var fixture in searchfixtures) {
      names.add(fixture.homeTeam.name);
      names.add(fixture.awayTeam.name);
    }
    names.sort((a, b) => a.compareTo(b));
    return names.toSet();
  }

  void onchanged() {
    selectedIndex.value = !selectedIndex.value;
  }

  showTeamDetails(FixtureSimple fixture) {
    Get.toNamed(Routes.TEAM_DETAILS, arguments: {
      'fixture': fixture,
      'leagueid': leagueid,
      'season': season,
      'api_token': api_token
    });
  }
}
