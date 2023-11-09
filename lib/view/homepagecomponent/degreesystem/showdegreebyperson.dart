import 'package:flutter/material.dart';
import 'package:phoenixschool/component/Color.dart';
import 'package:phoenixschool/controller/mark_controller.dart';
import 'package:phoenixschool/view/footer.dart';
import 'package:phoenixschool/view/homepagecomponent/degreesystem/addeducitionalnote.dart';

import '../../../model/mark_model.dart';

bool isloading=false;

bool nullstatement=false;
class NotesByPerson extends StatefulWidget {
  final String value_user_id;
  final String name;
  const NotesByPerson({super.key, required this.value_user_id, required this.name});

  @override
  State<NotesByPerson> createState() => _NotesByPersonState();
}
late List <MarkModel> mymark;
Mark_Controller mark_controller=Mark_Controller();
class _NotesByPersonState extends State<NotesByPerson> {
  @override
  void initState() {
    mymark=[];
    mark_controller.getmarks(widget.value_user_id).then((value) {
      mymark=value!;
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
    var width= MediaQuery.of(context).size.width;
    return Scaffold(
      bottomNavigationBar: Footer(),
      appBar: AppBar(
        backgroundColor: globalcolor,
        elevation: 0,
        title: Text(widget.name),
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
                             return AddEducitionalNote();
                            }));
            },),
          )
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20,),
              !nullstatement?
              isloading?
              Container(
                height: height-170,
                child: ListView.builder(
                  itemCount: mymark.length,
                  itemBuilder: (context, index) {
                    return 
                    Container(
                    margin: EdgeInsets.only(left: 10,right: 10,bottom: 3),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
     
                        ExpansionTile(
                           title:  Container(
                            color: Colors.blue,
                             child: Center(
                              
                              child: Text(mymark[index].year.toString(),style: TextStyle(color: Colors.black,fontSize: 20),)),
                           ),
                         
                           children: [
                            Container(
                            color: Colors.grey[300],
                            height: 400,
                            child:getcourses(mymark[index].data),
                           ),]
                         ),
                         

                         
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
                          mymark=[];
                              mark_controller.getmarks(widget.value_user_id).then((value) {
                                mymark=value!;
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
getcourses(data){
  return ListView.builder(
    itemCount:data.length ,
    itemBuilder: (context, index) {
      return ExpansionTile(
        title: Center(child: Text("الشهر  "+data[index]['month'].toString())),
        children:[ 
          Container(
          color: globalcolor,
          margin: EdgeInsets.all(15),
          child: Container(
            height: 300,
            child: ListView.builder(
              itemCount: data[index]['data'].length,
              itemBuilder: (context, index2) {
                 return Container(
                  margin: EdgeInsets.all(10),
                  color: Colors.blue,
                   child: Column(
                     children: [
                       Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                         children: [
                          Text( data[index]['data'][index2]['mark_degree'].toString(),style: TextStyle(color: Colors.white),),
                        
                           Text( data[index]['data'][index2]['mark_course']['course_name'].toString(),style: TextStyle(color: Colors.white),),
                         ],
                       ),
                       Text( data[index]['data'][index2]['mark_date'].toString(),style: TextStyle(color: Colors.white),),
                         
                     ],
                   ),
                 );
            },),
          ),
        ),]
      );
  },);
}