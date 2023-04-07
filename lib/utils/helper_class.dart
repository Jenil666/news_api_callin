import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_api_callin/screens/home_screen/modal/news_modal.dart';



class callJson
{
  Future<NewsModal> callingNewsJson(String con,String cat)
  async {
    String linkString = "https://newsapi.org/v2/top-headlines?country=$con&category=$cat&apiKey=89b1dca222ba4c0b8668c0185eaad5bb";
    var link = Uri.parse(linkString);
    var resource = await http.get(link);
    var json = jsonDecode(resource.body);

    NewsModal news = NewsModal.fromJson(json);
    return news;
  }
}

