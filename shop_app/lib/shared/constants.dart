import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:shop_app/modules/login/login.dart';
import 'package:shop_app/network/local/cache_helper.dart';
import 'package:shop_app/shared/components.dart';

Color defaultColor = Color.fromARGB(255, 83, 144, 118);
//var token;
void signOut(context) {
  TextButton(
    onPressed: () {
      CacheHelper.RemoveData(key: 'token').then((value) {
        if (value) {
          navigateAndFinish(context, Login());
        }
      });
    },
    //  child: Text('Sign Out'),
  );
}

void printFullText(String text) {
  final Pattern = RegExp('.{1,800}');
  Pattern.allMatches(text).forEach((match) {
    print(match.group(0));
  });
}

String token = CacheHelper.getData(key: 'token');
