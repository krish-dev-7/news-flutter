import 'dart:convert';
import 'package:news/countries.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class News extends StatefulWidget {
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  String _cont = "click title to view more";
  String _code = "in";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.location_pin,
              size: 30,
              color: Color(0xFFE50914),
            ),
            onPressed: () async {
              var cc = await Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                return Countries();
              }));
              if (cc.toString().isNotEmpty) {
                setState(() {
                  _code = cc;
                });
              }
            },
          )
        ],
        title: Text(
          "News Time",
          style: GoogleFonts.bebasNeue(fontSize: 30, color: Color(0xFFE50914)),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: http.get(
              "https://newsapi.org/v2/top-headlines?country=$_code&category=business&apiKey=8a6bbe2da5b043f4a0cda31c28e9e81f"),
          builder: (context, ndata) => ndata.connectionState ==
                  ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.red,
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : (ndata.hasError)
                  ? Text(
                      "CHECK THE CONNECTION",
                      style: GoogleFonts.akronim(
                          fontSize: 30, color: Colors.black87),
                    )
                  : ListView.builder(
                      itemCount:
                          json.decode(ndata.data.body)['articles'].length,
                      itemBuilder: (context, index) => Card(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    height: 300,
                                    width: 360,
                                    padding: EdgeInsets.all(20),
                                    margin: EdgeInsets.symmetric(
                                        vertical: 40, horizontal: 20),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(
                                        json.decode(ndata.data.body)['articles']
                                                [index]['urlToImage'] ??
                                            "https://thumbs.dreamstime.com/b/no-image-available-icon-flat-vector-no-image-available-icon-flat-vector-illustration-132482930.jpg",
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black,
                                          offset: Offset(20, 8),
                                          spreadRadius: 3,
                                          blurRadius: 27,
                                        ),
                                        BoxShadow(
                                            color: Colors.black,
                                            offset: Offset(-3, -5),
                                            spreadRadius: -2,
                                            blurRadius: 20),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  // ignore: deprecated_member_use
                                  FlatButton(
                                    child: Text(
                                      "${json.decode(ndata.data.body)['articles'][index]['title']}",
                                      style: GoogleFonts.aBeeZee(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    onPressed: () {
                                      showModalBottomSheet<void>(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return SingleChildScrollView(
                                              child: Container(
                                                color: Colors.white,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      20.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Text(
                                                          "Description :\n ${json.decode(ndata.data.body)['articles'][index]['description']}\n\n",
                                                          style: GoogleFonts
                                                              .poppins(
                                                            fontSize: 25,
                                                            color: Color(
                                                                0xFFE50914),
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          });
                                    },
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(_cont),
                                  Text(
                                      "published at : ${json.decode(ndata.data.body)['articles'][index]['publishedAt']}"),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                          ))),
    );
  }
}
