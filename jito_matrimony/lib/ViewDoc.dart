import 'package:flutter/material.dart';
import 'package:jito_matrimony/EditActivity/editPhoto.dart';
import 'package:jito_matrimony/utils/MySharedPreferences.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'EditActivity/editdoc.dart';

class ViewDoc extends StatefulWidget{

  String flag, imag5;
  ViewDoc({this.flag, this.imag5});
  @override
  vdoc createState() => vdoc();
}
class vdoc extends State<ViewDoc>{

  List<String> imagelist = [];
  SharedPreferences myPrefs;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initpref();

  }

  initpref() async{

    myPrefs = await SharedPreferences.getInstance();

    setState(() {
      imagelist.add('${widget.flag}');
      imagelist.add(widget.imag5);
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
                    leading: InkWell(

                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => editdoc()));
                      },
                      child: Icon(Icons.edit, size: 40,),

                    ),
                    trailing: InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.close, size: 40,),

                    )
                ),
                SizedBox(height: 20,),
                Container(
                  width: MediaQuery.of(context).size.width*.98,
                  height: MediaQuery.of(context).size.height*.8,
                  child: PhotoViewGallery.builder(
                    itemCount: imagelist.length,
                    builder: (context, index) {
                      return PhotoViewGalleryPageOptions(
                        imageProvider: NetworkImage(imagelist[index]),
                        minScale: PhotoViewComputedScale.contained ,
                        maxScale: PhotoViewComputedScale.covered * 2,
                      );
                    },
                    scrollPhysics: BouncingScrollPhysics(),
                    backgroundDecoration: BoxDecoration(
                      color: Theme.of(context).canvasColor,
                    ),

                    // loadingChild: Center(
                    //
                    //   child: CircularProgressIndicator(),
                    // ),
                  ),
                ),
              ],
            )
        )
    );
  }

}