class ComingupModel {
  final String awayteam;
  final String hometeam;
  final String imageUrl;
  final String matchDate;
  final String matchTime;
  final String venue;

  ComingupModel(
      {required this.awayteam,
      required this.hometeam,
      required this.imageUrl,
      required this.matchDate,
      required this.matchTime,
      required this.venue});

  factory ComingupModel.fromFirestore(Map<String, dynamic> data) {
    return ComingupModel(
        awayteam: data['awayTeam'] ?? "empty",
        hometeam: data['homeTeam'] ?? "empty",
        imageUrl: data['imageUrl'],
        matchDate: data["matchDate"] ?? "empty",
        matchTime: data["matchTime"] ?? "empty",
        venue: data["venue"] ?? "empty");
  }
}
