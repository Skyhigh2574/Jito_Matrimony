import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget rows( String t1, String t2) {
  return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(

            child: Align(
              alignment: Alignment.topLeft,
              child: Text(' $t1'.toUpperCase(), style: TextStyle(fontSize: 15.0,),),
            )
        ),

        //       SizedBox(width: 5.0, height: 20.0,
        //       child: Align(
        //           alignment: Alignment.topLeft,
        //           child: Text(': ')),
        // ),
        //SizedBox(width: 1.0,, height: 2.0,),
        Container(

            child: Align(
              alignment: Alignment.bottomLeft,
              child: t2 != null ? Text('$t2 '.toUpperCase(), style: TextStyle(fontSize: 15.0)) : Text('- '),
            )

        ),
      ]
  );
}

Widget rows2( String t1, String t2) {
  return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(

            child: Align(
              alignment: Alignment.topLeft,
              child: Text(' $t1', style: TextStyle(fontSize: 16.0,),),
            )
        ),

        //       SizedBox(width: 5.0, height: 20.0,
        //       child: Align(
        //           alignment: Alignment.topLeft,
        //           child: Text(': ')),
        // ),
        //SizedBox(width: 1.0,, height: 2.0,),
        Container(

            child: Align(
              alignment: Alignment.bottomLeft,
              child: t2 != null ? Text('$t2 ', style: TextStyle(fontSize: 15.0)) : Text('- '),
            )

        ),
      ]
  );
}

Widget rows3( String t1, String t2) {
  return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: <Widget>[
        Container(

            child: Align(
              alignment: Alignment.topLeft,
              child: Text(' $t1', style: TextStyle(fontSize: 12.0,),),
            )
        ),

        //       SizedBox(width: 5.0, height: 20.0,
        //       child: Align(
        //           alignment: Alignment.topLeft,
        //           child: Text(': ')),
        // ),
        //SizedBox(width: 1.0,, height: 2.0,),
        Container(

            child: Align(
              alignment: Alignment.bottomLeft,
              child: t2 != null ? Text('$t2 ', style: TextStyle(fontSize: 15.0, color: Colors.red)) : Text('- '),
            )

        ),
      ]
  );
}

Widget Loader(){
  return Center(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:[

            CircularProgressIndicator() ,

            SizedBox(width:20.0),

            new Text("Please Wait", style:TextStyle(fontSize: 30, color: Colors.deepPurple)),

          ]
      )
  );
}

Widget biorows( String t1, String t2) {
  return Container(
      child: Column(
          children: [
            Container(
                padding: EdgeInsets.only(right: 5, left: 10, top: 7),
                child: Row(
                  children: [
                    Container(
                      width: 27,
                      height: 27,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('$t1')
                          )
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(child: Text('$t2'),),
                    // Expanded(
                    //
                    // ),
                  ],       )
            )
          ]
      )
  );
}