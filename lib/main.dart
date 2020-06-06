import 'package:flutter/material.dart'; //google提供のUIデザイン
import 'package:http/http.dart' as http; //httpリクエスト用
import 'dart:async'; //非同期処理用
import 'dart:convert'; //httpレスポンスをJSON形式に変換用
import 'dart:collection'; //LinkedHashMap

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // ハッシュの変数を定義
  var data = new LinkedHashMap();
  var feedData = new LinkedHashMap();

  // 配列の変数を定義
  List rankingData;

  // 非同期処理を定義
  Future getData() async {
    // APIを叩いてランキング情報を取得
    http.Response response = await http.get(
        "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-free/all/200/explicit.json");

    // 取得した情報をデコード
    data = json.decode(response.body);
    feedData = data["feed"];

    // ランキング情報を変数に格納
    setState(() {
      rankingData = feedData["results"];
    });
  }

  // 最初に一度だけする処理
  @override
  void initState() {
    super.initState();

    // 情報を取得処理を実行
    getData();
  }

  @override
  Widget build(BuildContext context) {
    if (rankingData == null) {
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
            title: const Text('Top Free iPhone Apps'),
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
    } else {
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
            title: const Text('Top Free iPhone Apps'),
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
                      itemCount: rankingData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                  rankingData[index]['artworkUrl100'])),
                          title: Column(
                            children: <Widget>[
                              Row(
                                children: [
                                  Text(
                                      '${index + 1} ${rankingData[index]['name']}'),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(rankingData[index]['genres'][0]['name'],
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
}
