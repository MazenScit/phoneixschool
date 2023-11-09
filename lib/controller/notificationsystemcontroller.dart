import 'package:phoenixschool/component/general_URL.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class NotiicationSysytem {
  Future sendNotificationToken(context,String notificationtoken) async {
   String myUrl = "$serverUrl/v1/user/refreshToken";
    final prefs = await SharedPreferences.getInstance();
        final keyid = 'token';
        final valueid = prefs.get(keyid);
        final keyuser_id = 'user_id';
        final valueuserid = prefs.get(keyuser_id);
        print(notificationtoken);
        
    http.Response response = await http.put(Uri.parse(myUrl),body: {
      "id":valueuserid,
      "access_token":valueid,
      "fcm_token":notificationtoken,
    });
    print(response.body);
    print(response.statusCode);
    
  }



  Future updateMessageToSeen(String id) async {
   String myUrl = "$serverUrl/v1/user/refreshToken";
    final prefs = await SharedPreferences.getInstance();
        final keyid = 'token';
        final valueid = prefs.get(keyid);
        
    http.Response response = await http.put(Uri.parse(myUrl),body: {
      "id":id,
      "access_token":valueid,
      "status":"SEEN",
    });
    print(response.body);
    print(response.statusCode);
    
  }
}