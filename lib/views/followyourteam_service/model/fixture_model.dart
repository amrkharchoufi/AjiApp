class FixtureSimple {
  final int id;
  final String date;
  final String venue;
  final TeamSimple homeTeam;
  final TeamSimple awayTeam;

  FixtureSimple({
    required this.id,
    required this.date,
    required this.venue,
    required this.homeTeam,
    required this.awayTeam,
  });

  factory FixtureSimple.fromJson(Map<String, dynamic> json) {
    return FixtureSimple(
      id: json['fixture']['id'],
      date: json['fixture']['date'],
      venue: json['fixture']['venue']['name'] ?? 'Unknown Venue',
      homeTeam: TeamSimple.fromJson(json['teams']['home']),
      awayTeam: TeamSimple.fromJson(json['teams']['away']),
    );
  }
}

class TeamSimple {
  final int id;
  final String name;
  final String logo;

  TeamSimple({
    required this.id,
    required this.name,
    required this.logo,
  });

  factory TeamSimple.fromJson(Map<String, dynamic> json) {
    return TeamSimple(
      id: json['id'],
      name: json['name'],
      logo: json['logo'],
    );
  }
}
