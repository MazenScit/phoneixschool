import 'package:flutter/material.dart';
import 'package:phoenixschool/authentication/studentlist.dart';
import 'package:phoenixschool/component/Color.dart';
import 'package:phoenixschool/controller/authentication_controller.dart';
import 'package:phoenixschool/controller/message_controller.dart';
import 'package:phoenixschool/model/message_model.dart';
import 'package:phoenixschool/model/user_model.dart';
import 'package:phoenixschool/view/footer.dart';
import 'package:phoenixschool/view/homepagecomponent/messagesystem/chatdetails.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key, });

  @override
  State<MessagePage> createState() => _MessagePageState();
}
late List <MessageModel> messagedata;
class _MessagePageState extends State<MessagePage> {
  @override
  void initState() {
    
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var width= MediaQuery.of(context).size.width;
   var height= MediaQuery.of(context).size.height;
    return Scaffold(
      bottomNavigationBar: Footer(),
      appBar: AppBar(
        backgroundColor: globalcolor,
        elevation: 0,
        title: Text("رسائل المتابعة"),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                height: height-150,
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return Divider(color: Colors.black,height: 3,);
                  },
                  itemCount: mydata.length,
                  itemBuilder: (context, index) {
                     return InkWell(
                      onTap: () {
                        Navigator.push(context,
                             MaterialPageRoute(builder: (BuildContext context) {
                             return ChatDetails(student_card_id: mydata[index].student_card_id,username:mydata[index].student_first_name+" "+mydata[index].student_last_name);
                            }));
                        
                      },
                       child: Container(
                        padding: EdgeInsets.all(5),
                        width: width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                          height: 50,
                          child: Image.asset('assets/icon/message.png')),
                            Text(mydata[index].student_first_name+' '+mydata[index].student_last_name)
                          ],
                        ),
                       ),
                     );
                 },),
              ),
            ],
          ),
        ),
      ),
    );
  }





}
