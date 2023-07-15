import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// 城市列表页面
class CityPage extends StatefulWidget {
  //其他页面跳转过来路由传值
  final Map arguments;
  // final String cityName;
  // final String stationId;

  const CityPage({super.key, required this.arguments});

  @override
  State<CityPage> createState() => _CityPage();
}

class _CityPage extends State<CityPage> {
  List<Widget> cityList = [];

  void getHttp() async {

    String cityUrl = "http://localhost:81/freeapi/v1/city?province_name="+"${widget.arguments['name']}";
    if (kDebugMode) {
      print("发送请求 ${cityUrl}");
    }
    Response response = await Dio().get(cityUrl);
    List tempList = [];

    tempList = json.decode(response.toString())["data"];
    for (var i = 0; i < tempList.length; i++) {
      cityList.add(
          Container(
            margin: EdgeInsets.all(5),
            child: ElevatedButton(
                onPressed: () {
                  // 跳转路由
                  Navigator.pushNamed(context, "/station_detail",
                      arguments: {"name": "${tempList[i]["city"]}", "stationid": "${tempList[i]["stationid"]}"});
                },
                style:ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.lightBlueAccent,
                  shadowColor: Colors.blueAccent,
                  elevation: 10,
                ),
                child: Text(
                  "${tempList[i]["city"]}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),)),
          )
      );
    }
    setState(() {

    });
  }

  @override
  void initState() {
    super.initState();
    // print(widget.arguments);
    getHttp();
    // print(widget.stationId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.arguments['name']}"),
      ),
      body: GridView.extent(
        maxCrossAxisExtent: 110.0,
        childAspectRatio: 1.0,
        children: cityList.isNotEmpty?cityList:[const Icon(Icons.not_interested)],
      ),
        // child: Text("城市列表页内容:气象站id${widget.stationId}"),

          // children: [
          //   ElevatedButton(onPressed: (){Navigator.pushNamed(context, "/station_detail");},
          //       child:const Text("跳转到气象站详情")
          //   ),
          //   const SizedBox(height: 20,),
          //   ElevatedButton(onPressed: (){Navigator.of(context).pop();},
          //       child:const Text("返回上一级")
          //   ),
          // const SizedBox(height: 20,),
          // ElevatedButton(onPressed: (){Navigator.of(context).pushReplacementNamed("/station_detail");},
          // child:const Text("替换路由,直接替换掉当前页面"))
          // ],
        );
  }
}
