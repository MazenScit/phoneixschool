
import 'package:flutter/material.dart';
import 'package:phoenixschool/component/Color.dart';
import 'package:phoenixschool/controller/message_controller.dart';
import 'package:phoenixschool/model/message_model.dart';
import 'package:phoenixschool/view/footer.dart';
import 'package:phoenixschool/view/homepagecomponent/degreesystem/degreemainpage.dart';
import 'package:phoenixschool/view/homepagecomponent/notessystem/addnewnote.dart';
import 'package:phoenixschool/view/homepagecomponent/notessystem/notesdetails.dart';
import 'package:shared_preferences/shared_preferences.dart';
getuserid() async {
  final prefs = await SharedPreferences.getInstance();
        final keyid = 'user_id';
        final valuetoken = prefs.get(keyid);
        return valuetoken;
}
late String user_id;
class ShowNotesByPerson extends StatefulWidget {
  const ShowNotesByPerson({super.key, });

  @override
  State<ShowNotesByPerson> createState() => _ShowNotesByPersonState();
}
bool isloading=false;
Message_Controller message_controller=Message_Controller();
bool nullstatement=false;
late List <MessageModel> mynotes;
class _ShowNotesByPersonState extends State<ShowNotesByPerson> {
  @override
  void initState() {
    getuserid().then((value){
        message_controller.getmessages(2,value).then((value) {
      mynotes=value!;
      setState(() {
        nullstatement=false;
        isloading=true;
      });
    },).onError((error, stackTrace){
                                    setState(() {
                                            nullstatement=true;
                                            });
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
        title: Text("الملاحظات"),
        actions: [
          Container(
            padding: EdgeInsets.all(7),
            child: MaterialButton(
              color: Colors.blue,
              child: Container(
                child: Row(
                  children: [
                    Text("اضافة ملاحظة",style: TextStyle(color: Colors.white),),
                    Icon(Icons.add,color: Colors.white,)
                  ],
                ),
              ),
              onPressed: () {
                Navigator.push(context,
                             MaterialPageRoute(builder: (BuildContext context) {
                             return AddNewNote();
                            }));
            },),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20,),
              !nullstatement?
              isloading?
              RefreshIndicator(
                onRefresh: () { 
          return getuserid().then((value){
                message_controller.getmessages(2,value).then((value) {
              mynotes=value!;
              setState(() {
                nullstatement=false;
                isloading=true;
              });
                  },).onError((error, stackTrace){
                                          setState(() {
                                                  nullstatement=true;
                                                  });
                                        });
                });
              },
                child: Container(
                  height: height-170,
                  child: GridView.builder(
                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.2,
                      mainAxisExtent: 150,
                    ),
                    itemCount: mynotes.length,
                    itemBuilder: (context, index) {
                      return 
                      InkWell(
                        onTap: () {
                          Navigator.push(context,
                               MaterialPageRoute(builder: (BuildContext context) {
                               return NotesDetails(mynotes: mynotes[index]);
                              }));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: mygridcolor[index % 4],
                                borderRadius: BorderRadius.all(Radius.circular(30)),
                              ),
                          
                          height: height/9,
                        margin: EdgeInsets.only(left: 10,right: 10,bottom: 10),
                        alignment: Alignment.center,
                        child: Text(mynotes[index].message_title,style:TextStyle(color:Colors.white) ,),
                        ),
                      );
                    },),
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
                          getuserid().then((value){
                                      message_controller.getmessages(2,value).then((value) {
                                    mynotes=value!;
                                    setState(() {
                                      isloading=true;
                                    });
                                  },).onError((error, stackTrace){
                                    setState(() {
                                            nullstatement=true;
                                            });
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


List <Color> mygridcolor=[globalcolor,Color.fromARGB(255, 57, 160, 244),Color.fromARGB(255, 88, 53, 244),Color.fromARGB(255, 83, 62, 179),];