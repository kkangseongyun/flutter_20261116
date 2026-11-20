import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';

class PlatformScreen extends StatefulWidget {
  @override
  PlatformScreenState createState() => PlatformScreenState();
}

class PlatformScreenState extends State<PlatformScreen> {
  String? resultMessage;
  String? receiveMessage;

  Future<Null> callNative() async {
    var channel = BasicMessageChannel<String>(
      "myMessageChannel",
      StringCodec(),
    );
    //데이터 전송.. 결과 리턴..
    String? result = await channel.send("Hello, I am Dart");
    setState(() {
      resultMessage = result;
    });

    //데이터 수신..
    channel.setMessageHandler((String? message) async{
      setState(() {
        receiveMessage = message;
      });
      return "return data";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Channel Test")),
      body: Center(child: Column(children: (<Widget>[
        Text('$resultMessage'),
        Text('$receiveMessage'),
        ElevatedButton(onPressed: callNative, child: Text('native')),
      ]))),
    );
  }
}
