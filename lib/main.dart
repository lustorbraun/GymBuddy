import 'package:flutter/material.dart';
import 'package:gym_buddy/Screens/HomeScreen.dart';
import 'package:gym_buddy/src/providers/imageProvider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PhotosProvider>(
      create : (_)=> PhotosProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
      ),
    );
  }
}