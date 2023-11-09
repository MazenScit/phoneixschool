
import 'package:flutter/material.dart';
import 'package:phoenixschool/authentication/LoginPage.dart';
import 'package:phoenixschool/component/myimage.dart';
import 'package:phoenixschool/view/navigationhomepagebar.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});
  

  @override
  Widget build(BuildContext context) {
    var width= MediaQuery.of(context).size.width;
   var height= MediaQuery.of(context).size.height;
    return Drawer(
      backgroundColor: Colors.white,//rgba(192,189,174,255)
      child: Column(
        children: [
         SizedBox(height: height/15,),
         Container(
          height: height/7,width: width/3,
           child: SizedBox.fromSize(
             size: Size.fromRadius(100), // Image radius
             child: Image.asset(logoimage, fit: BoxFit.fill),
           ),
         ),
          // Container(
          //   height: 100,
          //   child: Image.asset("assets/logo2.PNG",width: width/2)),
          SizedBox(height: height/80,),
          Container(
            width: width/1.5,
          height: height/15,
          alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                   HomePageNavBar()), (Route<dynamic> route) => false);
                
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.home,color: Colors.blue,size: 30,),
                  Text("الصفحة الرئيسية",style: TextStyle(color:Colors.black,fontSize: 12,fontWeight: FontWeight.bold),),
                ],
              )
              ,
            ),
          ),
          SizedBox(height: height/80,),
         
          Container(
            width: width/1.5,
          height: height/15,
          alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () {
                 Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                   LoginPage()), (Route<dynamic> route) => false);
                
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.logout,color: Colors.blue,size: 30,),
                  Text("تسجيل خروج",style: TextStyle(color:Colors.black,fontSize: 12,fontWeight: FontWeight.bold),),
                ],
              )
              ,
            ),
          ),
          
          
          SizedBox(height: height/80,),
        ],
      ),
    );
  }
}