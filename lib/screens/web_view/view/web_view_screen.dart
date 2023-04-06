import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../home_screen/provider/news_provider.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({Key? key}) : super(key: key);

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  NewsProvider? T,F;
  @override
  Widget build(BuildContext context) {
    F = Provider.of<NewsProvider>(context,listen: false);
    T = Provider.of<NewsProvider>(context,listen: true);
    return SafeArea(child: Scaffold(body:Column(children: [],),),);
  }
}
