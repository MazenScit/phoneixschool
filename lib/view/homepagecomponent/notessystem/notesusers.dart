import 'package:flutter/material.dart';
import 'package:phoenixschool/authentication/studentlist.dart';
import 'package:phoenixschool/component/Color.dart';
import 'package:phoenixschool/view/footer.dart';
import 'package:phoenixschool/view/homepagecomponent/notessystem/addnewnote.dart';
import 'package:phoenixschool/view/homepagecomponent/notessystem/shownotesbyperson.dart';


class NotesByPerson extends StatefulWidget {
  const NotesByPerson({super.key});

  @override
  State<NotesByPerson> createState() => _NotesByPersonState();
}

class _NotesByPersonState extends State<NotesByPerson> {
  @override
  Widget build(BuildContext context) {
    var height= MediaQuery.of(context).size.height;
    return Scaffold(
      bottomNavigationBar: Footer(),
      
      body: Container(
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
                    InkWell(
                      onTap: () {
                         Navigator.push(context,
                             MaterialPageRoute(builder: (BuildContext context) {
                             return ShowNotesByPerson();
                            }));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: globalcolor,
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                            ),
                        
                        height: height/13,
                      margin: EdgeInsets.only(left: 10,right: 10,bottom: 10),
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          
                            
                           Text(mydata[index].student_first_name+" "+mydata[index].student_last_name,style: TextStyle(color: Colors.white),),
                           Container(
                                alignment: Alignment.center,
                                height: 100,
                                child: Image.asset('assets/icon/notes.png')),
                        ],
                      ),
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