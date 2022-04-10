import 'package:flutter/material.dart';
import 'package:jito_matrimony/ProviderService.dart';
import 'package:jito_matrimony/Search/showBiolist.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:jito_matrimony/Search/search.dart';
import 'package:provider/provider.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'dart:math';


class filterPage extends StatefulWidget{
  @override
  filterstate createState() => filterstate();

}

class Age {
  final int id;
  final String name;

  Age({
    this.id,
    this.name,
  });
}

class Height{
  final int id;
  final String name;
  Height({this.id, this.name});
}

ProgressDialog pr;

class filterstate extends State<filterPage>{

  final formKey = new GlobalKey<FormState>();
  String maritaldropdownValue ;
  String tonguedropdownValue;
  String jaindropdownValue ;
  TextEditingController _profilecontroller = TextEditingController();
  TextEditingController _idcontroller = TextEditingController();
  List<Age> _selectedAge;
  List<Height> _selectedHeight;
  String aMin, aMax, hMin, hMax;
  String _disability, _livingstatus, _gender = "Male";
  List<int> a;
  List<int> h;

  void initState(){
    progress();
  }

  Future<void> progress() async{
    await pr.show();
  }
  static List<Age> Ages = [
    Age(id: 18 , name: " 18 " ) ,
    Age(id: 19 , name: " 19 " ) ,
    Age(id: 20 , name: " 20 " ) ,
    Age(id: 21 , name: " 21 " ) ,
    Age(id: 22 , name: " 22 " ) ,
    Age(id: 23 , name: " 23 " ) ,
    Age(id: 24 , name: " 24 " ) ,
    Age(id: 25 , name: " 25 " ) ,
    Age(id: 26 , name: " 26 " ) ,
    Age(id: 27 , name: " 27 " ) ,
    Age(id: 28 , name: " 28 " ) ,
    Age(id: 29 , name: " 29 " ) ,
    Age(id: 30 , name: " 30 " ) ,
    Age(id: 31 , name: " 31 " ) ,
    Age(id: 32 , name: " 32 " ) ,
    Age(id: 33 , name: " 33 " ) ,
    Age(id: 34 , name: " 34 " ) ,
    Age(id: 35 , name: " 35 " ) ,
    Age(id: 36 , name: " 36 " ) ,
    Age(id: 37 , name: " 37 " ) ,
    Age(id: 38 , name: " 38 " ) ,
    Age(id: 39 , name: " 39 " ) ,
    Age(id: 40 , name: " 40 " ) ,
    Age(id: 41 , name: " 41 " ) ,
    Age(id: 42 , name: " 42 " ) ,
    Age(id: 43 , name: " 43 " ) ,
    Age(id: 44 , name: " 44 " ) ,
    Age(id: 45 , name: " 45 " ) ,
    Age(id: 46 , name: " 46 " ) ,
    Age(id: 47 , name: " 47 " ) ,
    Age(id: 48 , name: " 48 " ) ,
    Age(id: 49 , name: " 49 " ) ,
    Age(id: 50 , name: " 50 " ) ,
    Age(id: 51 , name: " 51 " ) ,
    Age(id: 52 , name: " 52 " ) ,
    Age(id: 53 , name: " 53 " ) ,
    Age(id: 54 , name: " 54 " ) ,
    Age(id: 55 , name: " 55 " ) ,
    Age(id: 56 , name: " 56 " ) ,
    Age(id: 57 , name: " 57 " ) ,
    Age(id: 58 , name: " 58 " ) ,
    Age(id: 59 , name: " 59 " ) ,
    Age(id: 60 , name: " 60 " ) ,

  ];

  static List<Height> heights = [
    Height(id: 0 , name: " 4ft 0in " ) ,
    Height(id: 1 , name: " 4ft 1in " ) ,
    Height(id: 2 , name: " 4ft 2in " ) ,
    Height(id: 3 , name: " 4ft 3in " ) ,
    Height(id: 4 , name: " 4ft 4in " ) ,
    Height(id: 5 , name: " 4ft 5in " ) ,
    Height(id: 6 , name: " 4ft 6in " ) ,
    Height(id: 7 , name: " 4ft 7in " ) ,
    Height(id: 8 , name: " 4ft 8in " ) ,
    Height(id: 9 , name: " 4ft 9in " ) ,
    Height(id: 10 , name: " 4ft 10in " ) ,
    Height(id: 11 , name: " 4ft 11in " ) ,
    Height(id: 12 , name: " 5ft 0in " ) ,
    Height(id: 13 , name: " 5ft 1in " ) ,
    Height(id: 14 , name: " 5ft 2in " ) ,
    Height(id: 15 , name: " 5ft 3in " ) ,
    Height(id: 16 , name: " 5ft 4in " ) ,
    Height(id: 17 , name: " 5ft 5in " ) ,
    Height(id: 18 , name: " 5ft 6in " ) ,
    Height(id: 19 , name: " 5ft 7in " ) ,
    Height(id: 20 , name: " 5ft 8in " ) ,
    Height(id: 21 , name: " 5ft 9in " ) ,
    Height(id: 22 , name: " 5ft 10in " ) ,
    Height(id: 23 , name: " 5ft 11in " ) ,
    Height(id: 24 , name: " 6ft 0in " ) ,
    Height(id: 25 , name: " 6ft 1in " ) ,
    Height(id: 26 , name: " 6ft 2in " ) ,
    Height(id: 27 , name: " 6ft 3in " ) ,
    Height(id: 28 , name: " 6ft 4in " ) ,
    Height(id: 29 , name: " 6ft 5in " ) ,
    Height(id: 30 , name: " 6ft 6in " ) ,
    Height(id: 31 , name: " 6ft 7in " ) ,
    Height(id: 32 , name: " 6ft 8in " ) ,
    Height(id: 33 , name: " 6ft 9in " ) ,
    Height(id: 34 , name: " 6ft 10in " ) ,
    Height(id: 35 , name: " 6ft 11in " ) ,
    Height(id: 36 , name: " 7ft 0in ")
  ];

  final _items = Ages
      .map((age) => MultiSelectItem<Age>(age, age.name))
      .toList();

  final _heightitems = heights
      .map((height) => MultiSelectItem<Height>(height, height.name))
      .toList();

  Navsearch(search response){
    print(_gender);
    Navigator.push(context, MaterialPageRoute(builder : (context) => showBiolist(biolist : response, gender: _gender, sex: _gender)));
  }

  @override
  Widget build(BuildContext context) {

    var pr = new ProgressDialog(context ,type: ProgressDialogType.Normal);
    pr.style(
        message: 'Please Wait ...',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600)
    );
      return Scaffold(
        appBar: AppBar(
          title: Text('Search Biodata', style: TextStyle(color: Colors.white),),
            actions: <Widget>[
              VerticalDivider(color: Colors.white, thickness: 1, indent: 5, endIndent: 5,),
              TextButton(
                onPressed: () async {

                  await Provider.of<ProviderService>(context, listen: false).getsearchlist({
                    "user_id":"5861",
                    "categoty":"",
                    "gender":_gender,
                    "min_age":aMin,
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
                    "leaving_status":_livingstatus,
                    "physical_disability": _disability,
                    "profile_id": _idcontroller.text,
                    "profile_name": _profilecontroller.text
                  }).then((value) => Navsearch(value.body));

                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(Icons.search, color: Colors.white),
                    Text('Search', style: TextStyle(color: Colors.white),)
                  ],
                ),
              ),

          ]
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.only(top: 10),
            child: Form(
              key: formKey,
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                new Text('    GENDER', style: TextStyle(fontSize: 14),),
                Row(

                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 35, width: 20,),


                  new Radio(
                  value: "Male",
                  groupValue: _gender,
                  onChanged: (value){
                    setState(() {
                      _gender = value;
                    });
                  },
                ),
                  new Text(
                    'Groom',
                    style: new TextStyle(fontSize: 17.0),
                  ),
                  SizedBox(width: 15,),


                  new Radio(
                    value: "Female",
                    groupValue: _gender,
                    onChanged: (value){
                      setState(() {
                        _gender = value;
                      });
                    },
                  ),
                  new Text(
                    'Bride',
                    style: new TextStyle(fontSize: 17.0),
                  ),


              ],
        ),
                Divider(height: 5, thickness: 1, color: Colors.grey,),
                SizedBox(height: 10),
                Text('    AGE (18 yrs to 60 yrs)'),
                SizedBox(height: 10),
                Row(
                children: [
                  SizedBox(width: 12,),
                  Container(

                  width: MediaQuery.of(context).size.width*.94,
                  decoration: BoxDecoration(
                      color: Colors.white,
                    border: Border.all(color: Colors.grey,)
                  ),
                    child: MultiSelectDialogField(
                      items: _items,
                      title: Text("Select Ages"),
                      selectedColor: Colors.blueGrey,
                      decoration: BoxDecoration(


                    ),
                      buttonIcon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.deepPurple,
                        size: 50,
                      ),
                      searchable: true,
                      buttonText: Text(
                        " Select Ages",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                      ),
                    ),
                    onConfirm: (res) {
                        _selectedAge = res;
                        print("selected ags  ${_selectedAge}");
                        if(_selectedAge.contains(res)){
                              a.remove(_selectedAge[0].name);
                        }
                        for(int i=0;i<_selectedAge.length;i++){
                          a.add(int.parse(_selectedAge[i].name));
                        }
                        setState(() {
                          aMin = a.reduce(min).toString();
                          aMax = a.reduce(max).toString();
                        });

                      //_selectedAnimals = results;
                    },
              ),
              ),
                  ]
                ),
                  SizedBox(height: 15),
                  Divider(height: 5, thickness: 1, color: Colors.grey,),
                  SizedBox(height: 10,),
                  Text('    HEIGHT (4.0ft to 7.0ft)', style: TextStyle(color: Colors.black),),
                  SizedBox(height: 10,),
                  Row(

                    children:[
                    SizedBox(width: 12,),
                    Container(

                      width: MediaQuery.of(context).size.width*.94,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey)

                    ),
                      child: MultiSelectDialogField(
                        items: _heightitems,
                        title: Text("Select Heights", style: TextStyle(color: Colors.black),),
                        selectedColor: Colors.blueGrey,
                        decoration: BoxDecoration(

                        ),
                        buttonIcon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.deepPurple,
                          size: 50,
                        ),
                        searchable: true,
                        buttonText: Text(
                        "Select Heights",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                      onConfirm: (results) {
                          _selectedHeight = results;
                          print("selected heights  ${_selectedHeight[0].name}");
                          for(int i=0;i<_selectedHeight.length;i++){
                            h.add((_selectedHeight[i].name) as int);
                            print(h);
                          }

                            hMin = h.reduce(min).toString();
                            print(hMin);
                            hMax = h.reduce(max).toString();
                            print(hMax);

                      },
                    ),
              ),]
                  ),
                SizedBox(height: 15,),
                Divider(thickness: 1.0, color: Colors.grey,),
                SizedBox(height: 10,),
                Text('    MARITAL STATUS'),
                SizedBox(height: 10,),
                Row(
                children:[
                  SizedBox(width: 12,),
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width*.94,
                    padding: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                  ),

                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                      ),
                      value: null,
                      icon: Icon(Icons.arrow_drop_down_outlined, size: 25, color: Colors.deepPurple,),
                      iconSize: 44,
                      elevation: 16,
                      hint: Text('Select Marital Status'),

                      onChanged: (newValue) {
                        setState(() {
                          maritaldropdownValue = newValue;
                        });
                      },
                      items: <String>["Doesn't Matter", 'Single', 'Divorced', 'Widowed']
                          .map<DropdownMenuItem<String>>((String val) {
                        return DropdownMenuItem<String>(
                          value: val,
                          child: Text(val),
                        );
                    }).toList(),
                ),
                ),
            ]
        ),
                SizedBox(height: 15,),
                Divider(thickness: 1.0, color: Colors.grey,),
                SizedBox(height: 1,),
                Divider(thickness: 1.0, color: Colors.grey,),
                SizedBox(height: 10,),
                Text('    MOTHER TONGUE'),
                SizedBox(height: 10,),
                Row(
                    children:[
                      SizedBox(width: 12,),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width*.94,
                        padding: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey),
                        ),

                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            enabledBorder: InputBorder.none,
                          ),
                          value: null,
                          icon: Icon(Icons.arrow_drop_down_outlined, size: 25, color: Colors.deepPurple,),
                          iconSize: 44,
                          elevation: 16,
                          hint: Text('Select Mother Tongue'),

                          onChanged: (newValue) {
                            setState(() {
                              tonguedropdownValue = newValue;
                            });
                          },
                          items: <String>["Doesn't Matter", 'Gujarati', 'Marwadi', 'Hindi', 'Other']
                              .map<DropdownMenuItem<String>>((String val) {
                            return DropdownMenuItem<String>(
                              value: val,
                              child: Text(val),
                            );
                          }).toList(),
                        ),
                      ),
                    ]
                ),
                SizedBox(height: 15,),
                Divider(thickness: 1.0, color: Colors.grey,),
                SizedBox(height: 10,),
                Text('    MANGLIK'),
                SizedBox(height: 10,),
                Row(
                    children:[
                      SizedBox(width: 12,),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width*.94,
                        padding: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey),
                        ),

                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            enabledBorder: InputBorder.none,
                          ),
                          value: null,
                          icon: Icon(Icons.arrow_drop_down_outlined, size: 25,color: Colors.deepPurple,),
                          iconSize: 44,
                          elevation: 16,
                          hint: Text('Select Manglik'),

                          onChanged: (newValue) {
                            setState(() {
                              maritaldropdownValue = newValue;
                            });
                          },
                          items: <String>["Doesn't Matter", 'Manglik', 'No Manglik']
                              .map<DropdownMenuItem<String>>((String val) {
                            return DropdownMenuItem<String>(
                              value: val,
                              child: Text(val),
                            );
                          }).toList(),
                        ),
                      ),
                    ]
                ),
                SizedBox(height: 15,),
                Divider(height: 5, thickness: 1, color: Colors.grey,),
                SizedBox(height: 10),
                Text('    EDUCATION'),
                SizedBox(height: 10),
                Row(
                    children: [
                      SizedBox(width: 12,),
                      Container(

                        width: MediaQuery.of(context).size.width*.94,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey,)
                        ),
                        child: MultiSelectDialogField(
                          items: _items,
                          title: Text("EDUCATION"),
                          selectedColor: Colors.blueGrey,
                          decoration: BoxDecoration(


                          ),
                          buttonIcon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.deepPurple,
                            size: 50,
                          ),
                          searchable: true,
                          buttonText: Text(
                            " Select Education",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                          onConfirm: (res) {
                            //_selectedAnimals = results;
                          },
                        ),
                      ),
                    ]
                ),

                SizedBox(height: 15,),
                Divider(thickness: 1.0, color: Colors.grey,),

                new Text('    LIVING STATUS', style: TextStyle(fontSize: 14),),
                Row(

                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 35, width: 20,),

                    new Radio(
                      value: 0,
                      groupValue: _livingstatus,
                      onChanged: (value){
                        setState(() {
                          _livingstatus = value;
                        });
                      },
                    ),
                    new Text(
                      'NRI',
                      style: new TextStyle(fontSize: 17.0),
                    ),
                    SizedBox(width: 15,),

                    new Radio(
                      value: 1,
                      groupValue: _livingstatus,
                      onChanged: (value){
                        setState(() {
                          _livingstatus = value;
                        });
                      },
                    ),
                    new Text(
                      'Indian',
                      style: new TextStyle(fontSize: 17.0),
                    ),
                    SizedBox(width: 15,),


                    new Radio(
                      value: 1,
                      groupValue: _livingstatus,
                      onChanged: (value){
                        setState(() {
                          _livingstatus = value;
                        });
                      },
                    ),
                    new Text(
                      'Any',
                      style: new TextStyle(fontSize: 17.0),
                    ),

                  ],
                ),
                SizedBox(height: 10,),
                Divider(height: 5, thickness: 1, color: Colors.grey,),
                SizedBox(height: 15,),
                Divider(thickness: 1.0, color: Colors.grey,),
                SizedBox(height: 10,),
                Text('    STATE'),
                SizedBox(height: 10,),
                Row(
                    children:[
                      SizedBox(width: 12,),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width*.94,
                        padding: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey),
                        ),

                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            enabledBorder: InputBorder.none,
                          ),
                          value: null,
                          icon: Icon(Icons.arrow_drop_down_outlined, size: 25, color: Colors.deepPurple,),
                          iconSize: 44,
                          elevation: 16,
                          hint: Text('Select State'),

                          onChanged: (newValue) {
                            setState(() {
                              maritaldropdownValue = newValue;
                            });
                          },
                          items: <String>["Doesn't Matter", 'Single', 'Divorced', 'Widowed']
                              .map<DropdownMenuItem<String>>((String val) {
                            return DropdownMenuItem<String>(
                              value: val,
                              child: Text(val),
                            );
                          }).toList(),
                        ),
                      ),
                    ]
                ),
                SizedBox(height: 10,),
                Divider(height: 5, thickness: 1, color: Colors.grey,),
                SizedBox(height: 10),
                Text('    CITY'),
                SizedBox(height: 10),
                Row(
                    children: [
                      SizedBox(width: 12,),
                      Container(

                        width: MediaQuery.of(context).size.width*.94,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey,)
                        ),
                        child: MultiSelectDialogField(
                          items: _items,
                          title: Text("Select City"),
                          selectedColor: Colors.blueGrey,
                          decoration: BoxDecoration(


                          ),
                          buttonIcon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.deepPurple,
                            size: 50,
                          ),
                          searchable: true,
                          buttonText: Text(
                            " Select City",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                          onConfirm: (res) {
                            //_selectedAnimals = results;
                          },
                        ),
                      ),
                    ]
                ),
                SizedBox(height: 10,),
                Divider(height: 5, thickness: 1, color: Colors.grey,),
                SizedBox(height: 10,),
                Text('    JAIN SAMPRADAYA'),
                SizedBox(height: 10,),
                Row(
                    children:[
                      SizedBox(width: 12,),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width*.94,
                        padding: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey),
                        ),

                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            enabledBorder: InputBorder.none,
                          ),
                          value: null,
                          icon: Icon(Icons.arrow_drop_down_outlined, size: 25, color: Colors.deepPurple,),
                          iconSize: 44,
                          elevation: 16,
                          hint: Text('Select Jain Sampradaya'),

                          onChanged: (newValue) {
                            setState(() {
                              jaindropdownValue = newValue;
                            });
                          },
                          items: <String>["Doesn't Matter", 'Shwetamber', 'Digamber', 'Sthanakwasi', 'Terapanth', 'others']
                              .map<DropdownMenuItem<String>>((String val) {
                            return DropdownMenuItem<String>(
                              value: val,
                              child: Text(val),
                            );
                          }).toList(),
                        ),
                      ),
                    ]
                ),
                SizedBox(height: 15,),
                Divider(thickness: 1.0, color: Colors.grey,),
                SizedBox(height: 10),

                new Text('    PHYSICAL DISABILITY', style: TextStyle(fontSize: 14),),
                Row(

                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 35, width: 20,),

                    new Radio(
                      value: 0,
                      groupValue: _disability,
                      onChanged: (value){
                        setState(() {
                          _disability = value;
                        });
                      },
                    ),
                    new Text(
                      'Yes',
                      style: new TextStyle(fontSize: 17.0),
                    ),
                    SizedBox(width: 15,),

                    new Radio(
                      value: 1,
                      groupValue: _disability,
                      onChanged: (value){
                        setState(() {
                          _disability = value;
                        });
                      },
                    ),
                    new Text(
                      'No',
                      style: new TextStyle(fontSize: 17.0),
                    ),
                    SizedBox(width: 15,),


                    new Radio(
                      value: 1,
                      groupValue: _disability,
                      onChanged: (value){
                        setState(() {
                          _disability = value;
                        });
                      },
                    ),
                    new Text(
                      'Any',
                      style: new TextStyle(fontSize: 17.0),
                    ),

                  ],
                ),
                SizedBox(height: 5,),
                Divider(thickness: 1.0, color: Colors.grey,),
                SizedBox(height: 10,),
                Text('    Profile Name',),
                SizedBox(height: 10,),
                Container(
                  height: 40,
                  child: Row(

                    children:[
                      SizedBox(width: 12,),
                        Container(
                          width: MediaQuery.of(context).size.width*.94,
                          color: Colors.white,
                          child: TextFormField(
                          textAlignVertical: TextAlignVertical.bottom,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Profile Name',
                            counterText: "",
                          ),

                          controller: _profilecontroller,
                ),
                ),
            ]),
        ),
                    SizedBox(height: 15,),
                    Text('    Profile Id',),
                    SizedBox(height: 10,),
                    Container(
                      height: 40,
                      child: Row(

                      children:[
                        SizedBox(width: 12,),
                        Container(
                      width: MediaQuery.of(context).size.width*.94,
                      color: Colors.white,
                      child: TextFormField(
                        textAlignVertical: TextAlignVertical.bottom,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Profile Id ',
                          counterText: "",
                        ),

                    controller: _idcontroller,
                  ),
                ),
              ],
      )
        ),
                SizedBox(height: 30,),
                Divider(thickness: 1.0, color: Colors.grey,)
        ]
              ),
        )
        )

      );
  }

}