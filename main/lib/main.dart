import 'package:flutter/material.dart';
import 'package:main/globalclass/app_initializer.dart';

void
    main() async {
  await AppInitializer
      .initializeApp();
  runApp(
      const MyApp());
}

class MyApp
    extends StatelessWidget {
  const MyApp(
      {super.key});

  @override
  Widget
      build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Maps',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home:
    );
  }
}
