import 'package:flutter/material.dart';
import '../data/api/api_service.dart';
import '../data/model/restaurant.dart';
import '../data/enum/result_state.dart';

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantProvider({required this.apiService}){
    fetchAllRestaurant();
  }

  late RestaurantResult _restaurantResult;
  late ResultState _state;
  String _message = '';

  RestaurantResult get result => _restaurantResult;
  ResultState get state => _state;
  String get message => _message;

  Future<dynamic> fetchAllRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      final restaurant = await apiService.getRestaurant();
      if (restaurant.count == 0 && restaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();

        return _message = 'Empty Data';
      }else {
        _state = ResultState.hasData;
        notifyListeners();

        return _restaurantResult = restaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();

      return _message = 'Error --> $e';
    }
  }

}