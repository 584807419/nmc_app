import 'package:flutter/material.dart';
import '../pages/tabs/home.dart';
import '../pages/city.dart';
import '../pages/station.dart';

// 1.定义路由
Map routes = {
  "/": (context) => const HomePage(),
  "/city_list": (context, {arguments}) => CityPage(arguments: arguments),
  "/station_detail": (context) => const StationPage(),
};

// 2. 配置onGenerateRoute固定写法,这个方法也相当于一个中间件,这里可以字权限判断
var onGenerateRoute = (RouteSettings settings) {
  final String? name = settings.name; //命名路由的名称 /city_list 可空参数
  final Function? pageContentBuilder = routes[name]; // 获取路由定义的方法
  if (pageContentBuilder != null) {
    //传递参数情况
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      //无参数情况
      final Route route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
  return null;
};
