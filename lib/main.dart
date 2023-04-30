import 'package:flutter/material.dart';

import 'core/inject/inject.dart';
import 'modules/home/presenter/home_page.dart';

void main() {
  Inject.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SearchAndStayChallenge',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
