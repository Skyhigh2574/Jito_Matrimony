import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jito_matrimony/ProviderService.dart';
import 'package:jito_matrimony/favouriteadd.dart';
import 'package:jito_matrimony/managefav.dart';
import 'package:jito_matrimony/utils/MySharedPreferences.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Search/ViewSearchedBio.dart';
import 'Widgets/rows.dart';

class MyFavourites extends StatefulWidget{

  String userid;
  MyFavourites({this.userid});
  myfav createState() => myfav();

}

class myfav extends State<MyFavourites>{

  SharedPreferences myprefs;
  int count;
  List<String> _age = [''], _name = [''], _height = [''], _profid = [''], _tongue = [''], _jain = [''], _city = [''], _image = [''], _state = [''];

  bool isLoading;

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });
    initpref();
  }

  initpref() async {

    await Provider.of<ProviderService>(context, listen: false).managefavourite({"user_id": widget.userid}).then((value) => getfavs(value.body));
  }

  getfavs(managefav resp){

    setState(() {

      count = resp.datainfo.length;
      print(count);
      print(resp.datainfo[0].profileId);

      for(int i=0;i< count;i++) {
        
        _profid.add(resp.datainfo[i].profileId);
        _name.add(resp.datainfo[i].name);
        _height.add(resp.datainfo[i].height);
        _tongue.add(resp.datainfo[i].motherToungue);
        _jain .add(resp.datainfo[i].jainSampradaya);
        _city.add(resp.datainfo[i].city);
        _state.add(resp.datainfo[i].state);
        _age.add(resp.datainfo[i].age);
        _image.add(resp.datainfo[i].img1);
        
      }
      isLoading = false;
    });
  }

  removedFav(favouriteadd resp){
    Fluttertoast.showToast(
        msg: resp.message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 20.0
    );
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => MyFavourites()));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
            title: Text('My Favourites'),
        ),
      body: isLoading ? Loader():Container(
          color: Colors.grey[200],
          margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5),

          child: Container(
              color: Colors.grey[200],

              child: ListView.builder(

                  padding: EdgeInsets.only(bottom:10, top: 2 ),
                  itemCount: count,
                  itemBuilder: (context, index) {
                    return Container(
                        padding: EdgeInsets.only( bottom: 10),
                        color: Colors.grey[200],
                        child: Column(
                          children: [
                        GestureDetector(

                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>ViewSearchedBio(profid: _profid[index + 1])));
                        },
                        child: Container(


                          child: Row(
                              children: [
                                Container(

                                    padding: EdgeInsets.only(top: 10, bottom: 10),
                                    decoration: BoxDecoration(
                                        border: Border(bottom: BorderSide(width: 2.0, color: Colors.grey),),
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
                                                      image: NetworkImage(_image[index + 1]),
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

                                                        rows2('${_name[index + 1]}','${index + 1}'),

                                                        rows3('${_age[index + 1]}, ${_height[index + 1]}', 'ID - ${_profid[index + 1]}'),

                                                        rows3("${_tongue[index + 1]}, ${_jain[index + 1]}", ''),



                                                        Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                                            children: <Widget>[
                                                              Container(

                                                                  child: Align(
                                                                      alignment: Alignment.topLeft,
                                                                      child: (_image[index + 1] != null && _image[index + 1] !=null) ? _image[index + 1] != null ? Text(' 3 Photos', style: TextStyle(fontSize: 12.0, color: Colors.red),) : Text(' 2 Photos', style: TextStyle(fontSize: 12.0, color: Colors.red),) : Text(' ')
                                                                  )
                                                              ),

                                                              Container(

                                                                child: Align(
                                                                    alignment: Alignment.bottomLeft,
                                                                    child: Text("${_city[index + 1]}, ${_state[index + 1]}", style: TextStyle(fontSize: 15.0),

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
                    ),
                    GestureDetector(
                      onTap:() async {
                        await Provider.of<ProviderService>(context, listen: false).addfavourite({
                          "user_id":widget.userid,
                          "sender_id":widget.userid,
                          "request_type":"2",
                          "favadded_id": _profid[index]
                        }).then((value) => removedFav(value.body));
                    },
                    child: Container(
                      height:40,
                      color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:[
                            Text('REMOVE'),
                            SizedBox(width:5),
                            Container(
                              height: 20,
                                width: 20,

                                decoration: BoxDecoration(

                                image: DecorationImage(
                                  image: AssetImage('Assets/ic_close.png'),
                                ),
                                ),
                            ),
                          ]
                        )
                    ),
                    ),
                    ]),
                    );
                  }
              )
          )
      )
    );

  }


}