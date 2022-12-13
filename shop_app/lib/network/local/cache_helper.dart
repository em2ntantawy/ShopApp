import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/modules/onBoarding/onboarding.dart';
import 'package:shop_app/shared/components.dart';

import '../../modules/login/login.dart';

class CacheHelper {
  static SharedPreferences sharedPrefernces;
  static init() async {
    sharedPrefernces = await SharedPreferences.getInstance();
  }

  static Future<bool> putData({
    String key,
    bool value,
  }) async {
    return await sharedPrefernces.setBool(key, value);
  }

  static String getData({String key}) {
    return sharedPrefernces == null
        ? 'DEFAULT_VALUE'
        : sharedPrefernces.getString(key) ?? "";
  }

  static int getInteger({String key}) {
    return sharedPrefernces == null ? 0 : sharedPrefernces.getInt(key) ?? 0;
  }

  static bool getBoolean({String key}) {
    return sharedPrefernces == null
        ? false
        : sharedPrefernces.getBool(key) ?? false;
  }

  // static dynamic getData({
  //   required String? key,
  // }) {
  //   return sharedPrefernces?.get(key!);
  //   //return sharedPrefernces!.getBool(key);
  // }

  static Future<bool> saveData({
    String key,
    dynamic value,
  }) async {
    if (value is String) return await sharedPrefernces.setString(key, value);
    if (value is bool) return await sharedPrefernces.setBool(key, value);
    if (value is int) return await sharedPrefernces.setInt(key, value);
    return await sharedPrefernces.setDouble(key, value);
  }

  void submit() {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value) {
        navigateAndFinish(context, Login());
      }
    });
  }

  static Future<bool> RemoveData({String key}) async {
    return await sharedPrefernces.remove(key);
  }
}
