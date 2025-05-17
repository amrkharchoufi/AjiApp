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
