import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:phoenixschool/view/navigationhomepagebar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../component/general_URL.dart';
class SendComplaint {
    Future sendcomplaint(context,String title,String body,String student_card_id,String user_type_id) async {
   String myUrl = "$serverUrl/v1/user/message";
    final prefs = await SharedPreferences.getInstance();
        final keyid = 'token';
        final valueid = prefs.get(keyid);
        final keyuser_id = 'user_id';
        final valueuserid = prefs.get(keyuser_id);
        print(title);
        print(body);
        print(student_card_id);
        print(user_type_id);
        
    http.Response response = await http.post(Uri.parse(myUrl),body: {
      "title":title,
      "body":body,
      "sender_id":valueuserid,
      "student_card_id":student_card_id,
      "message_type_id":"2",
      "access_token":valueid,
      "user_type_id":user_type_id,
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