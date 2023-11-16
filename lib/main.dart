import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:wysowl/src/features/routes/route_configs.dart';
import 'package:wysowl/src/providers/media_query_provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build (BuildContext context) {

    var mediaQuery = MediaQuery.of(context);
    double width = mediaQuery.size.width;
    double height = mediaQuery.size.height;

    screenWidth= width;
    screenHeight = height;
    
    return ProviderScope(
      child: MaterialApp.router(
        routerConfig: router,
        theme: ThemeData(useMaterial3: true),
        themeMode: ThemeMode.system,
      ),
    );
  }
}
