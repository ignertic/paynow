import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uni_links/uni_links.dart';
import 'common/injection/injection.dart';
import 'common/navigation/navigation.dart';
import 'initializers.dart';

late StreamSubscription _sub;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeApp();
  initUniLinks();
  runApp(const MyApp());
}

Future<void> initUniLinks() async {
  // ... check initialLink

  // Attach a listener to the stream
  _sub = linkStream.listen((String? link) {
    // Parse the link and warn the user, if it is not correct

    final path = Uri.parse(link!).path;

    appRouter.pushNamed(path);
  }, onError: (err) {
    // Handle exception by warning the user their action did not succeed
  });
}

Future<void> initializeApp() async {
  await configureDependencies();
  // add dummy products data if empty
  populateDummyProductsData();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Paynow Example',
      theme: ThemeData(
        fontFamily: GoogleFonts.raleway().fontFamily,
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(color: Colors.blueAccent),
        buttonTheme: const ButtonThemeData(),
        primaryColor: Colors.blue,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: Colors.blue,
            textStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      routerDelegate: appRouter.delegate(),
      routeInformationParser: appRouter.defaultRouteParser(),
    );
  }
}
