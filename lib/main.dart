import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:today_news/layout/news_layout.dart';
import 'package:today_news/shared/network/local/cache_helper.dart';
import 'package:today_news/shared/network/remote/dio_helper.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();
  await CacheHelper.init();

  bool? isDark = CacheHelper.getData('isDark');

  print('isDark = $isDark');

  if(isDark == null){
    isDark = false;
  }

  runApp(NewsLayout(isDark: isDark,));
}