import 'package:flutter/material.dart';
import 'package:phoenixschool/component/Color.dart';
import 'package:phoenixschool/controller/addreplaycontroller.dart';
import 'package:phoenixschool/controller/getusertypecontroller.dart';
import 'package:phoenixschool/controller/ratingsysyemcontroler.dart';
import 'package:phoenixschool/model/message_model.dart';
import 'package:phoenixschool/view/footer.dart';

import '../../../model/getadvisornamemodel.dart';
RatingSystemController _ratingSystemController=RatingSystemController();
class NotesDetails extends StatefulWidget {
  final MessageModel mynotes;
   NotesDetails({super.key, required this.mynotes});

  @override
  State<NotesDetails> createState() => _NotesDetailsState();
}
AddReplay _addReplay=AddReplay();
TextEditingController myreplay=TextEditingController();

bool isloading=false;
GetUserTypecontroller _getUserTypecontroller=GetUserTypecontroller();
late AdisorModel _adisorModel;
class _NotesDetailsState extends State<NotesDetails> {
String myvalue="جيدة";
void initState() {
    _getUserTypecontroller.gettype(widget.mynotes.message_type["message_type_id"]).then((value){
      print(value);
      _adisorModel=value!;
      setState(() {
        isloading=true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Footer(),
      appBar: AppBar(
        backgroundColor: globalcolor,
        elevation: 0,
        title: Text(widget.mynotes.message_title),
      ),
      body: Opacity(
        opacity: 0.8,
        child: Container(
          margin: EdgeInsets.all(20),
          color: Colors.lightBlue,
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                    Center(child: Text("العنوان : "+widget.mynotes.message_body)),
                    isloading?
                        Container(
                          padding: EdgeInsets.all(5),
                          alignment: Alignment.center,
                          color: globalcolor,
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.person,color: Colors.white,),
                              Text(_adisorModel.name,style: TextStyle(color: Colors.white),),
                            ],
                          )):SizedBox(),
                    Column(
                      children: [
                        Container(
                          alignment: Alignment.centerRight,
                          child: Text(":الردود",style: TextStyle(color: globalcolor,fontSize: 20),textAlign: TextAlign.right,)),
                        Container(
                          height: 200,
                          child: ListView.builder(
                            itemCount:widget.mynotes.replies.length ,
                            itemBuilder: (context, index2) {
                              return Container(
                                alignment: Alignment.centerRight,
                                child: Text(widget.mynotes.replies[index2]["reply_content"],textAlign: TextAlign.right,));
                          },),
                        ),

      
                        Text("قم بالرد على الرسالة"),
                        Container(
                          padding: EdgeInsets.all(5),
                          height: 50,
                          child: TextFormField(
                            decoration: InputDecoration(
                              fillColor: Colors.grey[300],
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: globalcolor)),
                            ),
                            controller: myreplay,
                          ),
                        ),
                        MaterialButton(
                          child: Text("ارسل",style: TextStyle(color: Colors.white)),
                          color: Colors.green,
                          onPressed: () {
                             _addReplay.addReplay(context, myreplay.text, widget.mynotes.message_id);
                        },),
                        
                        Container(
                          width: 200,
                          child: MaterialButton(
                            child: Text("قم بتقيمنا"),
                            color: globalcolor,
                            onPressed: () {
                              
                              showDialog(context: context, builder: (context) {
                                return AlertDialog(
                                  content: StatefulBuilder(
                                    builder: (BuildContext context, void Function(void Function()) setState) {
                                    return Container(
                                      height: 300,
                                      child: Column(
                                        children: [
                                          Text("قيم سرعة الرد"),
                                          Column(
                                            children: <Widget>[
                                              ListTile(
                                                title: const Text('جيدة'),
                                                leading: Radio<String>(
                                                  value: "جيدة",
                                                  groupValue: myvalue,
                                                  onChanged: (String? value) {
                                                    print(value);
                                                    setState(() {
                                                      myvalue = "جيدة";
                                                    });
                                                  },
                                                ),
                                              ),
                                              ListTile(
                                                title: const Text('متوسطة'),
                                                leading: Radio<String>(
                                                  value: "متوسطة",
                                                  groupValue: myvalue,
                                                  onChanged: (String? value) {
                                                    print(value);
                                                    setState(() {
                                                      myvalue = "متوسطة";
                                                    });
                                                  },
                                                ),
                                              ),
                        
                                              ListTile(
                                                title: const Text('سريعة'),
                                                leading: Radio<String>(
                                                  value: "سريعة",
                                                  groupValue: myvalue,
                                                  onChanged: (String? value) {
                                                    print(value);
                                                    setState(() {
                                                      myvalue = "سريعة";
                                                    });
                                                  },
                                                ),
                                              ),
                                              ListTile(
                                                title: const Text('لم يتم الرد'),
                                                leading: Radio<String>(
                                                  value: "لم يتم الرد",
                                                  groupValue: myvalue,
                                                  onChanged: (String? value) {
                                                    print(value);
                                                    setState(() {
                                                      myvalue = "لم يتم الرد";
                                                    });
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                          MaterialButton(
                                              color: globalcolor,
                                              child: Text("تاكيد"),
                                              onPressed: () {
                                                _ratingSystemController.rate(context, myvalue, widget.mynotes.message_id);
                                            },),
                                        ],
                                      ),
                                      
                                        );
                                      },
                                  )
                                  ,);
                              },);
                          },),
                        )
                      ],
                    ),
                    Center(child: Text(widget.mynotes.message_send_date)),
              ],
            ),
          ),
        ),
      ),

    );
  }
}


