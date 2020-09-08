import 'dart:convert';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
class WorldTime{
  String location;   //location name for the UI.
  String time;    //the time in that location.
  String flag;    //url to an asset flag icon.
  String url;    //this is location url for an api endpoints.
  bool isDayTime;

  WorldTime({this.location, this.flag, this.url});
  // We use 'Future<>' before getTime async function. It tells dart that it will temporarily
  // gonna return, what's known as a Future.So Future is a bit like 'promise' in javascript
  // and it means that it is a temporary placeholder value until the function is complete.
  // So if we want to use 'await' on custom function like 'getTime()' in 'loading.dart' we have
  // to put type of 'Future' in front of our asynchronous function.
  Future<void> getTime() async {
    /* Simulating network request for a username. Now imagine this to be an API endpoint which returns
    string and take 3 seconds. Same thing we're doing by using Future.delayed().
    We use 'await' keyword when we need certain statement to be executed only when another statement
    is processed. For example, In the example used below it doesn't make sense to get the bio data
    without having the username.
    Also another good significance of an 'await' keyword is that we can assign value to it.
    Note: Because we set this function as asynchronous it will create a delay for its inbuilt functions
    and calls only. It won't affect execution of any function outside this function. It means that any
    function outside the scope of asynchronous function won't wait for it to complete before they runs.
    We will use asynchronous coding in future when we use third party API to get data for different projects.
    */

    try{
      //make the request
      Response response= await get('http://worldtimeapi.org/api/timezone/$url');
      Map data =jsonDecode(response.body);
//    print(data);

      //get properties from data
      String datetime= data['datetime'];
      String offset_1 = data['utc_offset'].substring(1,3);
      String offset_2 = data['utc_offset'].substring(4,6);

//    print(datetime);
//    print(offset_1);
//    print(offset_2);
      //Create DateTime object in dart
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset_1), minutes: int.parse(offset_2)));
      //Set the time property
      isDayTime = now.hour>6 && now.hour<19 ? true : false;
      time = DateFormat.jm().format(now);
      /*This line format the time using .jm and .format method and we get that by installing(from pub.dev)
      and importing 'package:intl/intl.dart' package. This give us an updated format which looks lot
      better.
      */
//    print(now);

//    Examples for understanding the concept--
//    String name= await Future.delayed(Duration(seconds: 3), () {
//      return 'yoshi';
//    });
//
//    // Simulating network request to get bio of the username
//    String bio = await Future.delayed(Duration(seconds: 2), () {
//      return 'vegan, musician and skydiver';
//    });
//
//    print('$name - $bio');
/*  Response response = await get('https://jsonplaceholder.typicode.com/todos/1');
  Map data = jsonDecode(response.body);
  print(data);
  print(data['title']);  */
      /*-- Response type here is given to us by the  http module and this is going to contain information
  about this response which we get from above request in get(). We use get function after importing
  'http/http.dart' package.
  Explanation of line 47-50:
  This get() functions goes out and gets the data from end point and we 'await' the response
  of that and stores it in 'response' object of type 'Response'. On that response object
  we have body property and that body property is the actual 'json' string tha we get back from url.
  Then we decode the json string into 'map' stored in data object/variable. And then print that data
  and then title property from the data.
   */
    }
    catch(e){
      print('caught error : $e');
      time='could not get time data';
    }

  }
}