import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movies/Screen/Home_Page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
  );
}
