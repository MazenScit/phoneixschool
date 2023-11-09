
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:phoenixschool/component/general_URL.dart';
import 'package:phoenixschool/model/user_model.dart';
import 'package:phoenixschool/view/navigationhomepagebar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';



// ignore: camel_case_types
class Authentiction_Control {
  login(context, String username, String password,) async {
    var myUrl = Uri.parse("$serverUrl/v1/login");
    print(username+password);
    print(myUrl);
    final response = await http.post(myUrl, body: {
      "username": "$username",
      "password": "$password",
    });
    print(response.body);
    print(response.statusCode);
    if (response.statusCode==200) {
     
        _save(json.decode(response.body)['user']['user_access_token'].toString(),
          json.decode(response.body)['user']['user_id'].toString(),
          username,password);


        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                 HomePageNavBar()), (Route<dynamic> route) => false);
                
    print(json.decode(response.body)['user']['user_access_token'].toString());
    print(json.decode(response.body)['user']['user_id'].toString());
       List body = jsonDecode(response.body)['user']['students'];
       List<User_Model> orders = body
            .map(
              (dynamic item) => User_Model.fromJson(item),
            )
            .toList();
            return orders;
    } else if(response.statusCode==404){
     return AwesomeDialog(
        context: context,
        dialogType: DialogType.warning,
        animType: AnimType.bottomSlide,
        title: 'السيرفر لا يستجيب',
        desc: 'تأكد من السيرفر',
        btnOkOnPress: () {},
      )..show();
    }
    
    else if(response.statusCode==400){
      return AwesomeDialog(
        context: context,
        dialogType: DialogType.warning,
        animType: AnimType.bottomSlide,
        title: 'الحساب غير موجود',
        desc: 'تأكد من صحة البيانات',
        btnOkOnPress: () {},
      )..show();
    }else{
       return AwesomeDialog(
        context: context,
        dialogType: DialogType.warning,
        animType: AnimType.bottomSlide,
        title: 'انترنت',
        desc: 'تاكد من الاتصال بالانترنت',
        btnOkOnPress: () {},
      )..show();
    }
  }

  _save(String token,String user_id,String username,String password)async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = token;

    prefs.setString(key, value);
    final key_user_id = 'user_id';
    final value_user_id = user_id;
    prefs.setString(key_user_id, value_user_id);
    prefs.setString(key, value);

    final key_username = 'username';
    final value_username = username;
    prefs.setString(key_username, value_username);

    final key_isLoggedIn = 'isLoggedIn';
    final value_isLoggedIn = true;
    prefs.setBool(key_isLoggedIn, value_isLoggedIn);


    prefs.setString(key, value);
    final key_password = 'password';
    final value_password = password;
    prefs.setString(key_password, value_password);

  }

}
