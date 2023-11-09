import 'package:flutter/material.dart';
import 'package:phoenixschool/component/myimage.dart';
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher.dart';
class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    var width= MediaQuery.of(context).size.width;
    var height= MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        width: width,
        height: height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backgroundimageclear),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Opacity(
            opacity: 0.8,
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    height: height/10,
                    alignment: Alignment.center,
                    child: Image.asset(logoimage)),
                    Text("تطبيق روضة ومدرسة الفينيق",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
                     Text("يتيح لكم تطبيق",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 14),),
                
                Text("التواصل الدائم مع ادارة المدرسة",
                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 9),),
                
                  Text("التعرف على المناسبات والنشاطات المختلفة للمدرسة",
                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 9),),
                
                  
                  Text("معرفة أخر مستجدات أبنائكم وعلاماتهم ",
                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 9),),
                
                  Text("في مختلف المواد",
                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 9),),
                
                 Text("تزويدكم برسائل المتابعة وملاحظات كادر المدرسة",
                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 9),),
                
                 Text("على سلوكيات أبنائكم",
                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 9),),
                
                 Text("الأطلاع الدائم على قائمة مشتريات أبنائكم",
                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 9),),
                
                
                 Text("بشكل دوري",
                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 9),),

                  SizedBox(height: height/30,),

                  Divider(height: 3,color: Colors.black,),
                  SizedBox(height: height/30,),

                  Container(
                    height: height/10,
                    alignment: Alignment.center,
                    child: Image.asset(logoscit_image)),
                    Text("برمجة وتصميم شركة الاختيار الذكي لتقنية المعلومات",
                         style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 9),),  
                         SizedBox(height: height/80,),
                         Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                           children: [
                             Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.blue
                              ),
                              
                               child: IconButton(
                                onPressed: () {
                                 launchUrlFacebook();
                               }, icon: Icon(LineIcons.facebookF,color: Colors.white,)),
                             ),

                             Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.lightBlue
                              ),
                              
                               child: IconButton(
                                onPressed: () {
                                 launchUrlTwitter();
                               }, icon: Icon(LineIcons.twitter,color: Colors.white,)),
                             ),

                             Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.red
                              ),
                              
                               child: IconButton(
                                onPressed: () {
                                 launchUrlWebSite();
                               }, icon: Icon(LineIcons.googleLogo,color: Colors.white,)),
                             ),
                           ],
                         ),
                         SizedBox(height: 10,)

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


void launchUrlFacebook() async{
   var url = 'https://www.facebook.com/scit.co?mibextid=ZbWKwL';
   if (await canLaunch(url)) {
     await launch( url, universalLinksOnly: true, );
   } else { throw 'There was a problem to open the url: $url'; }

 }
 void launchUrlTwitter() async{
   var url = 'https://twitter.com/scitco_sy';
   if (await canLaunch(url)) {
     await launch( url, universalLinksOnly: true, );
   } else { throw 'There was a problem to open the url: $url'; }

 }
  void launchUrlWebSite() async{
   var url = 'http://scit.co';
   if (await canLaunch(url)) {
     await launch( url, universalLinksOnly: true, );
   } else { throw 'There was a problem to open the url: $url'; }

 }