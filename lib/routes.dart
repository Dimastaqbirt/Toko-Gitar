import 'package:flutter/material.dart';
import 'package:toko_gitar_flutter/Screens/Login/LoginScreens.dart';
import 'package:toko_gitar_flutter/Screens/Register/Registrasi.dart';
import 'package:toko_gitar_flutter/Screens/User/HomeUserScreens.dart';

final Map<String, WidgetBuilder> routes = {
  //login 
  LoginScreen.routeName: (context) => LoginScreen(),
  RegisterScreen.routeName: (context) => RegisterScreen(),

  //User
  HomeUserScreen.routeName:(context) => HomeUserScreen()

};
