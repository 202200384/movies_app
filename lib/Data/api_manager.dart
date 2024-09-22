import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_app/Data/Response/BrowserDiscoveryResponse.dart';
import 'package:movies_app/Data/Response/BrowserResponse.dart';
import 'package:movies_app/Data/Response/DetailsResponse.dart';
import 'package:movies_app/Data/Response/SimilarMoviesResponse.dart';
import 'package:movies_app/Data/Response/TopRatedOrPopularResponse.dart';

import 'package:movies_app/Data/end_points.dart';

import 'Response/upComingResponse.dart';

class ApiManager {
  static const String baseUrl = 'api.themoviedb.org';
  static const String apiKey = '34e003d4b9d026a15d3cc1a2ce2c3fd2';
  static const String language = 'en-US';
  static const String page = '1';

  // Get all Top Rated movies
  static Future<TopRatedOrPopularResponse> getAllTopRated() async {
    Uri url = Uri.https(
      baseUrl,
      EndPoints.topRated,
      {
        'api_key': apiKey,
        'language': language,
        'page': page,
      },
    );
    try {
      var response = await http.get(url);
      var bodyString = response.body;
      var json = jsonDecode(bodyString);

      return TopRatedOrPopularResponse.fromJson(json);
    } catch (e) {
      throw e;
    }
  }

  // Get all Popular movies
  static Future<TopRatedOrPopularResponse> getAllPopular() async {
    Uri url = Uri.https(
      baseUrl,
      EndPoints.popular,
      {
        'api_key': apiKey,
        'language': language,
        'page': page,
      },
    );
    try {
      var response = await http.get(url);
      var bodyString = response.body;
      var json = jsonDecode(bodyString);

      return TopRatedOrPopularResponse.fromJson(json);
    } catch (e) {
      throw e;
    }
  }

  // Get all Upcoming movies
  static Future<UpComingResponse> getAllUpComing() async {
    Uri url = Uri.https(
      baseUrl,
      EndPoints.upComing,
      {
        'api_key': apiKey,
        'language': language,
        'page': page,
      },
    );
    try {
      var response = await http.get(url);
      var bodyString = response.body;
      var json = jsonDecode(bodyString);

      return UpComingResponse.fromJson(json);
    } catch (e) {
      throw e;
    }
  }

  // Get movie details
  static Future<DetailsResponse> getAllDetails(int movieId) async {
    Uri url = Uri.https(
      baseUrl,
      '${EndPoints.details}/$movieId',
      {
        'api_key': apiKey,
        'language': language,
      },
    );
    try {
      var response = await http.get(url);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        var bodyString = response.body;
        var json = jsonDecode(bodyString);
        return DetailsResponse.fromJson(json);
      } else {
        print('response body:${response.body}');
        throw Exception('Failed to load movie details: ${response.statusCode}');
      }
    } catch (e) {
      print('Error details:$e');
      throw Exception('Error fetching movie details: $e');
    }
  }

  // Get similar movies
  static Future<SimilarDetailsResponse> getAllSimilarDetails(int movieId) async {
    Uri url = Uri.https(
      baseUrl,
      '${EndPoints.similarDetails}/$movieId/similar',
      {
        'api_key': apiKey,
        'language': language,
        'page': page,
      },
    );
    try {
      var response = await http.get(url);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        var bodyString = response.body;
        var json = jsonDecode(bodyString);
        return SimilarDetailsResponse.fromJson(json);
      } else {
        throw Exception('Failed to load similar movies: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching similar movies: $e');
    }
  }

  static Future<BrowserResponse> getAllMovieList() async {
    Uri url = Uri.https(baseUrl, EndPoints.movieList, {
      'api_key': apiKey,
    });
    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        print('API Response: $json');
        return BrowserResponse.fromJson(json);
      } else {
        throw Exception(
            'Failed to load movies. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
      throw e;
    }
  }

  static Future<BrowserDiscoveryResponse> getAllDiscoveryMovieList(String genderId) async {
    Uri url = Uri.https(baseUrl, EndPoints.DiscoverMovieList, {
      'api_key': apiKey,
      'with_genres':genderId
    });
    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        print('API Response: $json');
        return BrowserDiscoveryResponse.fromJson(json);
      } else {
        throw Exception(
            'Failed to load movies. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
      throw e;
    }
  }
}