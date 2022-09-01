import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cache_Helper
{
  static SharedPreferences? s;

  static init() async
  {
    s = await SharedPreferences.getInstance();
  }
  static Future<bool> setBoolean(
  {
    required String key,
    required bool value
  }) async
  {
    return await s!.setBool(key, value);
  }

  static bool? GetBoolean({
  required String key
})
  {
    return s?.getBool(key);
  }

  static dynamic GetData({
    required String key
  })
  {
    return s?.get(key);
  }

  static Future<bool> saveData({
    required String key,
    required dynamic value
}) async
  {
    if(value is String) return await s!.setString(key, value);
    if(value is int) return await s!.setInt(key, value);
    if(value is bool) return await s!.setBool(key, value);
    return await s!.setDouble(key, value);
  }

  static Future<bool?> removeData(
  {
  required String key,
}) async
  {
    return await s!.remove(key);
  }
}