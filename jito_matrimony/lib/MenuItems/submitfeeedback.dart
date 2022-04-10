import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jito_matrimony/MenuItems/addfeedback.dart';
import 'package:jito_matrimony/ProviderService.dart';
import 'package:jito_matrimony/utils/MySharedPreferences.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class submitfeedback extends StatefulWidget
{
  @override
  _feedback createState() => _feedback();
}
class _feedback extends State<submitfeedback> {

  String feeddropdownValue = "Feedback";
  TextEditingController _textcontrol = TextEditingController();
  SharedPreferences myPrefs;
  String _userid, no;

  @override
   initState()  {
    // TODO: implement initState
    super.initState();

    initpref();
  }

  initpref()
  async {

    myPrefs = await SharedPreferences.getInstance();
    _userid = MySharedPreferences.instance.getStringValue("user_id", myPrefs);

  }
  submitfeed(addfeedback resp){

    Fluttertoast.showToast(
        msg: "${resp.message}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        centerTitle: true,
        title: Text('Add Feedback ', textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
    ),
      body: Container(


        child:Column(

          children: [
            SizedBox(height: 50,),
            Container(

              height: 50,
              width: MediaQuery.of(context).size.width*.94,
              padding: EdgeInsets.only(left: 10,),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey),
              ),

              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  enabledBorder: InputBorder.none,
                ),
                value: feeddropdownValue,
                icon: Icon(Icons.arrow_drop_down_outlined, size: 25, color: Colors.deepPurple,),
                iconSize: 44,
                elevation: 16,

                onChanged: (newValue) {
                  setState(() {
                    feeddropdownValue = newValue;
                    if(feeddropdownValue == "Feedback"){
                      no = "1";
                    }
                    else if(feeddropdownValue == "Suggestion"){
                      no = "2";
                    }
                    else if(feeddropdownValue == "Complain"){
                      no = "3";
                    }
                  });
                },
                items: <String>["Feedback", 'Suggestion', 'Complain']
                    .map<DropdownMenuItem<String>>((String val) {
                  return DropdownMenuItem<String>(
                    value: val,
                    child: Text(val),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 10,),
            Container(
              height: 150,
              padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 7.0),
              alignment: Alignment.topCenter,
              width: MediaQuery.of(context).size.width*.94,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[350]),
                color: Colors.white,
              ),
              child: TextFormField(
                //initialValue: widget.Family.fatherOfficeAddress==null? "": widget.Family.fatherOfficeAddress,
                textAlignVertical: TextAlignVertical.center,
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                style: TextStyle(fontSize: 16),
                cursorColor: Colors.black,
                decoration: InputDecoration(

                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none
                ),
                controller: _textcontrol,

              ),
            ),
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.grey[700],
                  ),
                child: TextButton(
                  child: const Text(' Reset  ', style: TextStyle(color: Colors.white),),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),),

                Container(
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.deepPurple,
                  ),
                  child: TextButton(
                    child: const Text(' Save  ',style: TextStyle(color: Colors.white )),
                    onPressed: () async {
                      await Provider.of<ProviderService>(context, listen: false).feedbackadd({'user_id': _userid, "feedback_type": no, "feedback": _textcontrol.text}).then((value) => submitfeed(value.body));
                      Navigator.of(context).pop();
                    },
                  ),),

              ],
            )

          ],
        )

    ),
    );
    }
}