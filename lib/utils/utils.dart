import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teams/api/api.dart';
import 'package:teams/bloc/home_bloc/home_cubit.dart';
import 'package:teams/bloc/invited_bloc/invited_cubit.dart';
import 'package:teams/utils/const.dart';
import 'package:teams/views/home_screen/home_page.dart';
import 'package:teams/views/home_screen/home_tab_page.dart';
import 'package:teams/views/home_screen/invite_screen/invite_page.dart';

// dim
height(context) => MediaQuery.of(context).size.height;
width(context) => MediaQuery.of(context).size.width;

// named route navigation functions
formshow(context, routeName) => Navigator.pushNamed(context, routeName);
// formshowReplace(context, routeName) =>
//     Navigator.pushReplacementNamed(context, routeName);
// formshowData(context, routeName, arg) =>
//     Navigator.pushNamed(context, routeName, arguments: arg);
// formshowReplaceData(context, routeName, arg) =>
//     Navigator.pushReplacementNamed(context, routeName, arguments: arg);
// formshowUntil(context, routeName) =>
//     Navigator.pushNamedAndRemoveUntil(context, routeName, (route) => false);
goBack(context) => Navigator.pop(context);

// custom router
class MyRouter {
  ApiHandler apiHandler = ApiHandler();
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return CupertinoPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => HomeCubit(repository: apiHandler),
                  child: const HomeTabControllerPage(),
                ));

      case inviteRoute:
        return CupertinoPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => InvitedCubit(repository: apiHandler),
            child: const InvitePage(),
          ),
        );
      default:
        null;
    }
    return null;
  }
}

String getInitial({String? string, int? limitTo}) {
  if (!string!.contains('null')) {
    var buffer = StringBuffer();
    var split = string!.split(' ');
    try {
      for (var i = 0; i < (limitTo ?? split.length); i++) {
        buffer.write(split[i][0]);
      }
    } on Exception catch (e) {
      // TODO
    }
    return buffer.toString();
  } else {
    return 'UN';
  }
}

// check internet connection
isConnected() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    //  mobile network.
    return true;
  } else if (connectivityResult == ConnectivityResult.wifi) {
    //  wifi network.
    return true;
  }
  return false;
}

// local storage
setSharedValue(key, value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);
  return true;
}

setSharedBoolValue(key, value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool(key, value);
  return true;
}

getSharedValue(key) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(key);
}

getSharedBoolValue(key) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool(key);
}

clearSharedValues() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();
}

emailValidator(email) => RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
    .hasMatch(email);
