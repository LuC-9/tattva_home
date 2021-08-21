import 'package:flutter/services.dart';
import 'package:tattva_home/credentials.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';


import 'package:flutter/material.dart';

// Define a custom Form widget.
import 'package:flutter/material.dart';
import 'package:tattva_home/deviceRegistration.dart';

void main() => HomePage();

class HomePage extends StatelessWidget {


  @override


  Widget build(BuildContext context) {


    final appTitle = 'Form Validation Demo';


    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),
        body: MyCustomForm(),
      ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final RoomName = TextEditingController();
  final deviceName = TextEditingController();
  final deviceType = TextEditingController();

  /*getItemAndNavigate(BuildContext context){
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SecondScreen(
                nameHolder : name.text,
                classHolder : studentClass.text,
                numberHolder : phoneNumber.text
            ))
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            children: <Widget>[

              Container(
                  width: 280,
                  padding: EdgeInsets.all(10.0),
                  child: TextField(
                    controller: RoomName,
                    autocorrect: true,
                    decoration: InputDecoration(hintText: 'Enter RoomName'),
                  )
              ),

              Container(
                  width: 280,
                  padding: EdgeInsets.all(10.0),
                  child: TextField(
                    controller: deviceName,
                    autocorrect: true,
                    decoration: InputDecoration(hintText: 'Enter deviceName'),
                  )
              ),

              Container(
                  width: 280,
                  padding: EdgeInsets.all(10.0),
                  child: TextField(
                    controller: deviceType,
                    autocorrect: true,
                    decoration: InputDecoration(hintText: 'Enter deviceType'),
                  )
              ),

              ElevatedButton(
                onPressed:()=>  confirm(RoomName.text.trim(), deviceName.text.trim(), deviceType.text.trim()).main(),
                //color: Color(0xffFF1744),
                //textColor: Colors.white,
                //padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Text('Submit'),
              ),

            ],
          ),
        ));
  }
}















