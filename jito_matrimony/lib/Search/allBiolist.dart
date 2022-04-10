import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jito_matrimony/Search/search.dart';
import 'package:jito_matrimony/Widgets/rows.dart';
import 'package:jito_matrimony/filter.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:loadmore/loadmore.dart';
import 'package:provider/provider.dart';

import '../ProviderService.dart';
import 'ViewSearchedBio.dart';


class allBiolist extends StatefulWidget{

  var biolist;
  String gender, sex;
  allBiolist({this.biolist, this.gender, this.sex});

  @override
  allBio createState() => allBio({this.biolist});
}
class allBio extends State<allBiolist>{

  var biolist;
  int get count => widget.biolist.datainfo.length;
  allBio(this.biolist);

  int i = 2;
  int x = 0;

  bool isLoading = false;

  void initState(){
    super.initState();
    initpref();
    print("jeeloooooo");
  }

  initpref() async {
    x= x + 20;
    await Provider.of<ProviderService>(context, listen: false).getsearchlist({
      "user_id":"5869",
      "categoty":"",
      "gender":widget.sex,
      "pagination" : i,
    }).then((value) => Navsearch(value.body));
    setState(() {
      isLoading = false;
      i=i+1;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
            titleSpacing:1,
            title: Text('BIODATA OF ${widget.gender}', style: TextStyle( fontSize: 18)),
            actions:<Widget>[

         Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('${widget.biolist.fltCnt} / ${widget.biolist.totCnt}'),
              VerticalDivider(color: Colors.white, thickness: 1, indent: 5, endIndent: 5,),
              Container(
                height: 70,
                width: 60,
                child:TextButton(
                onPressed: () async {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => filterPage()));
                },

                   // Icon(Icons.line, color: Colors.white),
                    child: Text('Filter', style: TextStyle(color: Colors.white, fontSize: 17),)

                ),
              )
      ]
              ),
            ]
        ),
        body: Center(child: Container(
          height: MediaQuery.of(context).size.height*.88,
          width: MediaQuery.of(context).size.width*.97,
          alignment: Alignment.center,


            child: NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollInfo) {
            if (!isLoading && scrollInfo.metrics.pixels ==
                scrollInfo.metrics.maxScrollExtent) {
                  initpref();

            setState(() {
                isLoading = true;
            });
            }
    },

            child: ListView.builder(

              scrollDirection: Axis.horizontal,
              itemCount: x < (int.parse(widget.biolist.totCnt) -20) ? x + 1 : x,
              itemBuilder: (context, index) {
                int ind = index+1;
                return GestureDetector(

                    onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>ViewSearchedBio(profid: widget.biolist.datainfo[index].profileId)));
                },child:
                Container(
                  padding: EdgeInsets.fromLTRB(2.0, 5.0, 2.0, 5.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(2.0),
                  ),

                  width: MediaQuery.of(context).size.width * .97,
                  height: MediaQuery.of(context).size.height * .8,
                  child: Column(

                      children: <Widget>[
                        Expanded(
                          flex: 3,
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage('${widget.biolist
                                    .datainfo[index].img1}'),
                              )
                          ),
                        ),
                        ),
                        SizedBox(height: 5.0,),
                        Container(

                          child: Text('${widget.biolist.datainfo[index].name}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                        ),
                        SizedBox(height: 3.0,),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              Text('${widget.biolist.datainfo[index].age}, '),
                              Text('${widget.biolist.datainfo[index].height}, '),
                              Text('${widget.biolist.datainfo[index].motherToungue}, '),
                              Text('${widget.biolist.datainfo[index].jainSampradaya}'),

                            ]),
                        SizedBox(height: 3.0,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('${widget.biolist.datainfo[index].city}, '),
                            Text('${widget.biolist.datainfo[index].state}'),

                          ],
                        ),
                        SizedBox(height: 3.0,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Profile ID : ${widget.biolist.datainfo[index].profileId}, ', style: TextStyle(color: Colors.red),),
                            (widget.biolist.datainfo[index].img2 != null &&
                                widget.biolist.datainfo[index].img1 != null)
                                ? widget.biolist.datainfo[index].img3 != null
                                ? Text('3  Photos',
                              style: TextStyle(fontSize: 12.0, color: Colors
                                  .red),)
                                : Text('2  Photos',
                              style: TextStyle(fontSize: 12.0, color: Colors
                                  .red),)
                                : Text(' ')
                          ],
                        ),
                        SizedBox(height: 3.0,),
                        Container(
                          width: 40,
                          height: 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            border: Border.all(
                                color: Colors.red
                            ),

                          ),
                          alignment: Alignment.center,
                          child: Text('${ind}', style: TextStyle(color: Colors.red),),
                        ),
                         Expanded(
                             flex:1,
                             child:  Container(width: 150,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('Assets/temp_biodata.png'),
                              )
                            )
                          )
                         )
                      ]
                  ),
                )
              );

                },

    ),
        )
        )

        ),
    );
  }


  Navsearch(search response){

  print("WHi sayss");
  for(int j=0;j<20;j++){
    widget.biolist.datainfo.add(response.datainfo[j]);
  }

  }
  @override
  void dispose() {

    super.dispose();

  }

}