import 'dart:io';

import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import 'package:phoenixschool/authentication/studentlist.dart';
import 'package:phoenixschool/component/Color.dart';
import 'package:phoenixschool/view/footer.dart';

import 'showfilesbyperson.dart';

class FilesManaging extends StatefulWidget {
  const FilesManaging({super.key});

  @override
  State<FilesManaging> createState() => _FilesManagingState();
}

class _FilesManagingState extends State<FilesManaging> {
  @override
  Widget build(BuildContext context) {
    var height= MediaQuery.of(context).size.height;
    return Scaffold(
      bottomNavigationBar: Footer(),
      appBar: AppBar(
        backgroundColor: globalcolor,
        elevation: 0,
        title: Text("الملفات"),
      ),
      body: Container(
        height: height,
       
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20,),
              Container(
                height: height-170,
                child: ListView.builder(
                  itemCount: mydata.length,
                  itemBuilder: (context, index) {
                    return 
                    Container(
                      decoration: BoxDecoration(
                        color: globalcolor,
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                      
                      height: height/9,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                    margin: EdgeInsets.only(left: 10,right: 10,bottom: 10),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 50,
                          child: Image.asset('assets/icon/file.png')),
                          
                         Text(mydata[index].student_first_name+' '+mydata[index].student_last_name,style: TextStyle(color: Colors.white),),
                        ElevatedButton(
                          
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.white),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  
                                  borderRadius: BorderRadius.circular(18.0),
                                )
                              ),
                            ),
                          child: Text("اظهر الملفات",style: TextStyle(color:globalcolor),),
                          onPressed: () async {
                             Navigator.push(context,
                             MaterialPageRoute(builder: (BuildContext context) {
                             return ShowFileByPerson(student_card_id:mydata[index].student_card_id,name:mydata[index].student_first_name+" "+mydata[index].student_last_name);
                            }));
                         
                        },)
                      ],
                    ),
                    );
                  },),
              )
            ],
          ),
        ),
      ),
    );
  }
}