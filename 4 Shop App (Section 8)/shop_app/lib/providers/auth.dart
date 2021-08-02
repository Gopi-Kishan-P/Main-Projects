import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/models/http_exception.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;
  Timer _authTimer;

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) return _token;
    return null;
  }

  String get userId {
    return _userId;
  }

  Future<void> signUp(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> logIn(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }

  Future<bool> tryAutoLogin() async{
    final prefs = await SharedPreferences.getInstance();
    if(!prefs.containsKey('userDate'))
      return false;
    final extractedUserData = prefs.getString('userData') as Map<String, Object>; 
    final expireDate = DateTime.parse(extractedUserData['expiryDate']);
    if(expireDate.isAfter(DateTime.now())){
      return false;
    }

    print('** auto login ..');
    _token = extractedUserData['token'];
    _userId = extractedUserData['userId'];
    _expiryDate = extractedUserData['expiryDate'];
    return true;

  }

  void logout() async {
    _token = null;
    _userId = null;
    _expiryDate = null;
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    notifyListeners();
  }

  void autoLogOut() {
    if (_authTimer != null) _authTimer.cancel();
    final timeToExpire = _expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpire), logout);
  }

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    try {
      final url = Uri.parse(
          'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyAcG8kdSVm5kHmK0pFvSc7FRI1NoebvjWg');
      final res = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      debugPrint(res.body);
      final resBody = json.decode(res.body);
      if (resBody['error'] != null) {
        throw HttpException(resBody['error']['message']);
      }
      _token = resBody['idToken'];
      _userId = resBody['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            resBody['expiresIn'],
          ),
        ),
      );
      autoLogOut();
      notifyListeners();

      final pref = await SharedPreferences.getInstance();
      final userData = json.encode(
        {
          'token': _token,
          'userId': _userId,
          'expiryDate': _expiryDate.toIso8601String(),
        },
      );
      pref.setString('userData', userData);
    } catch (error) {
      throw error;
    }
  }
}
