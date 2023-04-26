
import 'package:flutter/material.dart';
import 'package:pr_gallary_app/views/screens/homepage.dart';
import 'package:pr_gallary_app/views/screens/splashscreen.dart';
import 'package:pr_gallary_app/views/screens/tabpage.dart';
import 'package:pr_gallary_app/views/screens/wallpaperdetail.dart';
import 'package:provider/provider.dart';

import 'controller/theme_provider.dart';



void main() {
  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ThemeProvider(),),
        ],
      builder: (context, _) {
        return MaterialApp(
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: (Provider.of<ThemeProvider>(context).tm1.isDark == false)
              ? ThemeMode.light
              : ThemeMode.dark,
          debugShowCheckedModeBanner: false,
          initialRoute: 'Splash_screen',
          routes: {
            '/': (context) => TabPage(),
            'HomePage': (context) => HomePage(),
            'Detail': (context) => Detail(),
            'Splash_screen': (context) => Splash_screen(),
          },
        );
      },
    ),
  );
}
