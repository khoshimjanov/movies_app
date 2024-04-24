import 'package:flutter/material.dart';
import 'package:movies_app/helpers/app_colors.dart';
import 'package:movies_app/providers/movies.dart';
import 'package:movies_app/providers/user.dart';
import 'package:movies_app/screens/check_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is th e root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Movies(),
        ),
        ChangeNotifierProvider(
          create: (context) => User(),
        ),
      ],
      child: MaterialApp(
        title: 'Movies',
        theme: themeData(),
        home: const CheckPage(),
        routes: routes(),
      ),
    );
  }
}

ThemeData themeData() {
  return ThemeData(
    primaryColorDark: AppColors.mainbackgroundColor,

    textTheme: const TextTheme(
        bodyMedium: TextStyle(color: Colors.white), bodySmall: TextStyle(),),
    primaryColorLight: Colors.white,

    navigationBarTheme: const NavigationBarThemeData(
        backgroundColor: AppColors.mainbackgroundColor,),
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    primaryColor: AppColors.mainbackgroundColor,
  );
}

Map<String, Widget Function(BuildContext)> routes() {
  return {};
}
