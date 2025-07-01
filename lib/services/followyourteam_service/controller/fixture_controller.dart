import 'dart:developer';

import 'package:ajiapp/routing.dart';
import 'package:ajiapp/services/followyourteam_service/model/fixture_model.dart';
import 'package:ajiapp/services/followyourteam_service/model/stadium_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FixtureController extends GetxController {
  final int leagueid = 6;
  final int season = 2025;
  final String api_token = "eb019172e018ad81e65c44fa21d24227";
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Data containers
  var fixtures = <FixtureSimple>[].obs;
  var searchfixtures = <FixtureSimple>[].obs;
  var stadiums = <String>["Prince Moulay Abdellah Stadium"].obs;
  var stadiumsinfo = <StadiumModel>[].obs;
  var allStadiums = <StadiumModel>[].obs;
  late StadiumModel selectedstd;

  // UI state variables
  var isLoading = true.obs;
  var isloadingstd = true.obs;
  var error = ''.obs;
  RxBool selectedIndex = true.obs;

  @override
  void onInit() {
    fetchFixtures();
    fetchstadiums();
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

  Future<void> fetchstadiums() async {
    try {
      isloadingstd.value = true;

      // Fetch all hotels at once
      final QuerySnapshot snapshot =
          await _firestore.collection('stadiums').get();
      allStadiums.clear();
      stadiumsinfo.clear(); // Clear existing data
      stadiums.clear(); // Clear existing cities
      stadiums.add('All Stadiums'); // Add default option

      for (var doc in snapshot.docs) {
        final std =
            StadiumModel.fromFirestore(doc.data() as Map<String, dynamic>);
        stadiumsinfo.add(std);
        allStadiums.add(std);

        // Add city to cities list if not already present
        if (!stadiums.contains(std.name)) {
          stadiums.add(std.name);
        }
      }

      // Sort cities alphabetically
      stadiums.sort((a, b) {
        if (a == 'All Stadiums') return -1;
        if (b == 'All Stadiums') return 1;
        return a.compareTo(b);
      });
    } catch (e) {
      log("Error fetching stadiums: ${e.toString()}");
    } finally {
      isloadingstd.value = false;
    }
  }

  void searchstadium(String stadiumName) {
    if (stadiumName == 'All Stadiums' || stadiumName.isEmpty) {
      stadiumsinfo.value = allStadiums;
      return;
    }

    final results = allStadiums
        .where(
            (std) => std.name.toLowerCase().contains(stadiumName.toLowerCase()))
        .toList();

    stadiumsinfo.value = results;
  }

  void selectstadium(StadiumModel std) {
    selectedstd = std;
    Get.toNamed(Routes.STADIUM_DETAILS);
  }
}
