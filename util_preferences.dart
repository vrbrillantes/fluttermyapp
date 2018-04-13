import 'dart:async';
import 'dart:core';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static const String ACCOUNT_KEY = "accountKey";
  static const String ACCOUNT_PHOTO = "photoUrl";

  static Future<bool> setAccountKey(String accountKey) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(ACCOUNT_KEY, accountKey);
    return prefs.commit();
  }

  static Future<String> getAccountKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String accountKey = prefs.getString(ACCOUNT_KEY);
    accountKey = accountKey.replaceAll("@", "");
    accountKey = accountKey.replaceAll(".", "");
    accountKey = accountKey.replaceAll("_", "");
    accountKey = accountKey.replaceAll("-", "");
    print(accountKey);
    // workaround - simulate a login setting this
    if (accountKey == null) {
      accountKey = "Public";
    } else {
      accountKey = "Attendees/" + accountKey;
    }

    return accountKey;
  }
  static Future<String> getPhoto() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String accountKey = prefs.getString(ACCOUNT_PHOTO);

    // workaround - simulate a login setting this
    if (accountKey == null) {
      accountKey = "-KriFiUADpl-X07hnBC-";
    }

    return "-KriFiUADpl-X07hnBC-";
  }

  static Future<bool> setphoto(String photoUrl) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
//    int counter = (prefs.getInt('counter') ?? 0) + 1;
//    print('Pressed $counter times.');
//    await prefs.setInt('counter', counter);


    prefs.setString(ACCOUNT_PHOTO, photoUrl);
    return prefs.commit();

  }
}