import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/home_page.dart';
import 'features/properties/logic/property_provider.dart';
import 'features/properties/data/property_repository.dart';
import 'providers/search_box_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PropertyProvider(
            PropertyRepository(
              baseUrl: 'http://localhost:3000/api',
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => SearchBoxProvider(),
        ),
      ],
      child: const RentVerseApp(),
    ),
  );
}

class RentVerseApp extends StatelessWidget {
  const RentVerseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RentVerse',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const HomePage(), // HomePage is now the first screen
    );
  }
}