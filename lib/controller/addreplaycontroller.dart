import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:phoenixschool/view/navigationhomepagebar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../component/general_URL.dart';
class AddReplay {
    Future addReplay(context,String content,String message_id) async {
   String myUrl = "$serverUrl/v1/user/replay";
    final prefs = await SharedPreferences.getInstance();
        final keyid = 'token';
        final valueid = prefs.get(keyid);
        final keyuser_id = 'user_id';
        final valueuserid = prefs.get(keyuser_id);
        print(content);
        print(message_id);
        
    http.Response response = await http.post(Uri.parse(myUrl),body: {
      "message_id":message_id,
      "access_token":valueid,
      "content":content,
      "sender_id":valueuserid,
    });
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      Future.delayed(Duration(seconds: 2),() {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                 HomePageNavBar()), (Route<dynamic> route) => false);
                
      },);
      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.bottomSlide,
        title: 'تم الارسال بنجاح',
        // btnOkOnPress: () {},
      ).show();
    } else {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.warning,
        animType: AnimType.bottomSlide,
        title: 'خطا في الارسال',
        // btnOkOnPress: () {},
      ).show();
      // throw "Error While getting Properties";
    }
  }
}