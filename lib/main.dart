import 'package:flutter/material.dart'; //google提供のUIデザイン

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final items = List<String>.generate(100, (i) => "${i + 1} TikTok");

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
        body: Container(
          child: FlatButton(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(12.0),
                    itemCount: items.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                              'https://is4-ssl.mzstatic.com/image/thumb/Purple123/v4/71/33/58/7133589f-7bee-dff0-c0e1-324aeb3df7fe/AppIcon_TikTok-0-0-1x_U007emarketing-0-0-0-7-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/200x200bb.png'),
                        ),
                        title: Column(
                          children: <Widget>[
                            Row(
                              children: [
                                Text('${items[index]}'),
                              ],
                            ),
                            Row(
                              children: [
                                Text('ショートムービー・コミュニティー',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    )),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                  ),
                ),
              ],
            ),
            onPressed: () {
              // todo
            },
          ),
        ),
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
