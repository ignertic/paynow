import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:paynow/paynow.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
        primarySwatch: Colors.blue,
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
  int _counter = 0;
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
  String _status = "";

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
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
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
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
              'Ecocash Flutter Demo:',
            ),
            TextField(
              decoration: InputDecoration(
                icon: Icon(Icons.phone),
                hintText: "Phone Number"
              ),
              keyboardType: TextInputType.phone,
              controller: _phoneController,

            ),
            TextField(
              decoration: InputDecoration(
                hintText: "5.00",
                icon: Icon(Icons.monetization_on)
              ),
              keyboardType: TextInputType.number,
              controller: _amountController,

            ),
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

                Paynow paynow = Paynow(integrationKey: "960ad10a-fc0c-403b-af14-e9520a50fbf4", integrationId: "6054", returnUrl: "http://google.com", resultUrl: "http://google.co");

                Payment payment = paynow.createPayment(DateTime.now().toString(), "user@email.com");

                payment.add("Banana", double.parse(_amountController.text));

                paynow.onDone = (response){
                  // Future.delayed(duration);
                  print("Checking Transaction Status");
                  paynow.checkTransactionStatus(response['pollurl']);
                };


                paynow.onCheck = (StatusResponse response){
                  setState(() {
                      _status = response.status;
                  });
                };

                paynow.sendMobile(payment, _phoneController.text, "ecocash");
              },
              // initialTimer: 10,
              child: Text(
                "PAY",
                style: TextStyle(
                    color: Colors.black,
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
              color: Colors.transparent,
              elevation: 0,
              borderSide: BorderSide(color: Colors.black, width: 1.5),
            ),
            SizedBox(height: 10,),
            Row(
              children: <Widget>[
                Text("Transaction  Details", style: TextStyle(color: Colors.blue)),

                Text(_status, style: TextStyle(color: Colors.green, fontSize: 49),)
              ],
            )

          ],
        ),
      ),
       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
