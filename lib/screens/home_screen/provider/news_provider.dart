

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:news_api_callin/screens/home_screen/modal/news_modal.dart';
import 'package:news_api_callin/utils/helper_class.dart';

class NewsProvider extends ChangeNotifier
{
  int currentindexCountry = 0;
  int currentindexCategory = 1;
  Future<NewsModal> jsonParcing(String con,String cat)
   async {
    NewsModal json = await callJson().callingNewsJson(con,cat);
    return json;
  }
  InAppWebViewController? web;
  List category = [
    "Politics",
    "Business",
    "Health",
    "Sports",
    "Technology",
  ];
  List categoryParimeter = [
    "politics",
    "business",
    "health",
    "sports",
    "technology",
  ];
  List countryName = [
    "Indai",
    "America",
    "China",
    "Australia",
    "Belgium",
  ];
  List countryNameParimeter = [
    "in",
    "us",
    "cn",
    "au",
    "be",
  ];
  String country = "in",cate = "business";
  String usercountry= "in",usercategory = "business";
  void changeParamaters(String cont,String cat)
  {
   country = cont;
   cate = cat;
   notifyListeners();
  }
  void refresh()
  {
    notifyListeners();
  }
}