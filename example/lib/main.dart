import 'dart:async';
import 'dart:math';

import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:paynow/keys.dart';
import 'package:paynow/paynow.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Paynow',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.

      ),
      home: MyHomePage(title: 'Flutter Paynow Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  TextEditingController _phoneController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
  String _status = "";
  List<GCircle> loaders = <GCircle>[];
  var parser = EmojiParser();



  @override
  void initState(){
    super.initState();
    // Timer.periodic(Duration(seconds: 5), (t){_animateLoaders();});
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: Colors.indigoAccent,

      appBar: AppBar(
        backgroundColor: Colors.greenAccent.withOpacity(.7),
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body:Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20, left: 20),
            child: Container(
              color: Colors.greenAccent.withOpacity(.5),
              child:Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: Column(
              // Column is also a layout widget. It takes a list of children and
              // arranges them vertically. By default, it sizes itself to fit its
              // children horizontally, and tries to be as tall as its parent.
              //
              // Invoke "debug painting" (press "p" in the console, choose the
              // "Toggle Debug Paint" action from the Flutter Inspector in Android
              // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
              // to see the wireframe for each widget.
              //
              // Column has various properties to control how it sizes itself and
              // how it positions its children. Here we use mainAxisAlignment to
              // center the children vertically; the main axis here is the vertical
              // axis because Columns are vertical (the cross axis would be
              // horizontal).
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Flutter Auto Webview',
                  style: TextStyle(
                    color: Colors.white
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.phone),
                    hintText: "Your Email",
                    hintStyle: TextStyle(
                      color: Colors.white
                    )
                  ),
                  cursorColor:Colors.white ,
                  keyboardType: TextInputType.phone,
                  controller: _phoneController,

                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: "5.00",
                    hintStyle: TextStyle(color:Colors.white),
                    icon: Icon(Icons.monetization_on)
                  ),
                  keyboardType: TextInputType.number,
                  controller: _amountController,

                ),
                SizedBox(height: 15,),
                ArgonTimerButton(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.45,
                  minWidth: MediaQuery.of(context).size.width * 0.30,
                  highlightColor: Colors.transparent,
                  highlightElevation: 0,
                  roundLoadingShape: false,
                  onTap: (startTimer, btnState) {
                    if (btnState == ButtonState.Idle) {
                      startTimer(15);
                    }



                    Paynow paynow = Paynow(context: context, integrationKey: INTEGRATION_KEY, integrationId: INTEGRATION_ID, returnUrl: "http://google.com", resultUrl: "http://google.co");
                    Payment payment = paynow.createPayment("donate", _phoneController.text ??  "pyzimos@gmail.com");

                    payment.add("Banana", 1.9);


                    // Initiate Payment
                    paynow.send(payment);
                  },

                  child: Text(
                    "PAY",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  ),
                  loader: (timeLeft) {
                    return Text(
                      "Wait | $timeLeft",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    );
                  },
                  borderRadius: 5.0,
                  color: Colors.greenAccent ,
                  elevation: 0,
                  borderSide: BorderSide(color: Colors.black, width: 1.5),
                ),
                SizedBox(height: 10,),
                Row(
                  children: <Widget>[
                    // Text("Transaction  Data", style: TextStyle(color:
                    // Colors.blue)),
                    Text("If you like this API, feel free to DONATE!!",
                    textAlign: TextAlign.center,
                     style:TextStyle(

                      fontWeight: FontWeight.w500,
                      color: Colors.white
                    )),
                    Text(_status, style: TextStyle(color: Colors.green, fontSize: 49),)
                    ,Text("${parser.get('coffee').code} <SuperCode/>")
                  ],
                )

              ],
            ),
          ))),
          Container(
            alignment: Alignment.centerLeft,
            child: Column(
              children: _buildLoaders()
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            child: Column(
              children: _buildLoaders()
            ),
          )
        ]
      ) ,
       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  List<GCircle>_buildLoaders() {
    this.loaders.clear();
    for(int i=0;i<3;i++){
      this.loaders.add(
        GCircle(Colors.black)
      );

    }
    return loaders;
  }


}


class GCircle extends StatefulWidget{
  Color color;
  GCircle(this.color);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _GCircle();
  }

  updateColor(Color color){
    this.color = color;
  }

}

class _GCircle extends State<GCircle>{

Color c = Colors.black87;
  @override
  void initState(){
    List<Color> colors = [Colors.black , Colors.greenAccent, Colors.cyan];
    Random random = Random();
    Timer.periodic(Duration(seconds: 2), (t){
      setState(() {
        this.c = colors[random.nextInt(colors.length)];
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Padding(
        padding: EdgeInsets.all(5),
        child: CircleAvatar(
          backgroundColor: c,
        ),
      )
    );
  }



}
