
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:phoenixschool/authentication/studentlist.dart';
import 'package:phoenixschool/component/myimage.dart';
import 'package:phoenixschool/controller/authentication_controller.dart';
import 'package:phoenixschool/controller/message_controller.dart';
import 'package:phoenixschool/model/message_model.dart';
import 'package:phoenixschool/view/financialstatementsystem/financialstatement.dart';
import 'package:phoenixschool/view/homepagecomponent/advertsiting/advertstingpage.dart';
import 'package:phoenixschool/view/homepagecomponent/cardswiper/dataswiper.dart';
import 'package:phoenixschool/view/homepagecomponent/degreesystem/degreemainpage.dart';
import 'package:phoenixschool/view/homepagecomponent/filesystem/filesmanageing.dart';
import 'package:phoenixschool/view/homepagecomponent/messagesystem/messagespage.dart';
import 'package:phoenixschool/view/homepagecomponent/notessystem/shownotesbyperson.dart';
import 'package:phoenixschool/view/occasionssystem/showoccasions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

late List <MessageModel> messagedata;
bool isloading=false;
Authentiction_Control _authentiction_control=Authentiction_Control();


List <String> component=["رسائل المتابعة","الملفات","العلامات","الملاحظات","المناسبات","اعلانات","","استحقاق مالي"];
List <String> compnenticon=
["assets/icon/message.png",
'assets/icon/file.png',
'assets/icon/degree.png',
'assets/icon/notes.png',
'assets/icon/occasion.png',
'assets/icon/ads.png',
"",
'assets/icon/monay.png'];

Message_Controller _message_controller=Message_Controller();
late List <MessageModel> myoccassion;
bool isloading2=false;
bool nullstatement=false;
List <Widget> pages=[MessagePage(),FilesManaging(),DegreeMainPage(),ShowNotesByPerson(),ShowOccasion(),AdvertisingPage(),SizedBox(),FinancialStatement()];
class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    
     
    _message_controller.getmessages(3, mydata[0].student_card_id).then((value) {
      myoccassion=value!;
      setState(() {
        isloading2=true;
      });
    }, ).onError((error, stackTrace){
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
      backgroundColor: Color.fromARGB(255, 247, 242, 242),
      body: Container(
        height: height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backgroundimageclear),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              !nullstatement?
              isloading2?
              Container(
                height: 100,
                child: DataSwiper(myoccassion:myoccassion),
              ):CircularProgressIndicator():Text("somthing went wrong!!"),
             Opacity(
              opacity: 0.8,
               child: Container(
                padding:  EdgeInsets.symmetric(horizontal: 40),
                height:410,
                 child: GridView.builder(
                   // shrinkWrap: true,
                   itemCount: 8,
                   itemBuilder: (ctx, i) {
                     return 
                     i==6?
                     SizedBox():
                     InkWell(
                       onTap: () {
                         Navigator.push(context,
                              MaterialPageRoute(builder: (BuildContext context) {
                              return pages[i];
                             }));
                         
                       },
                       child: Container(
                         height: 200,
                         decoration: BoxDecoration(
                           boxShadow: [
                             BoxShadow(
                               color: Colors.grey,
                               blurRadius: 4,
                               offset: Offset(4, 8), // Shadow position
                             ),
                           ],
                           color: Colors.white,
                             borderRadius: BorderRadius.circular(20)),
                         margin: EdgeInsets.all(5),
                         padding: EdgeInsets.all(5),
                         child: Column(
                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                           children: [
                             Container(
                               alignment: Alignment.center,
                               height: 80,
                               child: Image.asset(compnenticon[i])),
                              
                             Container(
                               alignment: Alignment.center,
                               child: Text(component[i],style: TextStyle(fontSize: 13),)),
                           ],
                         )
                       ),
                     );
                   },
                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                     crossAxisCount: 3,
                     childAspectRatio: 1.2,
                     crossAxisSpacing: 2,
                     mainAxisSpacing: 10,
                     mainAxisExtent: 130,
                   ),
                 ),
               ),
             ),
            ],
          ),
        ),
      ),
    );
  } 



  
}





