import 'package:flutter/material.dart';
import 'package:world_time_app/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  String time='loading';

  /*--
  Whenever there is change in data for instance by using 'setState()' function, that triggers the
  build function to rebuild that widget so that it can get updated on screen.
  Stateful widget also have couple of lifecycle widgets we can tap into.
  1. initState() - called only once when the widget is first created. Also a good place to
  subscribe to string and any kind of objects that could change our widget data in future.
  2. Build() - It builds the widget tree. And it runs quite a lot in stateless widget because it runs
  every time we use a setState().
  3. Dispose() - triggered when a widget or a state objects is completely removed.
  */

  //Asynchronous function is transferred to its own class 'world_time.dart' from here
  //for making it reusable and making our project more modular.

  void setupWorldTime() async{
    WorldTime instance = WorldTime(location: 'Kolkata', flag: 'India.png', url: 'Asia/Kolkata');
    await instance.getTime();
//    print(instance.time);
    Navigator.pushReplacementNamed(context, '/home',arguments: {
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'isDayTime': instance.isDayTime,
      /* -- We pass 'argument:'( which is a map ) as third parameter to send the data to the screen or
      widget to which we route to. It is basically a named parameter. And this map is going to be a set
      of key value pass that we can pass through into the widget or screen to which we route to
      which in this case will be send to build function of home.dart or in simple word data will be send
      to home screen.
       */
    });
}

  @override
  void initState() {
    super.initState();
    setupWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Center(
        child: SpinKitFoldingCube(
          color: Colors.white,
          size: 50.0,
        ),
      ),
    );
  }
}
