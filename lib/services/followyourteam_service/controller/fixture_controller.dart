import 'package:ajiapp/services/followyourteam_service/model/fixture_model.dart';
import 'package:ajiapp/services/followyourteam_service/model/stadium_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FixtureController extends GetxController {
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
    const url =
        'https://v3.football.api-sports.io/fixtures?league=6&season=2023';
    const headers = {
      'x-apisports-key': '25c13a59fbbd8e59fc2f389324acac97',
    };

    try {
      isLoading.value = true;
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final List<dynamic> fixtureJson = jsonData['response'];

        fixtures.value =
            fixtureJson.map((json) => FixtureSimple.fromJson(json)).toList();
            searchfixtures.value=fixtureJson.map((json) => FixtureSimple.fromJson(json)).toList();
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
}
