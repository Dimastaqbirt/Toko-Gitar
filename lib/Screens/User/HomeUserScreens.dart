import 'package:flutter/material.dart';
import 'package:toko_gitar_flutter/Components/Register/RegisterComponent.dart';
import 'package:toko_gitar_flutter/size_config.dart';

class HomeUserScreen extends StatelessWidget {
  static String routeName = "/home_user";

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      // body: RegistrasiComponent(),
      body: Container(child: Text('SELAMAT DATANG DI APLIKASI GITAR')),
    );
  }
}
