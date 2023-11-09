import 'package:flutter/material.dart';
import 'package:phoenixschool/authentication/studentlist.dart';
import 'package:phoenixschool/component/Color.dart';
import 'package:phoenixschool/controller/getadvisornamecontroler.dart';
import 'package:phoenixschool/controller/sendcomplaintcontroller.dart';
import 'package:phoenixschool/model/getadvisornamemodel.dart';
import 'package:phoenixschool/model/user_model.dart';
import 'package:phoenixschool/view/footer.dart';

class AddEducitionalNote extends StatefulWidget {
  const AddEducitionalNote({super.key});

  @override
  State<AddEducitionalNote> createState() => _AddEducitionalNoteState();
}
SendComplaint _sendComplaint=SendComplaint();
AdvisorController _advisorController=AdvisorController();
late List <AdisorModel> myAdvisor;

bool isloading=false;
late String dropdownValue;
 String dropdownValuename=mydata.first.student_card_id ;
TextEditingController complaintcontroller=TextEditingController();
TextEditingController titlecontroller=TextEditingController();
bool nullstatement=false;
// MyController _myController=MyController();
class _AddEducitionalNoteState extends State<AddEducitionalNote> {
  @override
  void initState() {
    _advisorController.getadvisorname().then((value) {
    myAdvisor=value!;
   dropdownValue= myAdvisor.first.id;
   setState(() {
    nullstatement=false;
     isloading=true;
   });
    
  },).onError((error, stackTrace){
                                    setState(() {
                                            nullstatement=true;
                                            });
                                  });
   
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
   var width= MediaQuery.of(context).size.width;
   var height= MediaQuery.of(context).size.height;
    return Scaffold(
      bottomNavigationBar: Footer(),
      appBar: AppBar(
        backgroundColor: globalcolor,
        elevation: 0,
        title: Text("اضف ملاحظة"),
      ),
      body: Container(
        height: height,
        width: width,
        child: SingleChildScrollView(
          child: 
          !nullstatement?
            isloading?
          Column(
            children: [
              Container(
                 alignment: Alignment.center,
                 child: Text("ملاحظة جديدة",style: 
                    TextStyle(color:globalcolor,fontSize: 20,fontWeight: FontWeight.bold),)),
                  
               SizedBox(height: 10,),
               
               Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                color: Colors.blueGrey[100],
                 child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     DropdownButton<String>(
                          value: dropdownValue,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          style: const TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (String? value) {
                            // This is called when the user selects an item.
                            print(dropdownValue);
                            setState(() {
                              dropdownValue = value!;
                            });
                          },
                          items: myAdvisor.map<DropdownMenuItem<String>>((AdisorModel value) {
                            return DropdownMenuItem<String>(
                              value: value.id.toString(),
                              child: Text(value.name.toString()),
                            );
                          }).toList(),
                        ),
                        Text(":المرسل اليه"),
                   ],
                 ),
               ),
                 SizedBox(height: height/40,),
                 Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                color: Colors.blueGrey[100],
                 child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     DropdownButton<String>(
                          value: dropdownValuename,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          style: const TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (String? value) {
                            // This is called when the user selects an item.
                            print(dropdownValuename);
                            setState(() {
                              dropdownValuename = value!;
                            });
                          },
                          items: mydata.map<DropdownMenuItem<String>>((User_Model value) {
                            return DropdownMenuItem<String>(
                              value: value.student_card_id,
                              child: Text(value.student_first_name+" " +value.student_last_name),
                            );
                          }).toList(),
                        ),
                        Text(":المرسل"),
                   ],
                 ),
               ),
                 SizedBox(height: height/40,),
                  Container(
              height: height/9,
              width: double.infinity,
              child: TextFormField(
                maxLength: 50,
                textAlign: TextAlign.right,
                controller: titlecontroller,
                  keyboardType: TextInputType.text,
                  cursorColor: Color.fromRGBO(0, 0, 0, 1),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.blueGrey[100],
                      hintText: "العنوان",
                 hintStyle:
                TextStyle(color: Color(0xff8c9289), fontFamily: 'Cobe',fontSize: 15),
              ),
           ),
               ),
               SizedBox(height: height/40,),
                    Container(
              height: height/3.5,
              width: double.infinity,
              child: TextFormField(
                textAlign: TextAlign.right,
                controller: complaintcontroller,
                  maxLines: 20,
                  maxLength: 200,
                  keyboardType: TextInputType.text,
                  cursorColor: Color.fromRGBO(0, 0, 0, 1),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.blueGrey[100],
                      hintText: "اكتب ما يجول في خاطرك",
                 hintStyle:
                TextStyle(color: Color(0xff8c9289), fontFamily: 'Cobe',fontSize: 15),
              ),
           ),
               ),

                Container(
                  height: height/10,
                  width: width/2.7,
                  decoration: BoxDecoration(
                        color: globalcolor,
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                      ),
                  child: MaterialButton(
                  child: Text("ارسل"),
                  onPressed: () {
                  _sendComplaint.sendcomplaint(context, titlecontroller.text, complaintcontroller.text,
                     dropdownValuename, dropdownValue);},),
                ),


            ],
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
                        _advisorController.getadvisorname().then((value) {
                                    myAdvisor=value!;
                                  dropdownValue= myAdvisor.first.id;
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
                      },)
                    ],
                  )),
        ),
      ),
    );
  }
}
