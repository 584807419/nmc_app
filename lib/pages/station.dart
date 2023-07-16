import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../config/url_config.dart';

// 气象站详细数据页面,接收城市列表页传来的气象站id参数
class StationPage extends StatefulWidget {
  final Map arguments;
  const StationPage({super.key, required this.arguments});

  @override
  State<StationPage> createState() => _StationPage();
}


class _StationPage extends State<StationPage> {
  late List<Widget> detailList = [
  Text("Time"),
  Text("Temperature"),
  Text("Icomfort"),
  Text("Humidity"),
  Text("Rain"),
  Text("Info"),
  Text("Feelst"),
  Text("Wind_direct"),
  Text("Wind_power"),
  Text("Wind_speed"),
  Text("Warn"),
  Text("Aqi"),
  Text("Aq"),
  ];
  @override
  void initState() {
    getHttp();
    super.initState();
    // print(widget.arguments);
    // print(widget.stationId);
  }

  void getHttp() async {
    String detailUrl =
        "$DetailUrl?keyword=${widget.arguments['stationid']}";
    if (kDebugMode) {
      print("发送请求 $detailUrl");
    }
    Response response = await Dio().get(detailUrl);
    Map resdata = json.decode(response.toString());

    var list1 = resdata["list1"];
    for (var i = 0; i < list1.length; i++) {
      print(i);
      print(list1[i]["Time"]);
      detailList.add(Text(list1[i]["Time"]));
      detailList.add(Text(list1[i]["Temperature"]));
      detailList.add(Text(list1[i]["Icomfort"]));
      detailList.add(Text(list1[i]["Humidity"]));
      detailList.add(Text(list1[i]["Rain"]));
      detailList.add(Text(list1[i]["Info"]));
      detailList.add(Text(list1[i]["Feelst"]));
      detailList.add(Text(list1[i]["Wind_direct"]));
      detailList.add(Text(list1[i]["Wind_power"]));
      detailList.add(Text(list1[i]["Wind_speed"]));
      detailList.add(Text(list1[i]["Warn"]));
      detailList.add(Text(list1[i]["Aqi"]));
      detailList.add(Text(list1[i]["Aq"]));
    }
    setState(() {

    });

  }




  @override
  Widget build(BuildContext context) {
    print(detailList);
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.arguments['name']}详细数据"), // 获取station_id
      ),
      body: GridView.count(
      // Create a grid with 2 columns. If you change the scrollDirection to
      // horizontal, this produces 2 rows.
      crossAxisCount: 13,
      // Generate 100 widgets that display their index in the List.
      children: detailList.length>13?detailList:List.generate(100, (index) {
        return Center(
          child: Text(
            'Item $index',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        );
      }),
    ),
    );
  }
}
