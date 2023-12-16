import 'package:flutter/material.dart';
import 'ui/splash_screen.dart';
import 'data/model/restaurant.dart';
import 'ui/home_screen.dart';
import 'ui/detail_screen.dart';
import 'ui/restaurant_search.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
      initialRoute: SplashScreen.routeName,
      routes: {
        HomeScreen.routeName: (_) => const HomeScreen(),
        DetailScreen.routeName: (context) => DetailScreen(
          restaurant:
          ModalRoute.of(context)?.settings.arguments as Restaurant),
        RestaurantSearch.routeName: (_) => const RestaurantSearch(),
      },
    );
  }
}