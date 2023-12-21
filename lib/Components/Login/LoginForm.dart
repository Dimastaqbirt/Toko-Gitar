// import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:toko_gitar_flutter/API/configAPI.dart';
import 'package:toko_gitar_flutter/Components/custom_surfix_icon.dart';
import 'package:toko_gitar_flutter/Components/default_button_custome_color.dart';
import 'package:toko_gitar_flutter/Screens/Login/Register/Registrasi.dart';
import 'package:toko_gitar_flutter/size_config.dart';
import 'package:toko_gitar_flutter/utils/constants.dart';

class SignInform extends StatefulWidget {
  @override
  _SignInform createState() => _SignInform();
}

class _SignInform extends State<SignInform> {
  final _formKey = GlobalKey<FormState>();
  String? username;
  String? password;
  bool? remeber = false;

  TextEditingController txtUserName = TextEditingController(),
      txtPassword = TextEditingController();

  FocusNode focusNode = new FocusNode();

  Response? response;
  var dio = Dio();

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          buildUserName(),
          SizedBox(height: getProportionateScreenHeight(30)),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPassword(),
          Row(
            children: [
              Checkbox(
                  value: remeber,
                  onChanged: (value) {
                    setState(() {
                      remeber = value;
                    });
                  }),
              Text("Tetap Masuk"),
              Spacer(),
              GestureDetector(
                onTap: () {},
                child: Text(
                  "Lupa Password",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          DefaultButtonCustomeColor(
            color: kPrimaryColor,
            text: "MASUK",
            press: () {
              prosesLogin(txtUserName.text, txtPassword.text);
            },
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, RegisterScreen.routeName);
            },
            child: Text(
              "Belum Punya Akun? Daftar Disini",
              style: TextStyle(decoration: TextDecoration.underline),
            ),
          )
        ],
      ),
    );
  }

  TextFormField buildUserName() {
    return TextFormField(
      controller: txtUserName,
      keyboardType: TextInputType.text,
      style: mTitleStyle,
      decoration: InputDecoration(
          labelText: 'Username',
          hintText: 'Masukan username anda',
          labelStyle: TextStyle(
              color: focusNode.hasFocus ? mSubtitleColor : kPrimaryColor),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSurffixIcon(
            svgIcon: "assets/icons/User.svg",
          )),
    );
  }

  TextFormField buildPassword() {
    return TextFormField(
      controller: txtPassword,
      obscureText: true,
      style: mTitleStyle,
      decoration: InputDecoration(
          labelText: 'Password',
          hintText: 'Masukan password anda',
          labelStyle: TextStyle(
              color: focusNode.hasFocus ? mSubtitleColor : kPrimaryColor),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSurffixIcon(
            svgIcon: "assets/icons/User.svg",
          )),
    );
  }

  void prosesLogin(userName, password) async {
    try {
      setState(() {
        // Menampilkan loading
        utilsApps.showDialog(context);
      });

      response = await dio.post(urlLogin, data: {
        "username": userName,
        "password": password,
      });

      // Menyembunyikan loading setelah mendapatkan respons
      utilsApps.hideLoading(context);

      // Memeriksa respons dari server
      bool status = response!.data['sukses'];
      String msg = response!.data['msg'];

      if (status) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          title: 'Selamat',
          desc: 'Anda Berhasil Login',
          // btnCancelOnPress: () {},
          btnOkOnPress: () {
            utilsApps.hideLoading(context);

            //kembali ke halaman login
            // Navigator.pushNamed(context, LoginScreen.routeName);
          },
        )..show();
      } else {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'Peringatan',
          desc: 'Gagal Logini  $msg',
          // btnCancelOnPress: () {},
          btnOkOnPress: () {
            utilsApps.hideLoading(context);
          },
        )..show();
      }
    } catch (e) {
      // Menyembunyikan loading jika terjadi kesalahan

      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Peringatan',
        desc: 'Terjadi Kesalahan Pada Server',
        // btnCancelOnPress: () {},
        btnOkOnPress: () {
          utilsApps.hideLoading(context);
        },
      )..show();
    }
  }
}
