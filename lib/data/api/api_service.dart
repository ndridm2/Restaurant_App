import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/restaurant.dart';
import '../model/restaurant_detail.dart';
import '../model/restaurant_search.dart';
import '../model/add_review.dart';

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev';

  //data list
  Future<RestaurantResult> getRestaurant() async {
    final response = await http.get(Uri.parse('$_baseUrl/list'));
    if (response.statusCode == 200) {
      return RestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data!');
    }
  }

  //list detail
  Future<RestaurantDetailResult> getRestaurantDetail(String id) async {
    final response = await http.get(Uri.parse('$_baseUrl/detail/$id'));
    if (response.statusCode == 200) {
      return RestaurantDetailResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data!');
    }
  }

  //data searching
  Future<RestaurantSearchResult> getRestaurantSearch(String query) async {
    final response = await http.get(Uri.parse('$_baseUrl/search?q=$query'));
    if (response.statusCode == 200) {
      return RestaurantSearchResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }

  //add review
  Future<AddReviewResult> addReview({
    required String id,
    required String name,
    required String review,
  }) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/review'),
      body: jsonEncode(<String, String>{
        'id': id,
        'name': name,
        'review': review,
      }),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 201) {
      return AddReviewResult.fromJson(json.decode(response.body));
    }else {
      throw Exception('Failed Add data!');
    }
  }
}