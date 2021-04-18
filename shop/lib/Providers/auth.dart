import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:shop/Models/httpException.dart';

class Auth with ChangeNotifier {
  String _token;
  String _userId;
  DateTime expiryTime;
  bool get isAuth {
    if (token != null) return true;
    return false;
  }

  String get token {
    if (_token != null &&
        expiryTime != null &&
        expiryTime.isAfter(DateTime.now())) return _token;
    return null;
  }

  String get userId {
    return _userId;
  }

  Future<void> _authenticate(String email, String password, String url) async {
    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true
          }));
      print(json.decode(response.body));
      if (json.decode(response.body)['error'] != null) {
        throw HttpException(json.decode(response.body)['error']['message']);
      }
      _token = json.decode(response.body)['idToken'];
      expiryTime = DateTime.now().add(Duration(
          seconds: int.parse(json.decode(response.body)['expiresIn'])));
      _userId = json.decode(response.body)['localId'];
    
      autoLogOut();
      notifyListeners();
    final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(
        {
          'token': _token,
          'userId': _userId,
          'expiryDate': expiryTime.toIso8601String(),
        },
      );
      prefs.setString('userData', userData);
    } catch (error) {
      throw error;
    }
  }
  Future<bool> autoLogin()async{ 
 final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData = json.decode(prefs.getString('userData')) as Map<String, Object>;
    final expiryDate = DateTime.parse(extractedUserData['expiryDate']);

    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    _token = extractedUserData['token'];
    _userId = extractedUserData['userId'];
    expiryTime = expiryDate;
    notifyListeners();
    autoLogOut();
    return true;




  }

  Future<void> signUp(String email, String password) async {
    const url =
        "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyAGO3Cvz-DjV5ED3IR3_4_rlppjC6vfLWU";
    return _authenticate(email, password, url);
  }

  Future<void> signIn(String email, String password) async {
    const url =
        "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyAGO3Cvz-DjV5ED3IR3_4_rlppjC6vfLWU";
    return _authenticate(email, password, url);
  }

  Timer auth_timer;
  Future<void> logOut() async{
    _token = null;
    expiryTime = null;
    _userId = null;
    auth_timer.cancel();
    notifyListeners();
    final prefs=await SharedPreferences.getInstance();
    prefs.clear();
  }

  void autoLogOut() {
    if (auth_timer != null) {
      auth_timer.cancel();
    }
    final time = expiryTime.difference(DateTime.now()).inSeconds;
    auth_timer = Timer(Duration(seconds: time), logOut);
  }
}
