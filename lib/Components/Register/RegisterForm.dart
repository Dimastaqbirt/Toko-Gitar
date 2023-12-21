import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:toko_gitar_flutter/API/configAPI.dart';
import 'package:toko_gitar_flutter/Components/custom_surfix_icon.dart';
import 'package:toko_gitar_flutter/Components/default_button_custome_color.dart';
import 'package:toko_gitar_flutter/Screens/Login/LoginScreens.dart';
import 'package:toko_gitar_flutter/Screens/Register/Registrasi.dart';
import 'package:toko_gitar_flutter/size_config.dart';
import 'package:toko_gitar_flutter/utils/constants.dart';

class SignUpform extends StatefulWidget {
  @override
  _SignUpform createState() => _SignUpform();
}

class _SignUpform extends State<SignUpform> {
  final _formKey = GlobalKey<FormState>();
  String? namalengkap;
  String? username;
  String? email;
  String? password;
  bool? remeber = false;

  TextEditingController txtNamaLengkap = TextEditingController(),
      txtUserName = TextEditingController(),
      txtEmail = TextEditingController(),
      txtPassword = TextEditingController();

  FocusNode focusNode = new FocusNode();

  Response? response;
  final dio = Dio();

  @override
  void initState() {
    super.initState();
    // prosesRegistrasi();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
      children: [
        buildNamaLengkap(),
        SizedBox(height: getProportionateScreenHeight(30)),
        buildUserName(),
        SizedBox(height: getProportionateScreenHeight(30)),
        buildEmail(),
        SizedBox(height: getProportionateScreenHeight(30)),
        buildPassword(),
        SizedBox(height: getProportionateScreenHeight(30)),
        DefaultButtonCustomeColor(
            color: kPrimaryColor,
            text: "Register",
            press: () {
              prosesRegistrasi(txtUserName.text, txtPassword.text,
                  txtNamaLengkap.text, txtEmail.text);
            }),
        SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, LoginScreen.routeName);
          },
          child: Text(
            "Sudah Punya Akun? Masuk Disini",
            style: TextStyle(decoration: TextDecoration.underline),
          ),
        )
      ],
    ));
  }

  TextFormField buildNamaLengkap() {
    return TextFormField(
      controller: txtNamaLengkap,
      style: mTitleStyle,
      decoration: InputDecoration(
          labelText: 'Nama Lengkap',
          hintText: 'Masukan Nama Lengkap anda',
          labelStyle: TextStyle(
              color: focusNode.hasFocus ? mSubtitleColor : kPrimaryColor),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSurffixIcon(
            svgIcon: "assets/icons/User.svg",
          )),
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

  TextFormField buildEmail() {
    return TextFormField(
      controller: txtEmail,
      keyboardType: TextInputType.text,
      style: mTitleStyle,
      decoration: InputDecoration(
          labelText: 'Email',
          hintText: 'Masukan Email anda',
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

  void prosesRegistrasi(userName, password, nama, email) async {
    try {
      setState(() {
        // Menampilkan loading
        utilsApps.showDialog(context);
      });

      response = await dio.post(urlRegister, data: {
        "username": userName,
        "password": password,
        "nama": nama,
        "email": email,
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
          desc: 'Anda Berhasil Registrasi',
          // btnCancelOnPress: () {},
          btnOkOnPress: () {
            utilsApps.hideLoading(context);

            //kembali ke halaman login
            Navigator.pushNamed(context, LoginScreen.routeName);
          },
        )..show();
      } else {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'Peringatan',
          desc: 'Gagal Registrasi  $msg',
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
