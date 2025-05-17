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

  // Data containers
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

  // UI state variables
  var isLoading = true.obs;
  var error = ''.obs;
  RxBool selectedIndex = true.obs;

  @override
  void onInit() {
    fetchFixtures();
    super.onInit();
  }

  // Optimized fixture fetching without pagination since the API doesn't support it
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

        // Process in batches to avoid UI freezes with large datasets
        _processFixturesInBatches(fixtureJson);
      } else {
        error.value = 'Failed: ${response.statusCode}';
      }
    } catch (e) {
      error.value = 'Error: $e';
    } finally {
      isLoading.value = false;
    }
  }

  // Process fixtures in small batches to keep the UI responsive
  void _processFixturesInBatches(List<dynamic> fixtureJson) {
    const int batchSize = 10;
    int processedCount = 0;

    // Process first batch immediately
    _processFixtureBatch(fixtureJson, 0, batchSize);
    processedCount += batchSize;

    // Process remaining batches with small delays to avoid blocking UI
    while (processedCount < fixtureJson.length) {
      final int nextBatchSize =
          (processedCount + batchSize <= fixtureJson.length)
              ? batchSize
              : fixtureJson.length - processedCount;

      Future.delayed(Duration(milliseconds: 50), () {
        if (Get.isRegistered<FixtureController>()) {
          // Check if controller is still active
          _processFixtureBatch(fixtureJson, processedCount, nextBatchSize);
        }
      });

      processedCount += nextBatchSize;
    }
  }

  // Process a batch of fixtures
  void _processFixtureBatch(
      List<dynamic> fixtureJson, int startIndex, int count) {
    final endIndex = startIndex + count;
    if (endIndex > fixtureJson.length) return;

    final batchData = fixtureJson.sublist(startIndex, endIndex);
    final newFixtures =
        batchData.map((json) => FixtureSimple.fromJson(json)).toList();

    fixtures.addAll(newFixtures);
    searchfixtures.addAll(newFixtures);
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
