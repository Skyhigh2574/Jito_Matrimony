import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jito_matrimony/EditActivity/Astro_edit.dart';
import 'package:jito_matrimony/EditActivity/Basic_edit.dart';
import 'package:jito_matrimony/Edit_Biodata.dart';
import 'package:jito_matrimony/utils/MySharedPreferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ViewBiodata.dart';

class ManageBio extends StatefulWidget{

  String flag;
  ManageBio({this.flag});
  @override
  managing_bio createState() => managing_bio();
}

class managing_bio extends State<ManageBio>{

  SharedPreferences myPrefs;
  String _bioid, _profid, _username, _img;

  @override
  void initState() {

    super.initState();

    if(widget.flag=="1"){
      print(widget.flag);
      initPref();
    }

  }

  initPref() async {
    myPrefs = await SharedPreferences.getInstance();
    setState(() {
      _bioid = MySharedPreferences.instance.getStringValue("bio_id", myPrefs);
      _username = MySharedPreferences.instance.getStringValue("user_name", myPrefs);
      _profid =MySharedPreferences.instance.getStringValue("prof_id", myPrefs);
      _img= MySharedPreferences.instance.getStringValue("img_1", myPrefs);
    });
    print("$_bioid, $_username, $_profid");

    print("_img   $_img");

  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text('Manage Biodata', style: TextStyle(fontSize: 20, color: Colors.white),),
      ),
      body: widget.flag == "1" ? Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

           Ink(

              color: Colors.grey[400],
            child: ListTile(
              dense: true,
                title: new Text('CREATED BIODATA', style: TextStyle(color: Colors.deepPurple, fontSize: 15),),

        ),
            ),

          GestureDetector(

            onTap:(){
              if(_bioid != null) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Edit_Biodata(flag: "1")));
              }
              else{
                Navigator.push(context, MaterialPageRoute(builder: (context) => Edit_Biodata(flag: "0")));
              }
            } ,
              child: Container(
            width: MediaQuery.of(context).size.width*.98,
            height: MediaQuery.of(context).size.height/6.2,
            child: Card(

              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: _img== "" ? AssetImage('Assets/boy.png') : new NetworkImage('$_img'),
                      )
                  ),
                ),
                  ),
              SizedBox(width: 10,),

              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Expanded(flex:2, child: Text('${_username.toUpperCase()}', style: TextStyle(fontSize: 22), ),),
                    SizedBox(height: 10,),
                    Expanded(flex:1, child: Text('Profile Id: ${_profid}', style: TextStyle(fontSize: 17),),),
                    SizedBox(height: 10,),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Edit Biodata', style: TextStyle(color: Colors.red, decoration: TextDecoration.underline),),
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ViewBiodata(profid : _profid)));
                            },
                            child: Text('View Biodata', style: TextStyle(color: Colors.red, decoration: TextDecoration.underline)),
                    ),
                        ],
                      ),
                    )
                ],
              ),
            ),
                  Expanded(
                    flex: 1,
                      child: Icon(Icons.arrow_forward_ios_sharp)
                  ),
          ],
        )
      ),
          ),
          )
        ]
    )
    ): Container(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            GestureDetector(

                onTap:(){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => BasicDetails(Basic: null,flag: "0")));
                } ,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/6,

                  decoration: BoxDecoration(
                    color: Colors.deepOrangeAccent,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Click Here To', style: TextStyle(fontSize: 15, color: Colors.white),),
                      Text('ADD BIODATA', style: TextStyle(fontSize: 20, color: Colors.white),),
                    ],
                  ),
                )
            ),

            Ink(
            color: Colors.grey[400],
              child: ListTile(
                dense: true,
                title: new Text('NO BIODATA FOUND', style: TextStyle(color: Colors.deepPurple, fontSize: 15),),

          ),
            ),
         ]
        )
      )
    );


  }


}