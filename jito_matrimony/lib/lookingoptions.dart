import 'package:flutter/material.dart';
import 'package:jito_matrimony/Search/allBiolist.dart';
import 'package:provider/provider.dart';

import 'ProviderService.dart';
import 'Search/search.dart';

class lookOpt extends StatefulWidget{
  @override

  optState createState() => optState();

}

class optState extends State<lookOpt>{

  bool isLoading = true;

  Bridesearch(search response) async {
    CircularProgressIndicator();
    Navigator.push(context, MaterialPageRoute(builder : (context) => allBiolist(biolist : response, gender: "BRIDE", sex: "Female")));

  }

  Groomsearch(search response){
    Navigator.push(context, MaterialPageRoute(builder : (context) => allBiolist(biolist : response, gender: "GROOM", sex: "Male")));

  }

  void initState(){
   isLoading = false;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
            title: Text('View Biodata', style: TextStyle(color: Colors.white,),
    ),
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
      ):ListView(
            children: [
        Container(
          child:Column(
          mainAxisAlignment: MainAxisAlignment.start,
                children: [
            GestureDetector(
            onTap: () async {
              await Provider.of<ProviderService>(context, listen: false).getsearchlist({
              "user_id":"5861",
              "categoty":"",
              "gender": "Male",
              }).then((value) => Groomsearch(value.body));
              },

             child: Stack(
              children : [

                  Container(
                height: MediaQuery.of(context).size.height/2.25,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: new AssetImage('Assets/view_b_bg.jpg'),
                  fit: BoxFit.fill,
            )
            ),

          ),

              Positioned(

              right: MediaQuery.of(context).size.width/6.0,
                top: MediaQuery.of(context).size.height/14,

                child: Container(
                  height: 250,
                  width: 250,
                decoration: BoxDecoration(
                    image: DecorationImage(
                    image: AssetImage('Assets/boy.png')
                )
                ),
    )
    ),


    ],
          ),
              ),
            GestureDetector(
            onTap: () async {
                await Provider.of<ProviderService>(context, listen: false).getsearchlist({
                "user_id":"5861",
                "categoty":"",
                "gender": "Female",
                }).then((value) => Bridesearch(value.body));

            },
            child:  Stack(
                    children : [
                    Container(
                          height: MediaQuery.of(context).size.height/2.25,
                          decoration: BoxDecoration(
                          image: DecorationImage(
                          image: new AssetImage('Assets/view_g_bg.jpg'),
                          fit: BoxFit.fill,
                          )
                      ),

                      ),




              Positioned(
                  right: MediaQuery.of(context).size.width/6.0,
                  top: MediaQuery.of(context).size.height/14,
                  child: Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                      image: AssetImage('Assets/girl.png')
                      )
                    ),
                  )
                )
              ],
    )
    )],
    ),
    )
    ]
    )
    );


  }


}