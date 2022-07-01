import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:selftherapy_diaries/screens/show_edit_entry_screen.dart';

import 'screens/diaries_screen.dart';
import 'package:selftherapy_diaries/config/config.dart';
import 'package:selftherapy_diaries/screens/add_new_entry_screen.dart';
import 'package:selftherapy_diaries/screens/auth_screen.dart';
import 'package:selftherapy_diaries/screens/entries_list_screen.dart';
import 'package:selftherapy_diaries/screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();

    MaterialColor primaryColor =
        MaterialColor(0xFFA06CD5, DiariesConfig.themeColor);

    return FutureBuilder(
        future: _initialization,
        builder: (context, appShapshot) {
          return MaterialApp(
              title: 'Therapy Diaries',
              theme: ThemeData(
                appBarTheme: AppBarTheme(color: primaryColor.shade900),
                primaryColor: primaryColor.shade900,
                backgroundColor: primaryColor.shade900,
                accentColor: Colors.deepOrange,
                accentColorBrightness: Brightness.dark,
                fontFamily: 'Lato',
                textTheme: ThemeData.light().textTheme.copyWith(
                      titleMedium: TextStyle(
                        fontFamily: 'RobotoCondensed',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    primary: primaryColor.shade900,
                    onPrimary: Colors.white,
                  ),
                ),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    primary: primaryColor.shade900,
                  ),
                ),
              ),
              home: StreamBuilder(
                  stream: FirebaseAuth.instance.authStateChanges(),
                  builder: (ctx, userSnapshot) {
                    if (userSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return SplashScreen();
                    }
                    if (userSnapshot.hasData) {
                      return DiariesScreen();
                    }
                    return AuthScreen();
                  }),
              routes: {
                EntriesListScreen.routeName: (ctx) => EntriesListScreen(),
                AddNewEntrySceeen.routeName: (ctx) => AddNewEntrySceeen(),
                ShowEditEntryScreen.routeName: (ctx) => ShowEditEntryScreen(),
              });
        });
  }
}
