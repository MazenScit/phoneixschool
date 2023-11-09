import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:phoenixschool/model/getadvisornamemodel.dart';
import '../component/general_URL.dart';
import '../model/message_model.dart';

class AdvisorController{
    Future<List<AdisorModel>?> getname() async {
    String myUrl = "$serverUrl/v1/alladvisors";
    print(myUrl);
    http.Response response = await http.get(Uri.parse(myUrl) );
    if (response.statusCode == 200) {
      List body = jsonDecode(response.body)['data'];
      print(response.body);
      try {
        List<AdisorModel> orders = body
            .map(
              (dynamic item) => AdisorModel.fromJson(item),
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


  Future<List<AdisorModel>?> getadvisorname() async {
    String myUrl = "$serverUrl/v1/educationadvisors";
    print(myUrl);
    http.Response response = await http.get(Uri.parse(myUrl) );
    if (response.statusCode == 200) {
      List body = jsonDecode(response.body)['data'];
      print(response.body);
      try {
        List<AdisorModel> orders = body
            .map(
              (dynamic item) => AdisorModel.fromJson(item),
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