import 'package:flutter/material.dart';
import 'package:jito_matrimony/EditActivity/editPhoto.dart';
import 'package:jito_matrimony/utils/MySharedPreferences.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewPhoto extends StatefulWidget{

  String flag, flagtest;
  bool edvi;
  ViewPhoto({this.flag, this.flagtest, this.edvi});
  @override
  vphoto createState() => vphoto();
}
class vphoto extends State<ViewPhoto>{

  final imageList = [];
  String imag2 , imag3, imag4, imag5;
  SharedPreferences myPrefs;
  int number= 1;
  int totalnumber= 3;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initpref();

  }

  initpref() async{

  myPrefs = await SharedPreferences.getInstance();

    if(int.parse(widget.flagtest) == 3) {

      imag2 = MySharedPreferences.instance.getStringValue("image1", myPrefs);
      imag3 = MySharedPreferences.instance.getStringValue("image2", myPrefs);
    }
    else if(int.parse(widget.flagtest) == 2)
    {
      imag2 = MySharedPreferences.instance.getStringValue("image1", myPrefs);
      imag3 = MySharedPreferences.instance.getStringValue("image3", myPrefs);
    }
    else if(int.parse(widget.flagtest) == 1){
      imag2 = MySharedPreferences.instance.getStringValue("image2", myPrefs);
      imag3 = MySharedPreferences.instance.getStringValue("image3", myPrefs);
    }
    setState(() {
      imageList.add('${widget.flag}');
      imageList.add(imag2);
      imageList.add(imag3);
    });


  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
         body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(

            children: [
              SizedBox(height: 50,),
                ListTile(
                  leading: Visibility(
                      visible: widget.edvi,
                    child:InkWell(

                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => editPhoto()));
                        },
                    child: Icon(Icons.edit, size: 40,),

                  ),),
                      title: Text('$number/$totalnumber', textAlign: TextAlign.center,),
                    trailing:
                        InkWell(
                      onTap: (){
                          Navigator.pop(context);
                        },
                          child: Icon(Icons.close, size: 40,),

                ),),
               SizedBox(height: 20,),
              Container(
                width: MediaQuery.of(context).size.width*.98,
              height: MediaQuery.of(context).size.height*.8,
              child: PhotoViewGallery.builder(
                itemCount: imageList.length,
                builder: (context, index) {

                  return PhotoViewGalleryPageOptions(

                    imageProvider: NetworkImage(imageList[index]),
                    minScale: PhotoViewComputedScale.contained ,
                    maxScale: PhotoViewComputedScale.covered * 2,
                    heroAttributes: PhotoViewHeroAttributes(tag: index),

                  );
                },
                scrollPhysics: BouncingScrollPhysics(),
                backgroundDecoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                ),
                  onPageChanged: onPageChanged
                // loadingChild: Center(
                //
                //   child: CircularProgressIndicator(),
                // ),
              ),
              ),
              // Container(
              //     height: MediaQuery.of(context).size.height*.8,
              //     width: MediaQuery.of(context).size.width*.99,
              //     decoration: BoxDecoration(
              //       image: DecorationImage(
              //         image: widget.flag=="0" ? AssetImage('Assets/ic_profile.png') : NetworkImage('${widget.flag}'),
              //         fit: BoxFit.fill
              //     )
              //   ),
              //
              // )
            ],
          )
         )
    );
  }
  onPageChanged(int index){
    setState(() {
      number = index +1;
    });
  }
}