
import 'package:flutter/material.dart';
import 'package:phoenixschool/component/Color.dart';
import 'package:phoenixschool/model/message_model.dart';
import 'package:phoenixschool/view/footer.dart';

class SowOcaassionDetails extends StatefulWidget {
  final MessageModel myoccassion;
  const SowOcaassionDetails({super.key, required this.myoccassion});

  @override
  State<SowOcaassionDetails> createState() => _SowOcaassionDetailsState();
}

class _SowOcaassionDetailsState extends State<SowOcaassionDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Footer(),
      appBar: AppBar(
        backgroundColor: globalcolor,
        elevation: 0,
        title: Text(widget.myoccassion.message_title),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 100,),
              Center(
                child: Opacity(
                  opacity: 0.8,
                  child: Container(
                    color: globalcolor,
                                    margin: EdgeInsets.symmetric(horizontal: 30),
                                    padding: EdgeInsets.all( 30),
                                    alignment: Alignment.center,
                                    child: Column(
                                      children: [
                                        Text(widget.myoccassion.message_body,style: TextStyle(color: Colors.white),textAlign: TextAlign.center,),
                                     
                                      SelectableText(widget.myoccassion.message_links,style: TextStyle(color: Colors.white),textAlign: TextAlign.center,),
                                     
                                      ],
                                    )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


