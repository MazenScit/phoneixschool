import 'package:flutter/material.dart';
import 'package:phoenixschool/authentication/studentlist.dart';
import 'package:phoenixschool/component/Color.dart';
import 'package:phoenixschool/component/myimage.dart';
import 'package:phoenixschool/controller/message_controller.dart';
import 'package:phoenixschool/model/message_model.dart';
import 'package:phoenixschool/view/footer.dart';
import 'package:phoenixschool/view/occasionssystem/showoccasiondetails.dart';

class AdvertisingPage extends StatefulWidget {
  const AdvertisingPage({super.key});

  @override
  State<AdvertisingPage> createState() => _AdvertisingPageState();
}
Message_Controller _message_controller=Message_Controller();
late List <MessageModel> myoccassion;
bool isloading=false;
bool nullstatement=false;
class _AdvertisingPageState extends State<AdvertisingPage> {
  @override
  void initState() {
    if (!(mydata.isEmpty)) {
      
    
    _message_controller.getmessages(7, mydata[0].student_card_id).then((value) {
      myoccassion=value!;
      setState(() {
        nullstatement=false;
        isloading=true;
      });
    }, ).onError((error, stackTrace) {
                                        setState(() {
                                          nullstatement=true;
                                          });
                                      });
                                      }
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
        title: Text("الاعلانات"),
      ),
      body: Container(
        
        height: height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: height/20,),
              !nullstatement?
              isloading?
             Container(
              height: height-190,
               child: Center(
                child: GridView.builder(
                  // shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  itemCount: myoccassion.length,
                  itemBuilder: (ctx, i) {
                    return InkWell(
                      onTap: () {
                        // Navigator.push(context,
                        //      MaterialPageRoute(builder: (BuildContext context) {
                        //      return SowOcaassionDetails(myoccassion:myoccassion[i]);
                        //     }));
                        
                      },
                      child: Opacity(
                        opacity: 0.8,
                        child: Container(
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 4,
                                offset: Offset(4, 8), // Shadow position
                              ),
                            ],
                              borderRadius: BorderRadius.circular(20)),
                          margin: EdgeInsets.all(5),
                          padding: EdgeInsets.all(5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 30),
                                color: globalcolor,
                                alignment: Alignment.center,
                                height: 60,
                                child: Text(myoccassion[i].message_title,style: TextStyle(color: Colors.yellow),)),
                               
                              Container(
                                alignment: Alignment.center,
                                child: Text(myoccassion[i].message_send_date)),
                            ],
                          )
                        ),
                      ),
                    );
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    childAspectRatio: 1.2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    mainAxisExtent: 220,
                  ),
                ),
                         ),
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
                          _message_controller.getmessages(7, mydata[0].student_card_id).then((value) {
                                  myoccassion=value!;
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