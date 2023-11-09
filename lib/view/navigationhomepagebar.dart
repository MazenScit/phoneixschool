import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:phoenixschool/component/Color.dart';
import 'package:phoenixschool/component/drawer.dart';
import 'package:phoenixschool/component/myimage.dart';
import 'package:phoenixschool/view/financialstatementsystem/financialstatement.dart';
import 'package:phoenixschool/view/homepagecomponent/homepage.dart';
import 'package:phoenixschool/view/occasionssystem/showoccasions.dart';
import 'package:flutter/services.dart';
import '../controller/notificationsystemcontroller.dart';
import 'aboutussystem/aboutus.dart';


class HomePageNavBar extends StatefulWidget {

  const HomePageNavBar({super.key,});
  @override
  HomePageNavBarState createState() => HomePageNavBarState();
}

enum SampleItem { itemOne, itemTwo, itemThree }
NotiicationSysytem _notiicationSysytem=NotiicationSysytem();
class HomePageNavBarState extends State<HomePageNavBar> {
  
var fbm =FirebaseMessaging.instance;

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late int _selectedIndex;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 10, fontWeight: FontWeight.w600);
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    AboutUs(),
  ];
   @override
  void initState() {
    
    fbm.getToken().then((token) {
       print("tooooooooooooken  :  $token");
       _notiicationSysytem.sendNotificationToken(context, token!);
       print("tooooooooooooken end");
     },);
     FirebaseMessaging.onMessage.listen((event) {

      print(event.data.toString());
      var mylist=event.data.values.elementAt(0);
      FlutterRingtonePlayer.playNotification();
      print(jsonDecode(mylist)["message_title"]);
      print(jsonDecode(mylist)["message_body"]);
      
      AwesomeDialog(
        dialogType: DialogType.info,
        animType: AnimType.rightSlide,
        body:Column(
          children: [
            Text(jsonDecode(mylist)["message_title"],style: TextStyle(color: Colors.red,fontSize: 16),),
            Text(jsonDecode(mylist)["message_body"],style: TextStyle(color: Colors.black,fontSize: 16),),
          ],
        ),
        context: context,
         btnOkOnPress: () {
          print("updated");
             _notiicationSysytem.updateMessageToSeen(jsonDecode(mylist)["message_id"]);
         },
        )..show();
        
     });
    _selectedIndex=0;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    
    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        drawer: AppDrawer(),
        key: _scaffoldKey,
        appBar:   AppBar(
          // centerTitle: true,
          toolbarHeight: 70,
          actions: [
            Container(
              padding: EdgeInsets.all(10),
              child: Image.asset(logoiconimage))
          ],
    
          leading: IconButton(icon:Icon(Icons.menu,size: 30),onPressed: (){
            _scaffoldKey.currentState!.openDrawer();
          }),
    
          elevation: 0,
          backgroundColor:globalcolor,
          title: Text('Phoneix School'),
        ),
        backgroundColor: Colors.white,
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: Container(
          height: 70,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 70,
                color: Colors.black.withOpacity(.1),
              )
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 20,right: 20, top: 10,bottom: 5),
              child: GNav(
                rippleColor: Colors.grey[300]!,
                hoverColor: Colors.grey[100]!,
                gap: 50,
                activeColor:  globalcolor,
                iconSize: 30,
                
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                duration: Duration(milliseconds: 400),
                tabBackgroundColor: Colors.red[100]!,
                color: globalcolor ,
                tabs: [
                   GButton(
                    textStyle: TextStyle(fontSize: 7),
                    icon: LineIcons.home,
                    text: 'الرئيسية',
                  ),
                  GButton(
                    textStyle: TextStyle(fontSize: 7),
                    icon: LineIcons.exclamationCircle,
                    text: 'حولنا',
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }





  Future<bool> showExitPopup() async {
      return await showDialog(
            //show confirm dialogue
            //the return value will be from "Yes" or "No" options
            context: context,
            builder: (context) => AlertDialog(
              title: Container(
                height: 20,
                alignment: Alignment.topRight,
                child: Text('الخروج من التطبيق',style: TextStyle(fontSize: 15),)),
              content: Container(
                height: 20,
                alignment: Alignment.topRight,
                child: Text('هل انت متاكد انك تريد الخروج؟',style: TextStyle(fontSize: 12))),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  //return false when click on "NO"
                  child: Text('لا'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  //return true when click on "Yes"
                  child: Text('نعم'),
                ),
              ],
            ),
          ) ??
          false; //if showDialouge had returned null, then return false
    }
}