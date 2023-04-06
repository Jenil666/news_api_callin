
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_api_callin/screens/home_screen/modal/news_modal.dart';
import 'package:provider/provider.dart';

import '../provider/news_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<NewsProvider>(context, listen: false).jsonParcing();
  }

  NewsProvider? t,f;

  @override
  Widget build(BuildContext context) {
    t = Provider.of<NewsProvider>(context, listen: true);
    f = Provider.of<NewsProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            centerTitle: true,
            title: Text("News App"),
          ),
          body: FutureBuilder(
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text("${snapshot.error}");
              } else if (snapshot.hasData) {
                NewsModal? newsModal = snapshot.data;
                return ListView.builder(
                  itemCount: newsModal!.articles.length,
                  itemBuilder: (context, index) {
                    return Container(
                      //margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      width: double.infinity,
                      child: Column(
                        children: [
                          Container(
                            height: 70,
                            width: double.infinity,
                            //color: Colors.green,
                            child: Row(
                              children: [
                                Container(
                                  height: 200,
                                  width: 100,
                                  child: Image.network(
                                    "${newsModal.articles[index].urlToImage}",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Flexible(child: Text("${newsModal.articles[index].author}",overflow: TextOverflow.fade,style: GoogleFonts.roboto(fontSize: 15,color: Colors.red),)),
                                        SizedBox(height: 5,),
                                        Flexible(child: Text("${newsModal.articles[index].title}",overflow: TextOverflow.ellipsis,style: GoogleFonts.roboto(fontSize: 18),)),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ExpansionTile(
                              childrenPadding: EdgeInsets.all(10),
                              title: Text("Description"),children: [
                            Text("${newsModal.articles[index].description}"),
                            SizedBox(height: 15,),
                            Row(
                              children: [
                                Spacer(),
                                InkWell(
                                  onTap: () {
                                    t!.web!.loadUrl(urlRequest: URLRequest(url: Uri.parse("${newsModal.articles[index].url}"),),);
                                  },
                                  child: Container(
                                    height: 30,
                                    width: 60,
                                    alignment: Alignment.center,
                                    child: Text("View",style: TextStyle(color: Colors.white),),
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(20)
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ]),
                          Divider(color: Colors.black54),
                        ],
                      ),
                      decoration: BoxDecoration(
                        //color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                      ),
                    );
                  },
                );
              } else {
                return Center(
                  child: Container(
                    height: 70,
                    width: 70,
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.blue,
                    ),
                  ),
                );
              }
            },
            future: t!.jsonParcing(),
          )),
    );
  }
}
