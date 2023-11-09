import 'dart:convert';

import 'package:phoenixschool/model/fnicialstatemnetmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../component/general_URL.dart';
import '../model/message_model.dart';

class Financial_Controller{
    Future<List<FinicailaModel>?> getfinicialstatement(String startdate,String enddate,String value_user_id) async {
  final prefs = await SharedPreferences.getInstance();
        final keyid = 'token';
        final valuetoken = prefs.get(keyid);
    String myUrl = "$serverUrl/v1/user/order?student_card_id=$value_user_id&s_date=$startdate&e_date=$enddate&access_token=$valuetoken";
    print(myUrl);
    http.Response response = await http.get(Uri.parse(myUrl) );
    if (response.statusCode == 200) {
      List body = jsonDecode(response.body)['data'];
      print(response.body);
      try {
        List<FinicailaModel> orders = body
            .map(
              (dynamic item) => FinicailaModel.fromJson(item),
            )
            .toList();
        return orders;
      } catch (error) {
        print(error);
        return null;
      }
    } else {
      print(response.body);
      // throw "Error While getting Properties";
    }
  }
}