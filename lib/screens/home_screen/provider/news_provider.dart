
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:news_api_callin/screens/home_screen/modal/news_modal.dart';
import 'package:news_api_callin/utils/helper_class.dart';

class NewsProvider extends ChangeNotifier
{
  Future<NewsModal> jsonParcing()
   async {
    NewsModal json = await callJson().callingNewsJson();
    return json;
  }

  InAppWebViewController? web;


}