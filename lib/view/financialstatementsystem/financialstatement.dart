import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:phoenixschool/authentication/studentlist.dart';
import 'package:phoenixschool/component/Color.dart';
import 'package:phoenixschool/component/myimage.dart';
import 'package:phoenixschool/view/financialstatementsystem/showfinicialdetails.dart';
import 'package:phoenixschool/view/footer.dart';
class FinancialStatement extends StatefulWidget {
  const FinancialStatement({super.key});

  @override
  State<FinancialStatement> createState() => _FinancialStatementState();
}
String startdate="";
String enddate="";
class _FinancialStatementState extends State<FinancialStatement> {
  @override
  Widget build(BuildContext context) {
    var width= MediaQuery.of(context).size.width;
    var height= MediaQuery.of(context).size.height;
    return Scaffold(
      bottomNavigationBar: Footer(),
      appBar: AppBar(
        backgroundColor:globalcolor,
        centerTitle: true,
        title: Text("استحقاق مالي"),
      ),
      body: Container(
        width: width,
        height: height,
        
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
              height: height-180,
               child: Center(
                child: ListView.builder(
                  // shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  itemCount: mydata.length,
                  itemBuilder: (ctx, i) {
                    return InkWell(
                      onTap: () {
                        startdate="";
                        enddate="";
                        showDialog(context: context, builder: (context) {
                          return AlertDialog(
                            content: Container(
                              
                              height: 200,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                   DateTimePicker(
                                    initialValue: '',
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2100),
                                    textAlign: TextAlign.right,
                                    dateHintText: 'تاريخ البدأ',
                                      onChanged: (val){
                                        startdate=val;
                                      },
                                      validator: (val) {
                                        print(val);
                                        return null;
                                            },
                                        onSaved: (val) => print(val),
                                        ),
                          
                          SizedBox(height:height/70,),
                       
                              
                          DateTimePicker(
                                    initialValue: '',
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2100),
                                    textAlign: TextAlign.right,
                                      dateHintText:'تاريخ الانتهاء' ,
                                      onChanged: (val) {
                                        enddate=val;
                                      },
                                      validator: (val) {
                                        print(val);
                                        return null;
                                            },
                                        onSaved: (val) => print(val),
                                        ),
                                        SizedBox(height: 30,),  
                                        MaterialButton(
                                          color: globalcolor,
                                          child: Text('تحقق',style: TextStyle(color: Colors.white),),
                                         onPressed:() {
                                          if (startdate!="" && enddate!="") {
                                            Navigator.push(context,
                                                 MaterialPageRoute(builder: (BuildContext context) {
                                                 return ShowFiniacialdetails(startdate:startdate,enddate:enddate,value_user_id:mydata[i].student_card_id);
                                                }));
                                          } else {
                                            showDialog(context: context, builder:(context) {
                                              return Dialog(child: Text("لا تنسى ادخال التاريخ"),);
                                            }, );
                                          }
                                            
                                          },
                                          )
                                          ],
                                        ),
                                      ),
                          );
                        },);
                      },
                      child: Opacity(
                        opacity: 0.9,
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                            color: globalcolor,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 4,
                                offset: Offset(4, 8), // Shadow position
                              ),
                            ],
                              borderRadius: BorderRadius.circular(20)),
                          margin: EdgeInsets.all(5),
                          padding: EdgeInsets.all(5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                child: Text(mydata[i].student_first_name+" "+mydata[i].student_last_name,style: TextStyle(color: Colors.white),)),
                               
                            ],
                          )
                        ),
                      ),
                    );
                  },
                 
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