import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> putData(@required String key, @required dynamic value) async {
    return await sharedPreferences.setBool(key, value);
  }

  static bool? getData(String key)  {
    return sharedPreferences.getBool(key);
  }
}
