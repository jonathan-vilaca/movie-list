import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {

  static saveLocalStorage(String key, String value) async {
    final preferences = await SharedPreferences.getInstance();
    preferences.setString(key, value);
  }

  static removeAllSave() async {
    final preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }

  static getLocalStorage(String key) async {
    final preferences = await SharedPreferences.getInstance();
    var result = await preferences.get(key);
    return result;
  }

  static removeLocalStorage(String key) async {
    final preferences = await SharedPreferences.getInstance();
    preferences.remove(key);
  }

  static saveObj(String key, dynamic value) async {
    final preferences = await SharedPreferences.getInstance();
    preferences.setString(key, json.encode(value));
  }

  static getObj(String key) async {
    final preferences = await SharedPreferences.getInstance();
    return json.decode(preferences.getString(key));
  }
}