import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_api_callin/screens/home_screen/modal/news_modal.dart';
import 'package:provider/provider.dart';

import '../provider/news_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NewsProvider? t, f;

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
                                child: CachedNetworkImage(
                                    imageUrl: "${newsModal.articles[index].urlToImage}",
                                 placeholder: (context, url) => Center(child: CircularProgressIndicator(color: Colors.black,backgroundColor: Colors.white,)),
                                  errorWidget: (context, url, error) => Center(child: Text("Unable to Load Image")),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Flexible(
                                          child: Text(
                                        "${newsModal.articles[index].author}",
                                        overflow: TextOverflow.fade,
                                        style: GoogleFonts.roboto(
                                            fontSize: 15, color: Colors.red),
                                      )),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Flexible(
                                          child: Text(
                                        "${newsModal.articles[index].title}",
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.roboto(fontSize: 18),
                                      )),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ExpansionTile(
                            childrenPadding: EdgeInsets.all(10),
                            title: Text("Description"),
                            children: [
                              Text("${newsModal.articles[index].description}"),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  Spacer(),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(context, 'Web',
                                          arguments:
                                              newsModal.articles[index].url);
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 60,
                                      alignment: Alignment.center,
                                      child: Text(
                                        "View",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(20)),
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
                    backgroundColor: Colors.white,
                    color: Colors.black,
                  ),
                ),
              );
            }
          },
          future: t!.jsonParcing(t!.country,t!.cate),
        ),
        drawer: Drawer(
          backgroundColor: Colors.white,
          width: 250,
          shadowColor: Colors.white,
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                        "https://pbs.twimg.com/media/EgqnrDAVkAAcRvc?format=jpg&name=4096x4096"),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Jenil Chandarana",
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                color: Colors.black,
                indent: 10,
                endIndent: 10,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Icon(Icons.arrow_right),
                  Text("Select Country"),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: t!.countryName.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        t!.usercountry = t!.countryNameParimeter[index];
                        t!.currentindexCountry = index;
                        f!.refresh();
                        },
                      child: Container(
                        margin: EdgeInsets.only(
                            left: 10, right: 10, top: 5, bottom: 5),
                        padding: EdgeInsets.all(10),
                        height: 40,
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: Text(
                          "${t!.countryName[index]}",
                          style: TextStyle(fontSize: 15),
                        ),
                        decoration: BoxDecoration(
                            color: t!.currentindexCountry == index?Colors.black26:Colors.black12,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    );
                  },
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Icon(Icons.arrow_right),
                  Text("Select Category"),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: t!.category.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                       onTap: () {
                        t!.usercategory = t!.categoryParimeter[index];
                        t!.currentindexCategory = index;
                        f!.refresh();
                       },
                      child: Container(
                        margin: EdgeInsets.only(
                            left: 10, right: 10, top: 5, bottom: 5),
                        padding: EdgeInsets.all(10),
                        height: 40,
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: Text(
                          "${t!.category[index]}",
                          style: TextStyle(fontSize: 15),
                        ),
                        decoration: BoxDecoration(
                            color: t!.currentindexCategory==index?Colors.black26:Colors.black12,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    );
                  },
                ),
              ),
              //Expanded(child: SizedBox()),
              ElevatedButton(
                  onPressed: () {
                    f!.changeParamaters( t!.usercountry,t!.usercategory);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  child: Text("Submit"))
            ],
          ),
        ),
      ),
    );
  }
}
