import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/database_provider.dart';
import '../data/enum/result_state.dart';
import '../widgets/card_restaurant.dart';
import '../widgets/text_message.dart';

class RestaurantFavorite extends StatelessWidget {
  static const routeName ='/restaurant_favorite';

  const RestaurantFavorite({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildList(),
    );
  }

  AppBar _buildAppBar(BuildContext context){
    return AppBar(
      title: const Text('Favorite',
        style: TextStyle(
        fontWeight: FontWeight.bold,
      )),
    );
  }

  Widget _buildList(){
    return Consumer<DatabaseProvider>(
      builder: (_, provider, __){
        if (provider.state == ResultState.hasData){
          return ListView.builder(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            itemCount: provider.favorites.length,
            itemBuilder: (_, index){
              final restaurant = provider.favorites[index];
              return CardRestaurant(restaurant: restaurant);
            },
          );
        } else {
          return TextMessage(
            image: 'assets/empty-data.png',
            message: provider.message,
          );
        }
      },
    );
  }

}