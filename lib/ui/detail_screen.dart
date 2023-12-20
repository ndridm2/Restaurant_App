import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../data/api/api_service.dart';
import '../data/model/restaurant.dart';
import '../provider/restaurant_detail_provider.dart';
import '../data/enum/result_state.dart';
import '../widgets/content_restaurant.dart';
import '../widgets/text_message.dart';
import '../widgets/loading_progress.dart';

class DetailScreen extends StatelessWidget {
  
  static const routeName = '/restaurant_detail';
  
  final Restaurant restaurant;
  
  const DetailScreen({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantDetailProvider>(
      create: (_) => RestaurantDetailProvider(
          apiService: ApiService(http.Client()),
          restaurantId: restaurant.id
      ),
      child: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<RestaurantDetailProvider>(
          builder: (_, provider, __){
            switch (provider.state) {
              case ResultState.loading:
                return const LoadingProgress();
              case ResultState.hasData:
                return ContentRestaurant(
                    restaurant: provider.result.restaurant,
                    provider: provider
                );
              case ResultState.error:
                return TextMessage(
                  image: 'assets/no-internet.png',
                  message: 'Connection lost!',
                  onPressed:  () =>
                      provider.fetchDetailRestaurant(restaurant.id),
                );
              default:
                return const SizedBox();
            }
          },
        ),
      ),
        floatingActionButton: _backButton(context),
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
  }

  Widget _backButton(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
      child: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}
