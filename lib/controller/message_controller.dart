import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../component/general_URL.dart';
import '../model/message_model.dart';

class Message_Controller{
    Future<List<MessageModel>?> getmessages(int type,String value_user_id) async {
  final prefs = await SharedPreferences.getInstance();
        final keyid = 'token';
        final valuetoken = prefs.get(keyid);
    String myUrl = "$serverUrl/v1/user/message"+"?receiver_id=$value_user_id&type=$type&access_token=$valuetoken";
    print(myUrl);
    http.Response response = await http.get(Uri.parse(myUrl) );
    if (response.statusCode == 200) {
      List body = jsonDecode(response.body)['data'];
      print(response.body);
      try {
        List<MessageModel> orders = body
            .map(
              (dynamic item) => MessageModel.fromJson(item),
            )
            .toList();
        return orders;
      } catch (error) {
        print(error);

        return null;
      }
    } else {
      return null;
      // throw "Error While getting Properties";
    }
  }
}