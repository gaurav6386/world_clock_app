import 'package:flutter/material.dart';
import 'package:world_time_app/pages/choose_location.dart';
import 'package:world_time_app/pages/loading.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data={};


  @override
  Widget build(BuildContext context) {
    /*(Inside the build function)This is where we'll receive the actual argument which we send
    over from 'loading.dart' line31. And the way we do that(receive it) is by using
    ModalRoute.of(context).settings.arguments;
    1. (context) is the reason we need to do this in build method to get that context.
    2. .arguments- is the argument which we receive from 'loading.dart' which returns maps
       of data.
    3. We might think why we don't use a setState(). We don't have to use setState() yet because
       this is the first time the setState() runs and we are declaring this data and overriding the
       line12 before we even return anything. So we're doing it first and then we're building up the
       widget tree.
    */

    /*
    When we're updating time from the choose_location page we're not actually rebuilding this
    widget so 'ModalRoute.of(context).settings.arguments' i,e. line 34 will not get called.
    So now in case of updating time, we are 'popping' something backoff.
    Also to get the updated data(from setState() function on line74) we will use 'isNotEmpty'
    function for map 'data' to apply the logic to prevent 'ModalRoute.of(context).settings.arguments'
    from executing again which overriding data to its initial state.
    */

    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    print(data);

    String bgimg= data['isDayTime']? 'day.jpg': 'night.jpg';
    Color bgcolor = data['isDayTime'] ? Colors.blue[300] : Colors.grey[800];

    return Scaffold(
      backgroundColor: bgcolor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/$bgimg'),
              fit: BoxFit.cover,
            )
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0,120,0,0),
            child: Column(
              children: <Widget>[
                FlatButton.icon(
                  onPressed: () async {
                    /*
                    In here we are directing ourselves to choose_location page. We can think of
                    this whole action, of us going to the 'cho...ation' screen and choosing something,
                    getting the data back and popping back to this screen, we can think of all
                    that as one big action which takes some time to do. This 'takes some time to
                    do' remind us of 'async'  keywords. So we can think of as one big asynchronous
                    task. So we'll use await keyword to wait for all this to happen and store it in
                    variable.
                    Then to actually show the changes we'll use 'setState()' to apply the changes
                    in data that we did/choose on 'choose_location' page. But when using setState()
                    function the page rebuild itself and that will make it execute line34
                    and that is a problem because all the 'changes we did to data'/ 'overriden the data'
                    on 'choose_location' page is overridden again to the initial data.
                    We don't want that so will apply condition to get the updated data.
                     */
                    dynamic result = await Navigator.pushNamed(context,'/location');
                    setState(() {
                      //Note: data is a map. And we're using named parameter properties to change the data
                      data = {
                        'time': result['time'],
                        'location': result['location'],
                        'isDayTime': result['isDayTime'],
                        'flag': result['flag']
                      };
                    });
                  },
                  icon: Icon(
                    Icons.edit_location,
                    color: Colors.grey[200],
                  ),
                  label: Text(
                    'Edit Location',
                    style: TextStyle(
                      color: Colors.grey[300],
                    ),
                  ),
                ),
                SizedBox(height: 20.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      data['location'],
                      style: TextStyle(
                        fontSize: 20.0,
                        letterSpacing: 2.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Text(
                  data['time'],
                  style: TextStyle(
                    fontSize: 66.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
