import 'package:flutter/material.dart';
import '../data/api/api_service.dart';
import '../data/model/restaurant_search.dart';
import '../data/enum/result_state.dart';

class RestaurantSearchProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantSearchProvider({required this.apiService});

  late RestaurantSearchResult _restaurantSearchResult;
  ResultState? _state;
  String _message = '';

  RestaurantSearchResult get result => _restaurantSearchResult;
  ResultState? get state => _state;
  String get message => _message;

  Future<dynamic> fetchSearchRestaurant(String query) async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      final restaurantSearch = await apiService.getRestaurantSearch(query);
      if (restaurantSearch.founded == 0 &&
      restaurantSearch.restaurants.isEmpty){
        _state = ResultState.noData;
        notifyListeners();

        return _message = 'Search not found!';
      } else {
        _state = ResultState.hasData;
        notifyListeners();

        return _restaurantSearchResult = restaurantSearch;
      }
    }catch (e){
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}