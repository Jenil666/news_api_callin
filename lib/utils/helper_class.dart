import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_api_callin/screens/home_screen/modal/news_modal.dart';



class callJson
{
  Future<NewsModal> callingNewsJson()
  async {
    String linkString = "https://newsapi.org/v2/everything?domains=wsj.com&apiKey=8081c5d4778d45bcbf5c89c1c0f0be9c";
    var link = Uri.parse(linkString);
    var resource = await http.get(link);
    var json = jsonDecode(resource.body);

    NewsModal news = NewsModal.fromJson(json);
    return news;
  }
}

