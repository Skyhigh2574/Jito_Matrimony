import 'package:flutter/material.dart';
import 'package:jito_matrimony/ProviderService.dart';
import 'package:jito_matrimony/utils/MySharedPreferences.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../EditClasses/Basic_add.dart';
import '../homepage.dart';
import 'Family_edit.dart';

class AstroDetails extends StatefulWidget{

  var Astro;
  String flag;
  AstroDetails({this.Astro, this.flag});
  @override
  astroDetail createState() => astroDetail();
}


class astroDetail extends State<AstroDetails>{

  SharedPreferences myPrefs;

  int count = 0;
  String _userid, token, _bioid, _manglik, _horoscope;

  void initState(){

    if(widget.flag == "1") {
      _manglik = widget.Astro.manglik;
      _horoscope = widget.Astro.horoscope;
    }
    initPref();
}


  initPref()
  async {

    myPrefs = await SharedPreferences.getInstance();
    _userid = MySharedPreferences.instance.getStringValue("user_id", myPrefs);
    token = MySharedPreferences.instance.getStringValue("token", myPrefs);
    _bioid = MySharedPreferences.instance.getStringValue("bio_id", myPrefs);
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
                Navigator.of(context).popUntil((_) => count++ >= 8);
              }else{
                Navigator.pop(context);
                Navigator.pop(context);
              }
            },
            child: Text('No', style: TextStyle(color: Colors.deepPurple),),
          ),
          FlatButton(
            onPressed: () async {
              if(widget.flag=="0") {
                setState(() {
                  MySharedPreferences.instance.setStringValue(
                      "manglik", _manglik);
                  MySharedPreferences.instance.setStringValue(
                      "horoscope", _horoscope);
                });
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => FamilyDetails(flag: "0")));
              }
              else{

                await Provider.of<ProviderService>(context, listen: false).addAstro({"user_id":_userid,
                  "token":token,
                  "bio_id":_bioid,
                  "manglik": _manglik,
                  "horoscope": _horoscope,
                }).then((value) => (value.body));
                Navigator.push(context, MaterialPageRoute(builder: (context) => homepage()));
              }

            },
            /*Navigator.of(context).pop(true)*/
            child: Text('Yes', style: TextStyle(color: Colors.deepPurple),),
          ),

        ],
      ),
    ) ?? false;
  }


  @override
  Widget build(BuildContext context) {

    return WillPopScope(  onWillPop: _onWillPop,
    child: Scaffold(
        appBar: AppBar(
        title: Text('Astro Details', style: TextStyle(color: Colors.white, fontSize: 17),),
         actions: <Widget>[
          TextButton(
              onPressed: () async {

              if(widget.flag=="0") {
                setState(() {
                  MySharedPreferences.instance.setStringValue(
                      "manglik", _manglik);
                  MySharedPreferences.instance.setStringValue(
                      "horoscope", _horoscope);
                });
                  Navigator.push(context, MaterialPageRoute(builder: (context) => FamilyDetails(flag: "0")));
              }
              else{

              await Provider.of<ProviderService>(context, listen: false).addAstro({"user_id":_userid,
                "token":token,
                "bio_id":_bioid,
                "manglik": _manglik,
                "horoscope": _horoscope,
              }).then((value) => (value.body));
              Navigator.push(context, MaterialPageRoute(builder: (context) => homepage()));
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
              body: SingleChildScrollView(
                child: GestureDetector(
                  onTap: () {
                    FocusScopeNode currentFocus = FocusScope.of(context);

                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                        },
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                                    alignment: Alignment.centerLeft,
                                    height:35,
                                    width: MediaQuery.of(context).size.width*.96,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[400] ,
                                      border: Border.all(color: Colors.grey[400]),
                                    ),
                                    child: Text('   MANGLIK',
                                      style: TextStyle(fontSize: 15, color: Colors.black),),

                                ),
                                Container(
                                    height: 140,
                                    decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey[400])
                                    ),
                                    child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children:
                                    <Widget> [
                                   ListTile(
                                    visualDensity: VisualDensity(horizontal: 0, vertical: -2),
                                    dense: true,
                                      title: const Text('Manglik', style: TextStyle(fontSize: 17),),
                                      leading: Transform.scale(

                                      scale: 1.5,
                                          child: Radio(

                                          value: "manglik",
                                          groupValue: _manglik,
                                          onChanged: (value){
                                            setState(() {
                                              _manglik = value;
                                              });
                                                },
                                                ),
                                                  )

                                   ),
                                            ListTile(
                                                visualDensity: VisualDensity(horizontal: 0, vertical: -2),
                                                dense: true,
                                            title: const Text('Not Manglik', style: TextStyle(fontSize: 17),),
                                            leading: Transform.scale(

                                            scale: 1.5,
                                            child: Radio(
                                            value: "not manglik",
                                              groupValue: _manglik,
                                              onChanged: (value){
                                              setState(() {
                                                _manglik = value;
                                                });
                                              },
                                            ),
                                          )
                                        ),

                                      ListTile(
                                          visualDensity: VisualDensity(horizontal: 0, vertical: -2),
                                          dense: true,
                                          title: const Text("Don't Know", style: TextStyle(fontSize: 17),),
                                          leading: Transform.scale(

                                            scale: 1.5,
                                            child: Radio(
                                              value: "don't know",
                                              groupValue: _manglik,
                                              onChanged: (value){
                                                setState(() {
                                                  _manglik = value;
                                                });
                                              },
                                            ),
                                          )
                                      ),
                                    ]
                                    ),
                                ),
                                      SizedBox(height: 20,),
                                      Container(
                                        padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                                        alignment: Alignment.centerLeft,
                                        height:35,
                                        width: MediaQuery.of(context).size.width*.96,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[400] ,
                                          border: Border.all(color: Colors.grey[400]),
                                        ),
                                        child: Text('   INTERESTED',
                                          style: TextStyle(fontSize: 15, color: Colors.black),),

                                      ),
                                      Container(
                                          height: 90,
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.grey[400])
                                          ),
                                          child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children:
                                              <Widget> [
                                                Container(
                                                  height: 25,
                                                  child: ListTile(
                                                      visualDensity: VisualDensity(horizontal: 0, vertical: -2),
                                                      dense: true,
                                                      title: const Text('Interested', style: TextStyle(fontSize: 17),),
                                                      leading: Transform.scale(

                                                        scale: 1.5,
                                                        child: Radio(

                                                          value: "interested",
                                                          groupValue: _horoscope,
                                                          onChanged: (value){
                                                            setState(() {
                                                              _horoscope = value;
                                                            });
                                                          },
                                                        ),
                                                      )
                                                  ),
                                                ),
                                                SizedBox(height:15,),
                                                ListTile(
                                                    visualDensity: VisualDensity(horizontal: 0, vertical: -2),
                                                    dense: true,
                                                    title: const Text('Not Interested', style: TextStyle(fontSize: 17),),
                                                    leading: Transform.scale(

                                                      scale: 1.5,
                                                      child: Radio(
                                                        value: "not interested",
                                                        groupValue: _horoscope,
                                                        onChanged: (value){
                                                          setState(() {
                                                            _horoscope = value;
                                                          });
                                                        },
                                                      ),
                                                    )
                                                ),
                        ]
                  )
              ),]
             )
        )
     )
              )
    )
    );
  }

}