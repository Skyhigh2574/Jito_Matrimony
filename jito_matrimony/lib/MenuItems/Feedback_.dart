import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jito_matrimony/MenuItems/submitfeeedback.dart';
import 'package:jito_matrimony/ProviderService.dart';
import 'package:provider/provider.dart';

import 'feedbacklist.dart';

class Feedback_ extends StatefulWidget
{
  @override
  feedback createState() => feedback();
}
class feedback extends State<Feedback_> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initpref();

  }

  initpref() async{
    await Provider.of<ProviderService>(context, listen: false).getfeedback({}).then((value) => toastfeedback(value.body));
  }

  toastfeedback(feedbacklist resp){

    Fluttertoast.showToast(
        msg: "${resp.message}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text('Feedback', textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white)),
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add your onPressed code here!
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => submitfeedback()));
        },
        label: const Text('Add Feedback', style: TextStyle(color: Colors.white)),
        icon: const Icon(Icons.add, color: Colors.white,),
        backgroundColor: Colors.deepPurple,
      ),

    );
  }
}