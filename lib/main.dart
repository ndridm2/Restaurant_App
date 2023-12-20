import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'data/model/restaurant.dart';
import 'data/api/api_service.dart';
import 'data/db/database_helper.dart';
import 'provider/preferences_provider.dart';
import 'data/preferences/preferences_helper.dart';
import 'provider/database_provider.dart';
import 'provider/restaurant_provider.dart';
import 'provider/restaurant_search_provider.dart';
import 'provider/scheduling_provider.dart';

import 'common/navigation.dart';
import 'common/styles.dart';

import 'utils/background_service.dart';
import 'utils/notification_helper.dart';

import 'ui/menu_home.dart';
import 'ui/splash_screen.dart';
import 'ui/home_screen.dart';
import 'ui/detail_screen.dart';
import 'ui/restaurant_search.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService service = BackgroundService();

  service.initializeIsolate();

  if (Platform.isAndroid){
    await AndroidAlarmManager.initialize();
  }

  await notificationHelper.initNotifications(
      flutterLocalNotificationsPlugin
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => DatabaseProvider(
                databaseHelper: DatabaseHelper()),
          ),
          ChangeNotifierProvider(
            create: (_) => RestaurantProvider(
              apiService: ApiService(http.Client()),
            ),
          ),
          ChangeNotifierProvider(
            create: (_) => RestaurantSearchProvider(
              apiService: ApiService(http.Client()),
            ),
          ),
          ChangeNotifierProvider(
              create: (_) => SchedulingProvider(),
          ),
          ChangeNotifierProvider(
              create: (context) => PreferencesProvider(
                  preferencesHelper: PreferencesHelper(
                    sharedPreferences: SharedPreferences.getInstance(),
                  ),
              ),
          )
        ],
      child: MaterialApp(
        title: 'Chiks Restaurant',
        theme: ThemeData(
          colorScheme: Theme.of(context).colorScheme.copyWith(
            primary: primaryColor,
            onPrimary: Colors.black,
            secondary: secondaryColor,
          ),
          scaffoldBackgroundColor: Colors.white,
          textTheme: myTextTheme,
          appBarTheme: AppBarTheme(
            elevation: 0,
            color: secondaryColor,
            titleTextStyle: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(color: Colors.white,
            ),
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        navigatorKey: navigatorKey,
        initialRoute: SplashScreen.routeName,
        routes: {
          SplashScreen.routeName: (_) => const SplashScreen(),
          MenuHome.routeName: (_) => const MenuHome(),
          HomeScreen.routeName: (_) => const HomeScreen(),
          DetailScreen.routeName: (context) => DetailScreen(
              restaurant:
              ModalRoute.of(context)
                  ?.settings.arguments as Restaurant),
          RestaurantSearch.routeName: (_) => const RestaurantSearch(),
        },
      ),
    );
  }
}