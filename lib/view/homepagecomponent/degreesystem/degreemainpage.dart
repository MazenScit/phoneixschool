import 'package:flutter/material.dart';
import 'package:phoenixschool/authentication/studentlist.dart';
import 'package:phoenixschool/component/Color.dart';
import 'package:phoenixschool/view/footer.dart';
import 'package:phoenixschool/view/homepagecomponent/degreesystem/showdegreebyperson.dart';


class DegreeMainPage extends StatefulWidget {
  const DegreeMainPage({super.key});

  @override
  State<DegreeMainPage> createState() => _DegreeMainPageState();
}
bool isloading=false;
class _DegreeMainPageState extends State<DegreeMainPage> {
  @override
  Widget build(BuildContext context) {
    var height= MediaQuery.of(context).size.height;
    return Scaffold(
      bottomNavigationBar: Footer(),
      appBar: AppBar(
        backgroundColor: globalcolor,
        elevation: 0,
        title: Text("العلامات"),
      ),
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
                             return NotesByPerson( value_user_id:mydata[index].student_card_id,name:mydata[index].student_first_name+" "+mydata[index].student_last_name);
                            }));
                        
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: globalcolor,
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                            ),
                        
                        height: height/11,
                        padding: EdgeInsets.symmetric(horizontal: 30),
                      margin: EdgeInsets.only(left: 10,right: 10,bottom: 10),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          
                            
                           Text(mydata[index].student_first_name+" "+mydata[index].student_last_name,style: TextStyle(color: Colors.white),),
                           Container(
                            padding: EdgeInsets.all(3),
                                  alignment: Alignment.center,
                                  height: 100,
                                  child: Image.asset('assets/icon/degree.png')),
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