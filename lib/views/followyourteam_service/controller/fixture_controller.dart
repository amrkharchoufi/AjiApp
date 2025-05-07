import 'package:ajiapp/views/followyourteam_service/model/fixture_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class FixtureController extends GetxController {
  var fixtures = <FixtureSimple>[].obs;
  var isLoading = true.obs;
  var error = ''.obs;

  @override
  void onInit() {
    fetchFixtures();
    super.onInit();
  }

  void fetchFixtures() async {
    const url = 'https://v3.football.api-sports.io/fixtures?league=6&season=2023';
    const headers = {
      'x-apisports-key': '25c13a59fbbd8e59fc2f389324acac97', 
    };

    try {
      isLoading.value = true;
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final List<dynamic> fixtureJson = jsonData['response'];

        fixtures.value = fixtureJson
            .map((json) => FixtureSimple.fromJson(json))
            .toList();
      } else {
        error.value = 'Failed: ${response.statusCode}';
      }
    } catch (e) {
      error.value = 'Error: $e';
    } finally {
      isLoading.value = false;
    }
  }
}
