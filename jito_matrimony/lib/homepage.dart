import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jito_matrimony/MenuItems/_about.dart';
import 'package:jito_matrimony/MenuItems/_register.dart';
import 'package:jito_matrimony/ProviderService.dart';
import 'package:jito_matrimony/advertisement.dart';
import 'package:jito_matrimony/login.dart';
import 'package:jito_matrimony/popupmenu.dart';
import 'package:jito_matrimony/lookingoptions.dart';
import 'package:jito_matrimony/manage_bio.dart';
import 'package:jito_matrimony/filter.dart';
import 'package:jito_matrimony/MenuItems/ContactUs.dart';
import 'package:jito_matrimony/profileView.dart';
import 'package:jito_matrimony/utils/MySharedPreferences.dart';
import 'package:provider/provider.dart';
import 'package:jito_matrimony/MenuItems/_contact.dart';
import 'package:jito_matrimony/MenuItems/_privacypolicy.dart';
import 'package:jito_matrimony/MenuItems/aboutUs.dart';
import 'package:jito_matrimony/MenuItems/policy.dart';
import 'package:jito_matrimony/MenuItems/committeeDetails.dart';
import 'package:jito_matrimony/MenuItems/committee.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'EditActivity/Biodata.dart';
import 'MenuItems/Feedback_.dart';
import 'MenuItems/WhyRegister.dart';
import 'MyFavourites.dart';
import 'Widgets/rows.dart';
import 'constants.dart';

class homepage extends StatefulWidget
{
  @override
  homeState createState() => homeState();
}
class homeState extends State<homepage>{

  SharedPreferences myPrefs;
  String _token, _userid, bioid, profid, username, img, link1, link2, link3, flag;

  CustomPopupMenu _selectedChoices;
  void _select(CustomPopupMenu choice) {
    setState(() {
      _selectedChoices = choice;
    });
  }

  @override
  void initState() {

    super.initState();

    initPref();

  }

  initPref() async{

    myPrefs = await SharedPreferences.getInstance();

    _userid = MySharedPreferences.instance.getStringValue(UserID.user_id, myPrefs);
    _token = MySharedPreferences.instance.getStringValue(Verify.token, myPrefs);

    await Provider.of<ProviderService>(context, listen: false).getBiodata({"user_id": _userid, "token": _token}).then((value) => getBioid(value.body));
print("AM i oofffutut");

    await Provider.of<ProviderService>(context, listen: false).getAdvertise({"user_id": _userid, "token": _token}).then((value) => getAd(value.body));
    print("getted out frm");

    //await Provider.of<ProviderService>(context, listen: false).getBio({"user_id": _userid, "token": _token}).then((value) => getBio(value.body));


  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Rate this App'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Like JITO Matrimonial app? Please rate us on Play Store and write your feedback there.'),
              ],
            ),
          ),
          actions: <Widget>[
            Row(

              children:[
            TextButton(
              child: const Text('RATE NOW '),
              onPressed: () {
                launch('https://play.google.com/store/apps/details?id=com.pioneer.jito&hl=en_IN&gl=US');
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(' REMIND LATER '),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('NOT NOW  '),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        )
        ]
        )
        ;
      },
    );
  }

  Future<void> _showlogoutDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
            title: const Text('Logout'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text('Are sure you want to Logout ?'),
                ],
              ),
            ),
            actions: <Widget>[
              Row(

                children:[
                  TextButton(
                    child: const Text('No'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: const Text(' Yes '),
                    onPressed: () async {
                      SharedPreferences preferences = await SharedPreferences.getInstance();
                      await preferences.clear();
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Login()), (route) => false);

                    },
                  ),
                ],
              )
            ]
        )
        ;
      },
    );
  }

  getBioid(Biodata response){

      print("hhhhhhhhhhhh");

      if(response.status ==400){
        flag="0";
      }
      else {
        flag="1";
        bioid = response.datainfo[0].bioId;
        username = response.datainfo[0].name;
        img = response.datainfo[0].img1;
        profid = response.datainfo[0].mFId;

        print("bioiodsdidd     $bioid");

        setState(() {
          MySharedPreferences.instance.setStringValue("bio_id", bioid);
          MySharedPreferences.instance.setStringValue("prof_id", profid);
          MySharedPreferences.instance.setStringValue("user_name", username);
          MySharedPreferences.instance.setStringValue("img_1", img);
        });
      }
}

  @override
  Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text('JITO Matrimony', textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
              actions:[

                PopupMenuButton<String>(
                  onSelected: (value) async{

                    if(value == "View Profile"){

                      Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileView(phone: "7016688620")));
                    }
                    if(value ==  "Contact Us"){
                            await Provider.of<ProviderService>(context, listen: false).getContact({}).then((value) => contacting(value.body));
                    }
                    else if(value ==  "About Us"){
                      await Provider.of<ProviderService>(context, listen: false).getAbout({}).then((value) => About(value.body));
                    }
                    else if(value ==  "Privacy Policy"){
                            await Provider.of<ProviderService>(context, listen: false).getPolicy({}).then((value) => PriPolicy(value.body));
                    }
                    else if(value ==  "Committee"){
                      await Provider.of<ProviderService>(context, listen: false).getCommittee({}).then((value) => Commit(value.body));
                    }
                    else if(value== "Why Register"){
                      await Provider.of<ProviderService>(context, listen: false).getRegister({}).then((value) => Register(value.body));
                    }
                    else if(value== "Feedback"){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Feedback_()));
                    }
                    else if(value== "Rate Us"){
                        _showMyDialog();
                    }
                    else if(value== "Logout"){

                      _showlogoutDialog();

                    }

                  },
                  itemBuilder: (BuildContext context) {
                    return [
                      PopupMenuItem(
                        child: Text("View Profile"),
                        value: "View Profile",
                      ),
                    PopupMenuItem(
                    child: Text("About Us"),
                    value: "About Us",
                    ),
                    PopupMenuItem(
                    child: Text("Contact Us"),
                    value: "Contact Us",
                    ),
                    PopupMenuItem(
                    child: Text("Committee"),
                    value: "Committee",
                    ),
                    PopupMenuItem(
                    child: Text("Why Register?"),
                    value: "Why Register",
                    ),
                    PopupMenuItem(
                    child: Text("Privacy Policy"),
                    value: "Privacy Policy",
                    ),
                    PopupMenuItem(
                    child: Text("Feedback"),
                    value: "Feedback",
                    ),
                    PopupMenuItem(
                    child: Text("Rate Us"),
                    value: "Rate Us",
                    ),
                    PopupMenuItem(
                    child: Text("Logout"),
                    value: "Logout",
                    ),
                    PopupMenuItem(
                    child: Text("V 2.4"),
                    value: "V 2.4",
                    ),
                    ];
                  },
        ),
                ],

          ),
          body: ListView(
            children: [
              Container(
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                  GestureDetector(
                    child: Container(
                        height: MediaQuery.of(context).size.height/4.82,
                      decoration: BoxDecoration(
                    image: DecorationImage(
                      image: new AssetImage('Assets/add_bia.png'),
                      fit: BoxFit.fill,
                    )
            ),
                      ),
                  onTap: () async {

                    Navigator.of(context).push(MaterialPageRoute (builder: (context) => ManageBio(flag:flag)));
        },
                  ),
                  GestureDetector(
                    child: Container(
                  height: MediaQuery.of(context).size.height/4.82,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: new AssetImage('Assets/viewbiodata.png'),
                        fit: BoxFit.fill

                ),
              ),
                        ),
                    onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => lookOpt()));
    },
            ),
                      GestureDetector(
                          child: Container(
                          height: MediaQuery.of(context).size.height/4.82,
                          decoration: BoxDecoration(
                          image: DecorationImage(
                              image: new AssetImage('Assets/searchbiodata.png'),
                              fit: BoxFit.fill

                      ),
                    ),
                  ),
                  onTap: () {
                           Navigator.of(context).push(MaterialPageRoute(builder: (context) => filterPage()));
                }
    ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  MyFavourites(userid: _userid)));
                    },
                              child: Container(
                    height: MediaQuery.of(context).size.height/4.82,

                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: new AssetImage('Assets/my_favourites_fin.jpg'),
                          fit: BoxFit.fill

                    ),
                  ),
            ),
                ),
                    ListView(
                    shrinkWrap: true,

                            children: [
                              CarouselSlider(
                                items: [

                                        InkWell(
                                          onTap: ()  {

                                        },

                                          child: Container(
                                              width: MediaQuery.of(context).size.width*.99,

                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(8.0),
                                                  image: DecorationImage(
                                                  image: NetworkImage('$link1'),
                                                    fit: BoxFit.fitWidth,
                                            )
                            )
                            ),

    ),
                                    InkWell(
                                    onTap: ()  {

                                    },
                                          child: Container(
                                            width: MediaQuery.of(context).size.width*.99,

                                          decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8.0),
                                                image: DecorationImage(
                                                image: NetworkImage('$link2'),
                                                  fit: BoxFit.fitWidth,
                                                )
                      )
                                      ),

                                  ),

                                  InkWell(
                                  onTap: ()  {

                                  },

                                      child: Container(
                                          width: MediaQuery.of(context).size.width*.99,

                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8.0),
                                        image: DecorationImage(
                                        image: NetworkImage('$link3'),
                                          fit: BoxFit.fitWidth,
                                  )
                                  )


    ),),
                            ],

                          options: CarouselOptions(
                          height: MediaQuery.of(context).size.height*.06,
                          enlargeCenterPage: true,
                          aspectRatio: 16 / 9,
                          enableInfiniteScroll: true,
                          autoPlay: true,
                          autoPlayAnimationDuration: Duration(milliseconds: 200),

    ),
                                  )
    ]
    )
    ])
    )
  ])

        );
  }

  contacting(contact response){
    print(response.message);

    var res = response.datainfo.details.toString();
    Navigator.push(context, MaterialPageRoute(builder: (context) => ContactUs(htmlCont: res.toString())));
  }

  About(about response){
    Loader();
    var res = response.datainfo.details.toString();
    Navigator.push(context, MaterialPageRoute(builder: (context) => aboutUs(htmlCont: res.toString())));
  }

  PriPolicy(privacypolicy response){
    var res = response.datainfo.details.toString();
    Navigator.push(context, MaterialPageRoute(builder: (context) => Policy(htmlCont: res.toString())));
  }

  Commit(committee response){
    var res = response.datainfo.details.toString();
    Navigator.push(context, MaterialPageRoute(builder: (context) => committeeDetails(htmlCont: res.toString())));
  }

  Register(register response){
    var res = response.datainfo.details.toString();
    Navigator.push(context, MaterialPageRoute(builder: (context) => WhyRegister(htmlCont: res.toString())));
  }

  getAd( advertisement resp){
    link1 = resp.datainfo[0].bottomImage;
    print("LInkkkeee ifff Add $link1");
    link3 = resp.datainfo[2].bottomImage;
    link2 = resp.datainfo[1].bottomImage;
  }
}
