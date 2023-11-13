
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:phoenixschool/authentication/studentlist.dart';
import 'package:phoenixschool/component/Color.dart';
import 'package:phoenixschool/component/myimage.dart';
import 'package:phoenixschool/component/testinternet.dart';
import 'package:phoenixschool/component/widgetofauth.dart';
import 'package:phoenixschool/controller/authentication_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}
Authentiction_Control user_controller=Authentiction_Control();
bool _isHiddenPassword=true;
TextEditingController phonecontroller=TextEditingController();
TextEditingController passwordcontroller=TextEditingController();



var subscription;
class _LoginPageState extends State<LoginPage> {
  bool ignoring = false;
  void setIgnoring(bool newValue) {
    setState(() {
      ignoring = newValue;
    });
  }
    GlobalKey<FormState> formstate= new GlobalKey<FormState>();
    
  @override
  void initState() {
    super.initState();
  }
  Widget build(BuildContext context) {
   var width= MediaQuery.of(context).size.width;
   var height= MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: globalcolor,
      body: Container(
         width: width,
          height: height,
          padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Form(
            key: formstate,
            child: Column(
              children: [
                SizedBox(height:height/20,),
                
                Container(
                  height: height/4,
                  child: Image.asset(logoiconimage)),
                SizedBox(height:height/10,),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  padding: EdgeInsets.all(20),
                  
                  child: Column(
                    children: [
                      Container(
                  height: height/15,
                  alignment: Alignment.centerLeft,
                  child: Image.asset(logoimage)),
                      textform(
                        phonecontroller,
                        "رقم الهاتف",
                         TextInputType.phone,
                         () {
                         
                      },
                      false,
                      (value) {
                         if (!(value?.length==10 || value?.length==9)) {
                          return "ادخل رقم موبايل صالح";
                         }
                         return null;
                        },context,
                      ),
                    
                textform(
                  passwordcontroller,
                  "كلمة المرور",
                   TextInputType.visiblePassword,
                   () {
                  setState(() {
                    _isHiddenPassword=!_isHiddenPassword;
                  });
                },
                
                _isHiddenPassword,
        
                (value) {
                   if (value!.length < 6) {
                    return "كلمة المرور مكونة من ست احرف على الاقل";
                   }
                   return null;
                  },context,
                ),


                SizedBox(height:height/50,),
        
                  Container(
                    width: width/1.4,
                    height: height/15,
                    child: IgnorePointer(
                      ignoring: ignoring,
                      child: loginbutton(
                        "تسجيل دخول",
                        () {
                         var formdata=formstate.currentState;
                         
                         if (formdata!.validate()) {
                             
                            // user_controller.login(context,phonecontroller.text, passwordcontroller.text,).whenComplete((){
                            //   setIgnoring(!ignoring);
                            // });
                            checkconnect().then((value) async {
                              
                              if(value){
                                setIgnoring(!ignoring);
                                mydata=[];
                                await user_controller.login(context,phonecontroller.text, passwordcontroller.text,).then((value){
                                  // value=null;
                                  print(value);
                                  mydata=value??[];
                                  
                                }).whenComplete((){
                                  setIgnoring(!ignoring);
                                }).onError((error, stackTrace){
                                  setIgnoring(!ignoring);
                                  showDialog(context: context, builder:  (context) {
                                    return AlertDialog(
                                      content: Text("somthing went wrong!!"),
                                    );
                                  },);
                                });
                                
                              }else{
                                showDialog(context: context, builder:(context) {
                                  return Opacity(
                                    opacity: 0.8,
                                    child: AlertDialog(
                                      elevation: 0,
                                    content: Container(
                                     
                                      height: 100,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          LineIcon(LineIcons.exclamationCircle,color: Colors.red,size: 40,),
                                          Text('check internet connection',style: TextStyle(fontSize: 13),),
                                        ],
                                      ),
                                      ),
                                                                  ),
                                  );
                                }, );
                                
                              }
                            });
                            
                         }
                      },!ignoring),
                    ),
                  ),
                  SizedBox(height:height/70,),
                   ignoring?CircularProgressIndicator():SizedBox(),

                           SizedBox(height:height/50,),
                    //        Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    // children: [
                    //   InkWell(
                    //     onTap: () {
                    // //       Navigator.push(context,
                    // //     MaterialPageRoute(builder: (BuildContext context) {
                    // //   return SignUpPage();
                    // // }));
                    //     },
                    //     child: Text("سجل الان",style: TextStyle(color: globalcolor,fontSize: 15),)
                    //     ),
                    //   Text(" هل لديك حساب؟ ",style: TextStyle(fontSize: 13),),
                    //   //rgba(11,79,108,255)
                    //        ],
                    //        ),
                           ],
                  ),
                ),
                      
                          ],
            ),
          ),
        ),
      ),
    );
  }
}



