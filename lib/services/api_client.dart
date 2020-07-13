import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:income_tracker/models/models.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  final http.Client httpClient;

  ApiClient({
    @required this.httpClient,
  }) : assert(httpClient != null);

  Future<List<Job>> fetchJobHistory() async {
    // Run a python simple http server in 'assets/json/' folder directory to retrieve data
    // final String server = defaultTargetPlatform == TargetPlatform.android
    //     ? '10.0.2.2'
    //     : 'localhost';
    // final String jsonUrl = 'http://$server:8000/mock_data.json';

    // OR get data from mockaroo url
    const String jsonUrl =
        'https://my.api.mockaroo.com/income_tracker.json?key=ca8df020';

    final http.Response urlResponse = await httpClient.get(jsonUrl);

    if (urlResponse.statusCode != 200) {
      throw Exception('Error getting job history from server!');
    }

    final Iterable json = jsonDecode(urlResponse.body) as Iterable;
    return List<Job>.from(
        json.map((e) => Job.fromJson(e as Map<String, dynamic>)));
  }
}
