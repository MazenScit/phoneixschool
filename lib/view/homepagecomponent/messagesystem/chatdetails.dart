import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:phoenixschool/component/Color.dart';
import 'package:phoenixschool/controller/message_controller.dart';
import 'package:phoenixschool/model/message_model.dart';
import 'package:phoenixschool/view/footer.dart';
import 'package:phoenixschool/view/homepagecomponent/homepage.dart';
import 'package:phoenixschool/view/homepagecomponent/messagesystem/replaytomessage.dart';

class ChatDetails extends StatefulWidget {
  final String student_card_id;
  final String username;
  const ChatDetails({super.key, required this.student_card_id, required this.username});

  @override
  State<ChatDetails> createState() => _ChatDetailsState();
}
TextEditingController myreplay=TextEditingController();
bool nullstatement=false;
bool isloading=false;
ScrollController _scrollController = new ScrollController();
class _ChatDetailsState extends State<ChatDetails> {
  

   List <Bubble> data=[];

      bool isloading=false;        
  static const styleSomebody = BubbleStyle(
    nip: BubbleNip.rightCenter,
    color: Color.fromARGB(255, 206, 200, 200),
    borderColor: Colors.blue,
    borderWidth: 1,
    elevation: 4,
    margin: BubbleEdges.only(top: 8, right: 50),
    alignment: Alignment.topLeft,
  );

  // static const styleMe = BubbleStyle(
  //   nip: BubbleNip.rightCenter,
  //   color: Color.fromARGB(255, 225, 255, 199),
  //   borderColor: Colors.blue,
  //   borderWidth: 1,
  //   elevation: 4,
  //   margin: BubbleEdges.only(top: 8, left: 50),
  //   alignment: Alignment.topRight,
  // );
  @override
  void initState() {
    
    nullstatement=false;
    getmessages().whenComplete((){
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
        title: Text(widget.username),
      ),
    backgroundColor:Colors.white,
        
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                !nullstatement?
                isloading?
                Container(
                  height: height-150,
                  child: ListView.builder(
                    reverse: true,
                    controller: _scrollController,
                    padding: const EdgeInsets.all(8),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      print((data.length-index-1));
                      print(index);
                      return data[data.length-index-1];
                    },
                  ),
                ): 
                
                Center(child: CircularProgressIndicator()):Container(
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
                          getmessages().whenComplete((){
                            setState(() {
                            isloading=true;
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
late List <MessageModel> mymessages;
Message_Controller message_controller=Message_Controller();
  getmessages() async {
    await message_controller.getmessages(4,widget.student_card_id).then((value) {
      mymessages=value!;

    },).onError((error, stackTrace) {
      print("+++++++++++++++++++++++++++++++++++++++$error");
        setState(() {
        nullstatement=true;
        });
    });

  for (var i = 0; i < mymessages.length; i++) {
    data.add(Bubble(
                style: styleSomebody,
                margin: const BubbleEdges.only(top: 4),
                showNip: false,
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                             MaterialPageRoute(builder: (BuildContext context) {
                             return ReplayToMessage(body: mymessages[(mymessages.length-1)-i].message_body, id: mymessages[(mymessages.length-1)-i].message_id,
                              replies: mymessages[(mymessages.length-1)-i].replies ?? [], addvisor_id: mymessages[(mymessages.length-1)-i].sender_type_id ?? "2");
                            }));
                    
                  },
                  child: Column(
                    children: [
                      Text(mymessages[(mymessages.length-1)-i].message_title,style: TextStyle(color: Colors.green,fontSize: 20),),
                    
                      Text(mymessages[(mymessages.length-1)-i].message_body,textAlign: TextAlign.right,),
                      
                              
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(mymessages[(mymessages.length-1)-i].message_status,style: TextStyle(color: Colors.green,fontSize: 10),),
                           
                          Text(mymessages[(mymessages.length-1)-i].message_send_date,textAlign: TextAlign.right,),
                
                
                        ],
                      ),
                    ],
                  ),
                ),
              ),);
  }
  }
}