import 'package:flutter/material.dart'; //google提供のUIデザイン
import 'package:flutter_svg/flutter_svg.dart'; //SVG画像を使う

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          leading: FlatButton(
            child: Icon(Icons.arrow_drop_down),
            onPressed: () {
              // todo
            },
          ),
          title: const Text('iOS Free App Ranking'),
          actions: <Widget>[
            SizedBox(
              width: 70,
              child: FlatButton(
                child: Image.asset('icons/flags/png/us.png',
                    package: 'country_icons'),
                onPressed: () {
                  // todo
                },
              ),
            ),
          ],
        ),
        body: Container(),
      ),
    );
  }
}

//import 'package:http/http.dart' as http; //httpリクエスト用
//import 'dart:async'; //非同期処理用
//import 'dart:convert'; //httpレスポンスをJSON形式に変換用
//
//void main() {
//  runApp(MaterialApp(
//    home: HomePage(),
//  ));
//}
//
//class HomePage extends StatefulWidget {
//  _HomePageState createState() => _HomePageState();
//}
//
//class _HomePageState extends State<HomePage> {
//  Map data;
//  List userData;
//
//  Future getDate() async {
//    http.Response response =
//        await http.get("https://reqres.in/api/users?page=2");
//    data = json.decode(response.body);
//    setState(() {
//      userData = data["data"];
//    });
//  }
//
//  void initState() {
//    super.initState();
//    getDate();
//  }
//
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text("あああ"),
//        backgroundColor: Color(0xFF4169e1),
//      ),
//      body: ListView.builder(
//        itemCount: userData.length,
//        itemBuilder: (BuildContext context, int index) {
//          return Card(
//            child: Row(
//              children: <Widget>[
//                CircleAvatar(
//                  backgroundImage: NetworkImage(userData[index]["avatar"]),
//                ),
//                Text(
//                    "${index} ${userData[index]["first_name"]} ${userData[index]["last_name"]}")
//              ],
//            ),
//          );
//        },
//      ),
//    );
//  }
//}
