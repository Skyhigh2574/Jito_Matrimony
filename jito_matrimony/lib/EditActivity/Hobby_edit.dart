import 'package:flutter/material.dart';
import 'package:jito_matrimony/EditActivity/Hobbies_list.dart';
import 'package:jito_matrimony/EditClasses/hobbiesadd.dart';
import 'package:jito_matrimony/ProviderService.dart';
import 'package:jito_matrimony/Widgets/rows.dart';
import 'package:jito_matrimony/utils/MySharedPreferences.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../EditClasses/Basic_add.dart';
import '../homepage.dart';
import 'Astro_edit.dart';

class HobbyDetails extends StatefulWidget{

  var Hobby;
  String flag;
  HobbyDetails({this.Hobby, this.flag});
  @override
  hobbyDetail createState() => hobbyDetail();
}


class hobbyDetail extends State<HobbyDetails>{


  var selectedChoices;
  var _options;
  SharedPreferences myPrefs;
  String _userid, token, _bioid;
  List<String> namehobby = [];
  String choiced = '              ';
  bool isLoading = true;
  int count = 0;


  void initState(){

    super.initState();
    setState(() {
      isLoading = true;
    });
    print("startdoof");

    initPref();

      setState(() {
        selectedChoices = widget.Hobby;
        if(widget.flag == "1") {
          for (int k = 0; k < widget.Hobby.length; k++) {
            namehobby.add(selectedChoices[k].hobbiesName);
          }
          choiced = namehobby.join(', ');
          print("enddoff");
        }
      });

  }


  initPref() async {

    setState(() {
      isLoading= true;
    });
    await Provider.of<ProviderService>(context, listen : false).getHobbies({}).then((value) => getlist(value.body));

    myPrefs = await SharedPreferences.getInstance();
    _userid = MySharedPreferences.instance.getStringValue("user_id", myPrefs);
    token = MySharedPreferences.instance.getStringValue("token", myPrefs);
    _bioid = MySharedPreferences.instance.getStringValue("bio_id", myPrefs);
    print("bioid id here $_bioid");
  }

  getlist(Hobbies_list resp){

    print("in gertr lisytt");

    setState(() {

      _options = resp.datainfo;
      isLoading = false;

    });

  }

  Future<bool> _onWillPop() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Save Changes?'),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Cancel', style: TextStyle(color: Colors.deepPurple),),
          ),
          SizedBox(
            width: 50,
          ),
          FlatButton(
            onPressed: () {
              if(widget.flag == "0"){
                Navigator.of(context).popUntil((_) => count++ >= 7);
              }else{
                Navigator.pop(context);
                Navigator.pop(context);
              }
            },
            child: Text('No', style: TextStyle(color: Colors.deepPurple),),
          ),
          FlatButton(
            onPressed: () async {

              if(widget.flag == "0") {
                setState(() {
                  MySharedPreferences.instance.setStringValue(
                      "hobbies", choiced);
                });
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => AstroDetails(flag: "0")));
              }
                else{
                  await Provider.of<ProviderService>(context, listen: false).addHobbies({"user_id":_userid,
                "token":token,
                "bio_id":_bioid,
                "hobbies": "$choiced",
                }).then((value) => addingHobs(value.body));

                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => homepage()), (route) => false);
                }

            },
            /*Navigator.of(context).pop(true)*/
            child: Text('Yes', style: TextStyle(color: Colors.deepPurple),),
          ),

        ],
      ),
    ) ?? false;
  }


  _Chips() {
    List<Widget> chips = new List();

    for (int i = 0; i < 34; i++) {

      ChoiceChip choiceChip = ChoiceChip(

        selected: namehobby.contains(_options[i].hobbiesName),
        label: Text('${_options[i].hobbiesName}', style: TextStyle(color: Colors.green)),
        shape: StadiumBorder(side: BorderSide(color: Colors.green)),
        elevation: 10,

        visualDensity: VisualDensity.compact,
        pressElevation: 5,
        shadowColor: Colors.teal,
        backgroundColor: Colors.white,
        selectedColor: Colors.blue,
        // onSelected: (bool selected) {
        //   setState(() {
        //     if (selected) {
        //       _selectedIndex = i;
        //     }
        //   });
        onSelected: (selected) {
          setState(() {
            if(namehobby.contains(_options[i].hobbiesName))
              {
                namehobby.remove(_options[i].hobbiesName);
              }
            else {
              namehobby.add(_options[i].hobbiesName);
            }// +ad
              countHobbies();
          });
        },

      );

      chips.add(Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: choiceChip
      ));
    }

    return chips;
  }

  Widget _buildchips() {
    return Wrap(
      children: _Chips(),
    );
  }

  addingHobs(hobbiesadd resp){
    print(resp.message);
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(  onWillPop: _onWillPop,
    child: Scaffold(
        appBar: AppBar(
            title: Text('Hobbies', style: TextStyle(color: Colors.white, fontSize: 17),),
            actions: <Widget>[
              TextButton(
                onPressed: () async {

                  if(widget.flag == "0") {
                    setState(() {
                      MySharedPreferences.instance.setStringValue(
                          "hobbies", choiced);
                    });

                    Navigator.push(context, MaterialPageRoute(builder: (context) => AstroDetails(flag: "0")));
                  }
                  else{
                    await Provider.of<ProviderService>(context, listen: false).addHobbies({"user_id":_userid,
                      "token":token,
                      "bio_id":_bioid,
                      "hobbies": "$choiced",
                    }).then((value) => addingHobs(value.body));

                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => homepage()), (route) => false);
                  }
                },

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    VerticalDivider(thickness: 1.0, color: Colors.white,),
                    Icon(Icons.check, color: Colors.white),
                    SizedBox(width: 5,),
                    Text('SAVE  ', style: TextStyle(color: Colors.white, fontSize: 15))
                  ],
                ),
              ),

            ]
        ),
        body: isLoading ? Center(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:[

                  CircularProgressIndicator() ,

                  SizedBox(width:20.0),

                  new Text("Please Wait", style:TextStyle(fontSize: 30, color: Colors.deepPurple)),

                ]
            )
        ) : Padding(
            padding: const EdgeInsets.all(15.0),
              child: Container(
                child: Column(

                  children : [
                    Container
                      (
                        padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                        alignment: Alignment.centerLeft,
                        height:35,
                        width: MediaQuery.of(context).size.width*.96,

                        decoration: BoxDecoration(
                            color: Colors.grey[400] ,
                            border: Border.all(color: Colors.grey[400]),
                        ),
                          child: Text(' HOBBIES',
                            style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey)
                      ),
                        child: Wrap(
                          spacing:5.0,
                          children: [
                            Text(' $choiced'),
                      ],
                      ),
                    ),
                    Expanded(

                      child: _buildchips(),
                    ),

               ] )
             )
        )
    )
    );
  }

  countHobbies()
  {
    setState(() {
      choiced= namehobby.join(', ');
    });

  }
}