import 'package:flutter/material.dart';
import 'package:world_time_app/pages/choose_location.dart';
import 'package:world_time_app/pages/home.dart';
import 'package:world_time_app/pages/loading.dart';

void main() {
  runApp(MaterialApp(
    /*-- Instead of using 'home' property for testing purposes, which conflicts with routes property, we'll be using 'initialRoute' property which tells
    us or compiler which of the routes mentioned in 'routes' property are first going to load up when we open the app. by default it is the first route
    mentioned in 'routes' property. We can override this property by using 'initialRoutes'.
    */
    initialRoute: '/',
    /*-- We are creating route on MaterialApp() directly, using 'routes' property. And this property is going to be map. This map expects a 'keyvalue' pass.
    And the keys in this  route map are gonna be actual routes itself. The values to these different routes is gonna be functions and these function take 'context' object
    as an argument. This context objects basically keep track of where in the widget tree we are.
     --*/
    routes: {
      '/': (context) => Loading(),
      '/home': (context) => Home(),
      '/location': (context) => ChooseLocation(),
    },
  ));
}


