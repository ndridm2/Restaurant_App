import 'package:flutter/material.dart';
import '../data/api/api_service.dart';
import '../data/model/restaurant_detail.dart';
import '../data/enum/result_state.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;
  final String restaurantId;

  RestaurantDetailProvider({
  required this.apiService,
  required this.restaurantId,
}){
    fetchDetailRestaurant(restaurantId);
  }

  late RestaurantDetailResult _restaurantDetailResult;
  late ResultState _state;
  String _message = '';

  RestaurantDetailResult get result => _restaurantDetailResult;
  ResultState get state => _state;
  String get message => _message;

  Future<dynamic> fetchDetailRestaurant(String restaurantId) async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      final restaurantDetail = await apiService.getRestaurantDetail(restaurantId);
      _state = ResultState.hasData;
      notifyListeners();

      return _restaurantDetailResult = restaurantDetail;
    } catch (e){
      _state = ResultState.error;
      notifyListeners();

      return _message = 'Error --> $e';
    }
  }

  Future<dynamic> addReview({
    required String id,
    required String name,
    required String review,
  }) async {
    try {
      final addReviewResult = await apiService.addReview(
        id: id,
        name: name,
        review: review,
      );
      if (addReviewResult.error == false &&
          addReviewResult.message == 'success') {
        fetchDetailRestaurant(id);

        return ResultState.succes;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();

      return _message = 'Error --> $e';
    }
  }
}