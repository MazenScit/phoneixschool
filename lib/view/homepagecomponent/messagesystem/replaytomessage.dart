
 import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:phoenixschool/component/Color.dart';
import 'package:phoenixschool/controller/addreplaycontroller.dart';
import 'package:phoenixschool/controller/getusertypecontroller.dart';
import 'package:phoenixschool/controller/message_controller.dart';
import 'package:phoenixschool/controller/ratingsysyemcontroler.dart';
import 'package:phoenixschool/model/getadvisornamemodel.dart';
import 'package:phoenixschool/model/message_model.dart';
import 'package:phoenixschool/view/footer.dart';
import 'package:phoenixschool/view/homepagecomponent/homepage.dart';

class ReplayToMessage extends StatefulWidget {
  final String id;
  final String body;
  final String addvisor_id;
  final  replies;
  
  const ReplayToMessage({super.key, required this.id, required this.body,required this.replies, required this.addvisor_id,});
  @override
  State<ReplayToMessage> createState() => _ReplayToMessageState();
}
GetUserTypecontroller _getUserTypecontroller=GetUserTypecontroller();
AddReplay _addReplay=AddReplay();
RatingSystemController _ratingSystemController=RatingSystemController();
TextEditingController myreplay=TextEditingController();
bool isloading=false;
ScrollController _scrollController = new ScrollController();
late AdisorModel _adisorModel;
class _ReplayToMessageState extends State<ReplayToMessage> {
  String myvalue="جيدة";

  @override
  void initState() {
    myreplay.text="";
    _getUserTypecontroller.gettype(widget.addvisor_id).then((value){
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
    var height= MediaQuery.of(context).size.height;
    return Scaffold(
      bottomNavigationBar: Footer(),
      appBar: AppBar(
        backgroundColor:globalcolor,
        centerTitle: true,
        title: Text("الرد على الرسالة"),
      ),
    backgroundColor:Colors.white,
        
        body: Container(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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

                          Container(
                          alignment: Alignment.centerRight,
                          child: Text(":الردود",style: TextStyle(color: globalcolor,fontSize: 20),textAlign: TextAlign.right,)),
                        
                          Container(
                          height: 170,
                          child: ListView.builder(
                            itemCount:widget.replies.length ,
                            itemBuilder: (context, index2) {
                              return Container(
                                alignment: Alignment.centerRight,
                                child: Text(widget.replies[index2]["reply_content"],textAlign: TextAlign.right,));
                          },),
                        ),
                        SizedBox(height: 20,),
                        Container(
                          padding: EdgeInsets.all(5),
                          alignment: Alignment.center,
                          color: globalcolor,
                          width: double.infinity,
                          child: Text(widget.body,style: TextStyle(color: Colors.white),)),

      
                        Text("قم بالرد على الرسالة"),
                        Container(
                          padding: EdgeInsets.all(5),
                          height: 50,
                          child: TextFormField(
                            decoration: InputDecoration(
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
                             _addReplay.addReplay(context, myreplay.text, widget.id);
                        },),



                        Container(
                          width: 200,
                          child: MaterialButton(
                            child: Text("قم بتقيمنا",style: TextStyle(color: Colors.white)),
                            color: Colors.lightBlue,
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
                                              _ratingSystemController.rate(context, myvalue, widget.id);
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

          ),
        ),
   
      );
  }

}