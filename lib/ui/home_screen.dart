import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/restaurant_provider.dart';
import '../data/enum/result_state.dart';
import '../widgets/card_restaurant.dart';
import '../widgets/text_message.dart';
import '../widgets/loading_progress.dart';

import 'restaurant_search.dart';



class HomeScreen extends StatelessWidget {
  static const routeName = '/restaurant';
  
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(context),
        body: _buildList(),
    );
  }
  
  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Chiks Restaurant',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        )),
      actions: [
        IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.pushNamed(context,
                  RestaurantSearch.routeName);
            },
        ),
      ],
    );
  }

  Widget _buildList() {
    return Consumer<RestaurantProvider>(
      builder: (_, provider, __) {
        switch (provider.state){
          case ResultState.loading:
            return const LoadingProgress();
          case ResultState.hasData:
            return ListView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              itemCount: provider.result.count,
              itemBuilder: (_, index){
                final restaurant = provider.result.restaurants[index];
                return CardRestaurant(restaurant: restaurant);
              },
            );
          case ResultState.noData:
            return const TextMessage(
              image: 'assets/no-data.png',
              message: 'Data Kosong',
            );
          case ResultState.error:
            return TextMessage(
              image: 'assets/no-internet.png',
              message: 'Koneksi Terputus',
              onPressed: () => provider.fetchAllRestaurant(),
            );
          default:
            return const SizedBox();
        }
      },
    );
  }
}