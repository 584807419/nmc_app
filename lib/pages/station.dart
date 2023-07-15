import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../pages/tabs/home.dart';

// 气象站详细数据页面,接收城市列表页传来的气象站id参数
class StationPage extends StatefulWidget {
  final Map arguments;

  const StationPage({super.key, required this.arguments});

  @override
  State<StationPage> createState() => _StationPage();
}

class _StationPage extends State<StationPage> {
  List<Widget> detailList = [];

  void getHttp() async {
    String detailUrl =
        "http://localhost:81/freeapi/v1/detail?keyword=${widget.arguments['stationid']}";
    if (kDebugMode) {
      print("发送请求 $detailUrl");
    }
    Response response = await Dio().get(detailUrl);
    List list0 = [];

    list0 = json.decode(response.toString())["list0"];
    for (var i = 0; i < list0.length; i++) {
      detailList.add(Container(
          margin: EdgeInsets.all(5),
          child: Text(
            "${list0[i]}",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          )));
    }
    setState(() {});
  }

  @override
  void initState() {
    getHttp();
    super.initState();
    // print(widget.arguments);
    // print(widget.stationId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.arguments['name']}详细数据"), // 获取station_id
      ),
      body: Center(
        // child: Text("城市列表页内容:气象站id${widget.stationId}"),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: detailList.isNotEmpty
              ? detailList
              : [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (BuildContext context) {
                          return const HomePage();
                        }), (route) => false);
                      },
                      child: const Text("返回到根路由/根页面"))
                ],
          // children: [
          //   const SizedBox(
          //     height: 20,
          //   ),
          //   ElevatedButton(
          //       onPressed: () {
          //         Navigator.of(context).pushAndRemoveUntil(
          //             MaterialPageRoute(builder: (BuildContext context) {
          //           return const HomePage();
          //         }), (route) => false);
          //       },
          //       child: const Text("返回到根路由/根页面"))
          // ],
        ),
      ),
    );
  }
}
