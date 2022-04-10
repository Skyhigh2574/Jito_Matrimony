import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:intent/action.dart';
import 'dart:typed_data';
import 'package:intent/intent.dart' as android_intent;
import 'package:intent/action.dart' as android_action;
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_screenutil/screenutil_init.dart';



class TermCondition extends StatefulWidget{

  String htmlCont;
  TermCondition({this.htmlCont});

  @override
  termsCondition createState() => termsCondition();
}

class termsCondition extends State<TermCondition>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

  // String url ="";
  //
  //
  // final GlobalKey webViewKey = GlobalKey();
  //
  // InAppWebViewController webViewController;
  // InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
  //     crossPlatform: InAppWebViewOptions(
  //       useShouldOverrideUrlLoading: true,
  //       mediaPlaybackRequiresUserGesture: false,
  //       debuggingEnabled: true,
  //     ),
  //     android: AndroidInAppWebViewOptions(
  //     ),
  //     ios: IOSInAppWebViewOptions(
  //       allowsInlineMediaPlayback: true,
  //     ));
  //
  //
  // HeadlessInAppWebView headlessWebView;
  // //String url = "http://www.communitymsg.com/sumaryreport.aspx?SamajID=";
  //
  //
  // double progress = 0;
  // int   _counter = 0;
  //
  //
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //
  //   url  = 'http://jito.lakecitypivotz.com/api/Master/termsCondition';
  //
  // }
  //
  //
  // Future<void> _makePhoneCall(String url) async {
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }
  //
  //
  // Future<void> _launchUniversalLinkIos(String url) async {
  //   if (await canLaunch(url)) {
  //     final bool nativeAppLaunchSucceeded = await launch(
  //       url,
  //       forceSafariVC: false,
  //       universalLinksOnly: true,
  //     );
  //     if (!nativeAppLaunchSucceeded) {
  //       await launch(
  //         url,
  //         forceSafariVC: true,
  //       );
  //     }
  //   }
  // }
  //
  //
  //
  // @override
  // Widget build(BuildContext context) {
  //   // TODO: implement build
  //   return Scaffold(
  //     appBar: AppBar(
  //         backgroundColor: Colors.deepPurple,
  //
  //         title: Text('Terms and Conditions', style:TextStyle(color: Colors.white))
  //
  //     ),
  //     body:SingleChildScrollView(child: Column(
  //
  //         crossAxisAlignment: CrossAxisAlignment.stretch,
  //
  //         children:<Widget> [
  //
  //           Container(
  //
  //             margin: EdgeInsets.fromLTRB(15, 10, 15, 10),
  //             height: MediaQuery.of(context).size.height * 0.85,
  //
  //
  //             child: InAppWebView(
  //               //  initialUrl: "https://blog.codemagic.io/inappwebview-the-real-power-of-webviews-in-flutter/",
  //               initialData:InAppWebViewInitialData( data: widget.htmlCont),
  //               initialOptions: options,
  //               initialHeaders: {
  //
  //               },
  //
  //               onWebViewCreated: (InAppWebViewController controller) {
  //                 webViewController = controller;
  //               },
  //               onLoadStart: (InAppWebViewController controller, String url) {
  //
  //                 print("started $url");
  //                 //
  //                 // setState(() {
  //                 //   this.url = url;
  //                 // });
  //               },
  //
  //
  //
  //               // onLoadStop: (InAppWebViewController controller, String url) async {
  //               //   setState(() {
  //               //     this.url = url;
  //               //   });
  //               // },
  //
  //
  //               // shouldOverrideUrlLoading: (controller, navigationAction) async {
  //               //   var url = navigationAction.url;
  //               //   Uri uri = Uri.parse(url);
  //               //
  //               //
  //               //
  //               //   if (!url.startsWith("tel:")) {
  //               //
  //               //     String memberid = uri.queryParameters['MemID'];
  //               //
  //               //     String server = uri.authority;
  //               //     String path = uri.path;
  //               //     String protocol = uri.scheme;
  //               //
  //               //     if (memberid != null && !url.contains("Commlink") && !path.toLowerCase().contains("ViewProfile.aspx".toLowerCase())) {
  //               //
  //               //       /*  Intent intent = new Intent(DetailActivity.this , SingleMemberProfileActivity.class);
  //               //   intent.putExtra("memid", memberid);
  //               //   startActivity(intent);*/
  //               //     }
  //               //   }
  //               //
  //               //   if(url.startsWith("tel:")){
  //               //
  //               //     if(Platform.isIOS){
  //               //       _makePhoneCall(url);
  //               //
  //               //     }else if(Platform.isAndroid){
  //               //
  //               //       android_intent.Intent()
  //               //         ..setAction(android_action.Action.ACTION_DIAL)
  //               //         ..setData(Uri.parse(url))
  //               //         ..startActivity();
  //               //     }
  //               //
  //               //   }else if(Uri.parse(url).scheme == "market"){
  //               //
  //               //     try{
  //               //       android_intent.Intent()
  //               //         ..setAction(android_action.Action.ACTION_VIEW)
  //               //         ..setData(Uri.parse(url))
  //               //         ..startActivity();
  //               //
  //               //     }catch(ex){
  //               //
  //               //       url = url+ DateTime.fromMicrosecondsSinceEpoch(1546553448639).toString();
  //               //       Uri uri1 = Uri.parse(url);
  //               //       webViewController.loadUrl(url : "http://play.google.com/store/apps/" + uri1.host.toString()+ "?" + uri1.query.toString());
  //               //     }
  //               //
  //               //
  //               //   }else if (url.endsWith(".jpg") || url.endsWith(".jpeg")
  //               //       || url.endsWith(".png")) {
  //               //
  //               //     android_intent.Intent()
  //               //       ..setAction(android_action.Action.ACTION_VIEW)
  //               //       ..setData(Uri.parse(url))
  //               //       ..setType("image/*")
  //               //       ..startActivity();
  //               //
  //               //   }else if (url.endsWith(".pdf?typ=1")) {
  //               //     String doc = "<iframe src='http://docs.google.com/viewer?url=" + url.substring(0, url.length - 6) + "&embedded=true' "
  //               //         + "width='100%' height='100%' "
  //               //         + "style='border: none;'></iframe>";
  //               //
  //               //     webViewController.loadData(data: doc, mimeType: "text/html", encoding:"UTF-8" , baseUrl: "" , androidHistoryUrl: "");//("http://docs.google.com/gview?embedded=true&url=" + url);
  //               //
  //               //   } else if (url.endsWith(".pdf?typ=2")) {
  //               //     /* hideFullLoading();
  //               //       downloadImages(url.substring(0, url.length() - 6), "Downloading PDF");
  //               //       hideFullLoading();*/
  //               //   }else if (url.endsWith("typ=browse")) {
  //               //
  //               //     // Log.e( "url overriding" , url+" "+memberid);
  //               //
  //               //     String doc = "<iframe src='http://docs.google.com/viewer?url=" + url.substring(0, url.length - 6) + "&embedded=true' "
  //               //         + "width='100%' height='100%' "
  //               //         + "style='border: none;'></iframe>";
  //               //     //view.loadData("http://docs.google.com/gview?embedded=true&url="+url,"text/html",  "UTF-8");//("http://docs.google.com/gview?embedded=true&url=" + url);
  //               //
  //               //     android_intent.Intent()
  //               //       ..setAction(android_action.Action.ACTION_VIEW)
  //               //       ..setData(Uri.parse(url))
  //               //       ..startActivity();
  //               //
  //               //     // return ;
  //               //   }
  //               //
  //               //    webViewController.loadUrl(url: url);
  //               //
  //               // },
  //
  //               onProgressChanged: (InAppWebViewController controller, int progress) {
  //                 setState(() {
  //                   this.progress = progress/100;
  //                 });
  //               },
  //             ),
  //           ) ,
  //
  //         ]
  //     ),
  //
  //     ),
  //
  //   );
  // }
}