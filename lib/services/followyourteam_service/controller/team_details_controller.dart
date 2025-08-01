import 'dart:developer';

import 'package:ajiapp/services/followyourteam_service/model/fixture_model.dart';
import 'package:ajiapp/services/followyourteam_service/model/stadium_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TeamDetailsController extends GetxController {
  late int season;
  late int leagueid;
  late FixtureSimple fixture;
  late String api_token;
  var stadiumsinfo = <StadiumModel>[].obs;
  late StadiumModel stadium;

  // Tab selection
  Rx<int> tabIndex = 0.obs;

  // Standings data
  RxBool isLoadingStandings = true.obs;
  RxString standingsError = ''.obs;
  RxList<StandingItem> standings = <StandingItem>[].obs;
  Rx<Map<String, dynamic>?> leagueInfo = Rx<Map<String, dynamic>?>(null);

  @override
  void onInit() {
    season = Get.arguments['season'];
    leagueid = Get.arguments['leagueid'];
    fixture = Get.arguments['fixture'];
    api_token = Get.arguments['api_token'];
    stadiumsinfo.value = Get.arguments['stadiums'];
    getStadium();
    // Fetch standings data when controller is initialized
    fetchStandings();

    super.onInit();
  }

  getStadium() {
    stadium = stadiumsinfo.firstWhere(
      (stadium) => stadium.apiVenueId == fixture.venueId,
      orElse: () => StadiumModel(
        name: "Unknown Stadium",
        apiVenueId: 0,
        city: "Unknown City",
        imageUrl:
            "https://firebasestorage.googleapis.com/v0/b/ajiapp-d436f.firebasestorage.app/o/stadiums%2F1753662942090_3cf54388-6b61-4c85-8d55-7e379d9d1639.png?alt=media&token=73f45c00-a97e-453a-9b65-cc23b7670d64",
        capacity: "0",
        description: "No description available",
        inauguration: "Unknown",
        homeGroundFor: "Unknown",
      ),
    );
  }

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }

  // Fetch standings data from API
  Future<void> fetchStandings() async {
    try {
      isLoadingStandings.value = true;
      standingsError.value = '';

      final url =
          'https://v3.football.api-sports.io/standings?league=$leagueid&season=$season';

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'x-apisports-key': api_token,
        },
      );
      log('response: ${response.body}');

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        if (jsonData['results'] == 0 || jsonData['response'].isEmpty) {
          standingsError.value = 'No standings data available';
          isLoadingStandings.value = false;
          return;
        }

        // Parse league info
        final leagueData = jsonData['response'][0]['league'];
        leagueInfo.value = {
          'id': leagueData['id'],
          'name': leagueData['name'],
          'country': leagueData['country'],
          'logo': leagueData['logo'],
          'flag': leagueData['flag'],
          'season': leagueData['season'],
        };

        // Parse standings
        List<StandingItem> parsedStandings = [];
        for (var standingGroup in leagueData['standings']) {
          for (var standing in standingGroup) {
            parsedStandings.add(StandingItem.fromJson(standing));
          }
        }

        standings.value = parsedStandings;
        isLoadingStandings.value = false;
      } else {
        standingsError.value =
            'Failed to load standings: ${response.statusCode}';
        isLoadingStandings.value = false;
      }
    } catch (e) {
      standingsError.value = 'Error: $e';
      isLoadingStandings.value = false;
    }
  }
}

// Model classes to parse API response
class StandingItem {
  final int rank;
  final TeamInfo team;
  final int points;
  final int goalsDiff;
  final String? group;
  final String? form;
  final String? status;
  final String? description;
  final StatsDetail all;
  final StatsDetail home;
  final StatsDetail away;
  final String? update;

  StandingItem({
    required this.rank,
    required this.team,
    required this.points,
    required this.goalsDiff,
    this.group,
    this.form,
    this.status,
    this.description,
    required this.all,
    required this.home,
    required this.away,
    this.update,
  });

  factory StandingItem.fromJson(Map<String, dynamic> json) {
    return StandingItem(
      rank: json['rank'] ?? 0,
      team: TeamInfo.fromJson(json['team'] ?? {}),
      points: json['points'] ?? 0,
      goalsDiff: json['goalsDiff'] ?? 0,
      group: json['group'],
      form: json['form'],
      status: json['status'],
      description: json['description'],
      all: StatsDetail.fromJson(json['all'] ?? {}),
      home: StatsDetail.fromJson(json['home'] ?? {}),
      away: StatsDetail.fromJson(json['away'] ?? {}),
      update: json['update'],
    );
  }
}

class TeamInfo {
  final int id;
  final String name;
  final String logo;

  TeamInfo({
    required this.id,
    required this.name,
    required this.logo,
  });

  factory TeamInfo.fromJson(Map<String, dynamic> json) {
    return TeamInfo(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Unknown',
      logo: json['logo'] ?? '',
    );
  }
}

class StatsDetail {
  final int played;
  final int win;
  final int draw;
  final int lose;
  final Goals goals;

  StatsDetail({
    required this.played,
    required this.win,
    required this.draw,
    required this.lose,
    required this.goals,
  });

  factory StatsDetail.fromJson(Map<String, dynamic> json) {
    return StatsDetail(
      played: json['played'] ?? 0,
      win: json['win'] ?? 0,
      draw: json['draw'] ?? 0,
      lose: json['lose'] ?? 0,
      goals: Goals.fromJson(json['goals'] ?? {}),
    );
  }
}

class Goals {
  final int forGoals;
  final int against;

  Goals({
    required this.forGoals,
    required this.against,
  });

  factory Goals.fromJson(Map<String, dynamic> json) {
    return Goals(
      forGoals: json['for'] ?? 0,
      against: json['against'] ?? 0,
    );
  }
}
