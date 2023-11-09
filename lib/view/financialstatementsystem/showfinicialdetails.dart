import 'package:flutter/material.dart';
import 'package:phoenixschool/component/Color.dart';
import 'package:phoenixschool/controller/finicaial_controler.dart';
import 'package:phoenixschool/view/footer.dart';

import '../../model/fnicialstatemnetmodel.dart';

class ShowFiniacialdetails extends StatefulWidget {
  final String startdate;
  final String enddate;
  final String value_user_id;
  const ShowFiniacialdetails({super.key, required this.startdate, required this.enddate, required this.value_user_id});

  @override
  State<ShowFiniacialdetails> createState() => _ShowFiniacialdetailsState();
}
late List <FinicailaModel> myfinicial;
bool isloading=false;
bool nullstatement=false;
Financial_Controller _financial_controller=Financial_Controller();

class _ShowFiniacialdetailsState extends State<ShowFiniacialdetails> {
  @override
  void initState() {
    _financial_controller.getfinicialstatement(widget.startdate,widget.enddate,widget.value_user_id).then((value) {
      myfinicial=value!;
      setState(() {
        nullstatement=false;
        isloading=true;
      });
    },).onError((error, stackTrace){
                                    setState(() {
                                            nullstatement=true;
                                            });
                                  });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Footer(),
      appBar: AppBar(
        backgroundColor: globalcolor,
        elevation: 0,
        title: Text("الاستحقاقات المالية"),
      ),
      body: 
      !nullstatement?
      isloading?
      Container(
        height: 500,
        child: ListView.builder(
          itemCount: myfinicial.length,
          itemBuilder: (context, index) {
            
          return Opacity(
            opacity: 0.8,
            child: Container(
              margin: EdgeInsets.all(20),
              color: Colors.lightBlue,
              padding: EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(myfinicial[index].order_item),
                              Text(":النوع"),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(myfinicial[index].order_date),
                              Text(":التاريخ"),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(myfinicial[index].order_price),
                              Text(":السعر"),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(myfinicial[index].order_quantity),
                              Text(":العدد"),
                            ],
                          ),
                        ),

                         Container(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(myfinicial[index].order_total),
                              Text(":المجموع الكلي للسعر"),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(myfinicial[index].remain_balance),
                              Text(":الرصيد المتبقي في البطاقة"),
                            ],
                          ),
                        ),
                        
                  ],
                ),
              ),
            ),
          );
          }
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
                           _financial_controller.getfinicialstatement(widget.startdate,widget.enddate,widget.value_user_id).then((value) {
                              myfinicial=value!;
                              setState(() {
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

    );
  }
}