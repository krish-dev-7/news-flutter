import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news/news.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "COVID TRACKER",
      theme: ThemeData(brightness: Brightness.dark),
      home: StartApp(),
    );
  }
}

class StartApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Color(0xFFE50914)),
          title: Text(
            "NEWS",
            style:
                GoogleFonts.bebasNeue(color: Color(0xFFE50914), fontSize: 40),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        drawer: SafeArea(
            child: Drawer(
          child: Container(
            color: Color(0xFFE50914),
            child: Column(
              children: <Widget>[
                SafeArea(
                    child: ListTile(
                  onTap: () {
                    showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            color: Colors.black87,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                RichText(
                                  text: TextSpan(
                                      text: "Mail :",
                                      style: TextStyle(
                                          fontSize: 25,
                                          color: Color(0xFFE50914)),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: " krish0cyber@gmail.com",
                                          style: TextStyle(
                                              fontSize: 25,
                                              color: Color(0xFFE50914),
                                              fontWeight: FontWeight.bold),
                                        )
                                      ]),
                                ),
                                RichText(
                                  text: TextSpan(
                                      text: "Developer :",
                                      style: TextStyle(
                                          fontSize: 25,
                                          color: Color(0xFFE50914)),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: " Krishna Sundar\n\n",
                                          style: TextStyle(
                                              fontSize: 25,
                                              color: Color(0xFFE50914),
                                              fontWeight: FontWeight.bold),
                                        )
                                      ]),
                                ),
                                RichText(
                                  text: TextSpan(
                                      text: "Instagram:",
                                      style: TextStyle(
                                          fontSize: 25,
                                          color: Color(0xFFE50914)),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: " krish_krush",
                                          style: TextStyle(
                                              fontSize: 25,
                                              color: Color(0xFFE50914),
                                              fontWeight: FontWeight.bold),
                                        )
                                      ]),
                                ),
                                RichText(
                                  text: TextSpan(
                                      text: "Youtube:",
                                      style: TextStyle(
                                          fontSize: 25,
                                          color: Color(0xFFE50914)),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: " code with krish",
                                          style: TextStyle(
                                              fontSize: 25,
                                              color: Color(0xFFE50914),
                                              fontWeight: FontWeight.bold),
                                        )
                                      ]),
                                ),
                                RichText(
                                  text: TextSpan(
                                      text: "Github:",
                                      style: TextStyle(
                                          fontSize: 25,
                                          color: Color(0xFFE50914)),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: " github.com/krish-dev-7",
                                          style: TextStyle(
                                              fontSize: 25,
                                              color: Color(0xFFE50914),
                                              fontWeight: FontWeight.bold),
                                        )
                                      ]),
                                ),
                              ],
                            ),
                          );
                        });
                  },
                  leading: Icon(
                    Icons.info,
                    color: Colors.white,
                  ),
                  title: Text(
                    "Contact",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                )),
              ],
            ),
          ),
        )),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                width: double.infinity,
                // decoration: BoxDecoration(
                //   image: DecorationImage(
                //     image: AssetImage("assets/back.jpg"),
                //     fit: BoxFit.cover,
                //   ),
                // ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "hello news readers ",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.bebasNeue(
                          fontSize: 30,
                          wordSpacing: 3,
                          letterSpacing: 6,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          backgroundColor: Color(0xFFE50914)),
                    ),
                    SizedBox(
                      height: 150,
                    ),
                    FutureBuilder(
                      future: http.get("https://zenquotes.io/api/random"),
                      builder: (context, qu) =>
                          qu.connectionState == ConnectionState.waiting
                              ? Center(
                                  child: LinearProgressIndicator(
                                    backgroundColor: Colors.red,
                                    valueColor:
                                        new AlwaysStoppedAnimation<Color>(
                                            Colors.white),
                                  ),
                                )
                              : (qu.hasError)
                                  ? Text(
                                      "CHECK THE CONNECTION",
                                      style: GoogleFonts.akronim(
                                          fontSize: 30,
                                          color: Color(0xFFE50914)),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Text(
                                          (json.decode(qu.data.body)[0]['q'])
                                              .toString(),
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.poppins(
                                              fontSize: 20,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold)),
                                    ),
                    ),
                    SizedBox(
                      height: 150,
                    ),
                    // ignore: deprecated_member_use
                    RaisedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return News();
                        }));
                      },
                      color: Colors.white,
                      elevation: 400,
                      splashColor: Colors.black12,
                      padding: EdgeInsets.all(30),
                      child: Text(
                        "ENTER",
                        style: GoogleFonts.bebasNeue(
                            color: Color(0xFFE50914),
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2),
                      ),
                    ),
                    Text(
                      "News across 50 countries ...",
                      style: TextStyle(color: Color(0xFFE50914), fontSize: 20),
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
