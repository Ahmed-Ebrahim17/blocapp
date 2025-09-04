import 'package:blocapp/app_route.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(BreakingBadApp(
    appRoute: AppRoute(),
  ));
}

class BreakingBadApp extends StatelessWidget {
  const BreakingBadApp({super.key, required this.appRoute});
  final AppRoute appRoute;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRoute.generateRoute,
    );
  }
}
