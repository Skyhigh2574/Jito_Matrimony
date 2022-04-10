import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jito_matrimony/Search/search.dart';
import 'package:jito_matrimony/Widgets/rows.dart';
import 'package:provider/provider.dart';
import '../ProviderService.dart';
import 'ViewSearchedBio.dart';


class showBiolist extends StatefulWidget{

  var biolist;
  String gender;
  String sex, aMin, aMax, hMin, hMax, maritaldropdownValue, tonguedropdownValue, manglik, jaindropdownValue, livingstatus, disability, idcontroller, profilecontroller;

  showBiolist({this.biolist, this.gender, this.sex, this.aMin, this.aMax, this.hMin, this.hMax, this.maritaldropdownValue, this.tonguedropdownValue, this.manglik, this.jaindropdownValue, this.livingstatus, this.disability, this.idcontroller, profilecontroller});

  @override
  showBio createState() => showBio(this.biolist, this.sex, this.aMin, this.aMax, this.hMin, this.hMax, this.maritaldropdownValue, this.tonguedropdownValue, this.manglik, this.jaindropdownValue, this.livingstatus, this.disability, this.idcontroller, profilecontroller);
}

class showBio extends State<showBiolist>{

  int i = 2;
  int x = 0;
  var biolist;
  int get count => widget.biolist.datainfo.length;
  String sex, aMin, aMax, hMin, hMax, maritaldropdownValue, tonguedropdownValue, manglik, jaindropdownValue, livingstatus, disability, idcontroller, profilecontroller;

  showBio(this.biolist, this.sex, this.aMin, this.aMax, this.hMin, this.hMax, this.maritaldropdownValue, this.tonguedropdownValue, this.manglik, this.jaindropdownValue, this.livingstatus, this.disability, this.idcontroller, profilecontroller);


  @override
  void initState() {
    super.initState();
    initpref();

  }

  initpref() async {
    x= x + 20;
    await Provider.of<ProviderService>(context, listen: false).getsearchlist({
      "user_id":"5869",
      "categoty":"",
      "gender":this.sex,
      "min_age":widget.aMin,
      "max_age":aMax,
      "min_height":hMin,
      "max_height":hMax,
      "merital_status":maritaldropdownValue,
      "mother_tongue":tonguedropdownValue,
      "manglic":"",
      "education":"",
      "state":"",
      "jain_sampradaya":jaindropdownValue,
      "city":"",
      "leaving_status":livingstatus,
      "physical_disability": disability,
      "profile_id": idcontroller,
      "profile_name": profilecontroller,
      "pagination" : i,
    }).then((value) => Navsearch(value.body));
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('BIODATA OF ${widget.gender}'),
        actions:<Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [

              Text('${biolist.fltCnt} / ${biolist.totCnt}     '),
            ],
          ),


        ]
      ),
      body: Container(
          color: Colors.grey[200],
          margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5),

            child: Container(
              color: Colors.grey[200],

                child: ListView.builder(

                  padding: EdgeInsets.only(bottom:10, top: 2 ),
                  itemCount: x < (int.parse(widget.biolist.totCnt) -20) ? x + 1 : x,
                  itemBuilder: (context, index) {
                    print("index  ==  $index");
                    print("xx=   $x");
                  return ((index + 1) <=  x ) ? GestureDetector(

                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>ViewSearchedBio(profid: widget.biolist.datainfo[index].profileId)));
                    },
                    child: Container(
                      padding: EdgeInsets.only( bottom: 7),

                    child: Row(
                      children: [
                        Container(

                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white
                        ),
                        width: MediaQuery.of(context).size.width*.97,
                        height: 100,
                      child: Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              flex: 2,
                              child:Container(
                                height: 80,

                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage( biolist.datainfo[index].img1),
                                    fit: BoxFit.contain,
                                  )
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child: Container(

                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                    children: [

                                      rows2('${widget.biolist.datainfo[index].name}','$index'),

                                      rows3('${widget.biolist.datainfo[index].age}, ${widget.biolist.datainfo[index].height}', 'ID - ${widget.biolist.datainfo[index].profileId}'),

                                      rows3("${widget.biolist.datainfo[index].motherToungue}, ${widget.biolist.datainfo[index].jainSampradaya}", ''),



                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                    children: <Widget>[
                                      Container(

                                          child: Align(
                                            alignment: Alignment.topLeft,
                                            child: (widget.biolist.datainfo[index].img2 != null && widget.biolist.datainfo[index].img1 !=null) ? widget.biolist.datainfo[index].img3 != null ? Text(' 3 Photos', style: TextStyle(fontSize: 12.0, color: Colors.red),) : Text(' 2 Photos', style: TextStyle(fontSize: 12.0, color: Colors.red),) : Text(' ')
                                          )
                                      ),

                                      Container(

                                          child: Align(
                                            alignment: Alignment.bottomLeft,
                                            child: Text("${widget.biolist.datainfo[index].city}, ${widget.biolist.datainfo[index].state}", style: TextStyle(fontSize: 15.0),

                                        )
                                      ),
                                          )
                                    ]
                                ),

                                    ],
                                )
                              )
                            ),
                        ],
                            )

                          )
                        )
  //
                      ]
                    ),

                  )
                  )
                      :  Container(
                        color: Colors.grey,
                        child: FlatButton(
                          child: Text("Click Here to Load More", style: TextStyle(color: Colors.red),),
                          onPressed: () {
                            setState(() {
                              i=i+1;

                          print("x  -=== $x");
                          initpref();
                        });
          },
        ),
      );
    }
    )
            )
      )
    );
  }

  Navsearch(search response){
    print("bioiodaata lenghtt ==  ${biolist.datainfo.length}");

    for(int j=0;j<20;j++){
      this.biolist.datainfo.add(response.datainfo[j]);
    }

  }
  @override
  void dispose() {

    super.dispose();

  }
}