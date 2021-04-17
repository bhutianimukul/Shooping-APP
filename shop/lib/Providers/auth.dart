import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shop/Models/httpException.dart';
class Auth with ChangeNotifier{
String _token;
String _userId;
DateTime _expiryTime;
bool get isAuth{
  if(_token!=null ) return true;
  return false;
}
String get token{
  if(token!=null && _expiryTime.isAfter(DateTime.now()) && _expiryTime!=null)
  return _token;

}
Future<void> _authenticate( String email,String password, String url )async{
  try{
final response=await http.post(Uri.parse(url), 
body: json.encode({
  'email': email,
  'password': password,
  'returnSecureToken': true
}) );
print(json.decode(response.body));
if(json.decode(response.body)['error'] !=null)
  {
    throw HttpException(json.decode(response.body)['error']['message']);
  }
  _token=json.decode(response.body)['idToken'];
  _expiryTime=DateTime.now().add(Duration(seconds: int.parse(json.decode(response.body)['expiresIn'])));
  _userId=json.decode(response.body)['localId'];
notifyListeners();
  }
  catch(error){
    throw error;
  }
}
Future<void> signUp( String email,String password )async{
const url="https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyAGO3Cvz-DjV5ED3IR3_4_rlppjC6vfLWU";
return _authenticate(email, password, url);
}
Future<void> signIn( String email,String password )async{
const url="https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyAGO3Cvz-DjV5ED3IR3_4_rlppjC6vfLWU";
return _authenticate(email, password, url);
}
}