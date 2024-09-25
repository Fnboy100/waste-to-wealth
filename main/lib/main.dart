import 'package:flutter/material.dart';
import 'package:main/globalclass/app_initializer.dart';
import 'package:main/Hompage/homepage.dart';

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
      title: 'waste to wealth',
      theme: ThemeData(
        colorScheme:ColorScheme.fromSeed(seedColor: const Color.fromRGBO(255, 255, 255, 0)),
        useMaterial3: true,
        textTheme: const TextTheme(
          headlineSmall: TextStyle(
            fontFamily: 'ArchivoBold',
            fontSize: 18,
            height: 28 / 18,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
          headlineLarge: TextStyle(
            fontFamily: 'ArchivoBold',
            fontSize: 32,
            height: 48/32,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
          headlineMedium: TextStyle(
            fontFamily: 'ArchivoBold',
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
          bodyMedium:TextStyle(
            fontFamily: 'InterRegular',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),

          ),
      ),
      home: const HomePage(),
    );
  }
}
