import 'package:flutter/material.dart';
import 'package:news_api_callin/screens/home_screen/provider/news_provider.dart';
import 'package:news_api_callin/screens/home_screen/view/home_screen.dart';
import 'package:news_api_callin/screens/web_view/view/web_view_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NewsProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes:{
          '/':(context) => HomeScreen(),
          'Web':(context) => WebViewScreen(),
        },
      ),
    ),
  );
}
