import 'package:flutter/material.dart'; //google提供のUIデザイン
import 'package:http/http.dart' as http; //httpリクエスト用
import 'dart:async'; //非同期処理用
import 'dart:convert'; //httpレスポンスをJSON形式に変換用
import 'dart:collection'; //LinkedHashMap
import 'package:url_launcher/url_launcher.dart'; //リンク先へ遷移
import 'Constants.dart'; //定数用ファイル

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

  // 文字列の変数を定義
  String currentCode;
  String currentType;

  // 非同期処理を定義
  Future getData({String code = 'us', String type = 'top-free'}) async {
    // APIを叩いてランキング情報を取得
    http.Response response = await http.get(
        "https://rss.itunes.apple.com/api/v1/$code/ios-apps/$type/all/200/explicit.json");
    if (response.statusCode == 200) {
      // 取得した情報をデコード
      data = json.decode(response.body);
      feedData = data["feed"];

      // ランキング情報を変数に格納
      setState(() {
        rankingData = feedData["results"];
        currentCode = code;
        currentType = type;
      });
    } else {
      setState(() {
        rankingData = [];
        currentCode = '';
        currentType = '';
      });
    }
  }

  // 最初に一度だけする処理
  @override
  void initState() {
    super.initState();
    setState(() {
      currentCode = 'us';
      currentType = 'top-free';
    });
    // 情報を取得処理を実行
    getData();
  }

  void choiceCountryAction(String code) {
    setState(() {
      rankingData = null;
      currentCode = code;
    });
    getData(code: code, type: currentType);
  }

  void choiceTypeAction(String type) {
    setState(() {
      rankingData = null;
    });
    getData(code: currentCode, type: type);
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
                  child: Image.asset('icons/flags/png/$currentCode.png',
                      package: 'country_icons'),
                  onPressed: () {
                    // todo
                  },
                ),
              ),
            ],
          ),
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CircularProgressIndicator(),
              ],
            ),
          ),
        ),
      );
    } else if (rankingData.length == 0) {
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
                  child: Image.asset('icons/flags/png/$currentCode.png',
                      package: 'country_icons'),
                  onPressed: () {
                    // todo
                  },
                ),
              ),
            ],
          ),
          body: Padding(
              padding: EdgeInsets.all(10), child: Text('Sorry, no data found')),
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
            leading: PopupMenuButton<String>(
              child: Icon(Icons.arrow_drop_down),
              onSelected: choiceTypeAction,
              itemBuilder: (BuildContext context) {
                return Constants.types.map((type) {
                  return PopupMenuItem<String>(
                    value: type['name'],
                    child: Text(type['title']),
                  );
                }).toList();
              },
            ),
            title: Text(Constants.type_titles[currentType]),
            actions: <Widget>[
              PopupMenuButton<String>(
                child: SizedBox(
                  width: 70,
                  child: FlatButton(
                    child: Image.asset('icons/flags/png/$currentCode.png',
                        package: 'country_icons'),
                  ),
                ),
                onSelected: choiceCountryAction,
                itemBuilder: (BuildContext context) {
                  return Constants.countries.map((country) {
                    return PopupMenuItem<String>(
                        value: country['code'],
                        child: Row(
                          children: [
                            SizedBox(
                              width: 30,
                              child: Image.asset(
                                  'icons/flags/png/${country['code']}.png',
                                  package: 'country_icons'),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: SizedBox(
                                width: 160,
                                child: Text(
                                  country['name'],
                                  softWrap: false,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ));
                  }).toList();
                },
              ),
            ],
          ),
          body: Container(
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
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '${index + 1} ${rankingData[index]['name']}',
                                softWrap: false,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child:
                                  Text(rankingData[index]['genres'][0]['name'],
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      )),
                            ),
                          ],
                        ),
                        onTap: () {
                          launch(rankingData[index]['url']);
                        },
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
