
import 'package:flutter/material.dart';
import 'package:phoenixschool/component/Color.dart';
import 'package:phoenixschool/controller/message_controller.dart';
import 'package:phoenixschool/model/message_model.dart';
import 'package:phoenixschool/view/homepagecomponent/filesystem/filedownloader.dart';

import '../../../component/general_URL.dart';
import '../../footer.dart';

class ShowFileByPerson extends StatefulWidget {
  final String student_card_id;
  final String name;
  const ShowFileByPerson({super.key, required this.student_card_id, required this.name});

  @override
  State<ShowFileByPerson> createState() => _ShowFileByPersonState();
}
Message_Controller message_controller=Message_Controller();
late List <MessageModel> myfile;
bool isloading=false;
bool nullstatement=false;
class _ShowFileByPersonState extends State<ShowFileByPerson> {


@override
  void initState() {
    message_controller.getmessages(1,widget.student_card_id).then((value) {
      myfile=value!;
      setState(() {
        nullstatement=false;
        isloading=true;
      });
    },).onError((error, stackTrace) {
      setState(() {
        nullstatement=true;
        });
    });
    super.initState();
  }





  @override
  Widget build(BuildContext context) {
    var height= MediaQuery.of(context).size.height;
    return Scaffold(
      bottomNavigationBar: Footer(),
      appBar: AppBar(
        backgroundColor: globalcolor,
        elevation: 0,
        title: Text(widget.name),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20,),
              !nullstatement?
              isloading?
              Container(
                height: height-170,
                child: ListView.builder(
                  itemCount: myfile.length,
                  itemBuilder: (context, index) {
                    return 
                    Container(
                      decoration: BoxDecoration(
                        color: globalcolor,
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                      
                      height: height/9,
                      padding: EdgeInsets.symmetric(horizontal:5),
                    margin: EdgeInsets.only(left: 10,right: 10,bottom: 10),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(Icons.download,size:30,color: Colors.green,),
                          ),
                          
                         Text(myfile[index].message_title,style: TextStyle(color: Colors.white,fontSize: 12),),
                        Container(
                          height: 50,
                          width: 100,
                          child: FileDownloader(downloadurl:downloadurl+"/"+myfile[index].message_attachments,name:myfile[index].message_title)),
                      ],
                    ),
                    );
                  },),
              ):Center(child: CircularProgressIndicator()):Container(
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.center,
                  child:Column(
                    children: [
                      Text("somthing went wrong!!"),
                      MaterialButton(
                        child: Text("refresh",style: TextStyle(color: Colors.white),),
                        color: globalcolor,
                        onPressed: () {
                        setState(() {
                          nullstatement=false;
                          isloading=false;
                          message_controller.getmessages(1,widget.student_card_id).then((value) {
                                        myfile=value!;
                                        setState(() {
                                          isloading=true;
                                        });
                                      },).onError((error, stackTrace) {
                                        setState(() {
                                          nullstatement=true;
                                          });
                                      });
                        });
                      },)
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}


