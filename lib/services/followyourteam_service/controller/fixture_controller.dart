import 'package:ajiapp/routing.dart';
import 'package:ajiapp/services/followyourteam_service/model/fixture_model.dart';
import 'package:ajiapp/services/followyourteam_service/model/stadium_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FixtureController extends GetxController {
  final int leagueid = 6;
  final int season = 2025;
  final String api_token = "eb019172e018ad81e65c44fa21d24227";

  // Data containers
  var fixtures = <FixtureSimple>[].obs;
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

  // UI state variables
  var isLoading = true.obs;
  var error = ''.obs;
  RxBool selectedIndex = true.obs;

  @override
  void onInit() {
    fetchFixtures();
    super.onInit();
  }

  // Direct fixture fetching without batching
  Future<void> fetchFixtures() async {
    try {
      isLoading.value = true;
      fixtures.clear();
      searchfixtures.clear();

      var url =
          'https://v3.football.api-sports.io/fixtures?league=$leagueid&season=$season';
      var headers = {
        'x-apisports-key': api_token,
      };

      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final List<dynamic> fixtureJson = jsonData['response'];

        // Process all fixtures at once
        final allFixtures =
            fixtureJson.map((json) => FixtureSimple.fromJson(json)).toList();
        fixtures.addAll(allFixtures);
        searchfixtures.addAll(allFixtures);
      } else {
        error.value = 'Failed: ${response.statusCode}';
      }
    } catch (e) {
      error.value = 'Error: $e';
    } finally {
      isLoading.value = false;
    }
  }

  // Optimized search function
  void searchTeam(String teamname) {
    if (teamname.isEmpty) {
      fixtures.value = searchfixtures;
      return;
    }

    // Convert to lowercase once for efficiency
    final lowercaseQuery = teamname.toLowerCase();

    fixtures.value = searchfixtures.where((fixture) {
      final homeTeamLower = fixture.homeTeam.name.toLowerCase();
      final awayTeamLower = fixture.awayTeam.name.toLowerCase();

      return homeTeamLower.contains(lowercaseQuery) ||
          awayTeamLower.contains(lowercaseQuery);
    }).toList();
  }

  // Compute team names efficiently with memoization
  final _cachedTeamNames = <String>{};

  Set<String> get teamsnames {
    if (_cachedTeamNames.isEmpty && searchfixtures.isNotEmpty) {
      for (var fixture in searchfixtures) {
        _cachedTeamNames.add(fixture.homeTeam.name);
        _cachedTeamNames.add(fixture.awayTeam.name);
      }

      // Sort for UI presentation
      final sorted = _cachedTeamNames.toList()..sort((a, b) => a.compareTo(b));
      _cachedTeamNames.clear();
      _cachedTeamNames.addAll(sorted);
    }
    return _cachedTeamNames;
  }

  void onchanged() {
    selectedIndex.value = !selectedIndex.value;
  }

  void showTeamDetails(FixtureSimple fixture) {
    Get.toNamed(Routes.TEAM_DETAILS, arguments: {
      'fixture': fixture,
      'leagueid': leagueid,
      'season': season,
      'api_token': api_token
    });
  }

  // Clear cache when controller is disposed
  @override
  void onClose() {
    _cachedTeamNames.clear();
    super.onClose();
  }
}
