import 'package:flutter/material.dart';

// --------------------------- color variable -----------------------------------------
const secondaryColor = Color.fromRGBO(173, 0, 255, 1);
const linkColor = Color.fromRGBO(107, 142, 194, 1);
// const linearGradientColor = LinearGradient(
//   colors: [Color.fromRGBO(173, 0, 255, 1), Color.fromRGBO(255, 0, 229, 0.88)],
//   begin: Alignment.topRight,
//   end: Alignment.bottomLeft,
// );

//-------------------------- font variable ----------------------------------
const primaryFontStyle = TextStyle(fontSize: 14, fontFamily: 'Roboto');
const secondaryFontStyle =
    TextStyle(fontSize: 16, fontFamily: 'Roboto', fontWeight: FontWeight.bold);
const titleAppBarFontStyle =
    TextStyle(fontSize: 20, fontFamily: 'Roboto', fontWeight: FontWeight.bold);
const filterTitleFontStyle = TextStyle(
    fontSize: 14,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.bold,
    color: Colors.white);
const landingLabelStyle = TextStyle(fontSize: 30, fontFamily: 'Lancelot');
const buttonLabelStyle =
    TextStyle(fontSize: 12, fontFamily: 'Roboto', fontWeight: FontWeight.w700);
const ratingLabelStyle = TextStyle(
    fontSize: 12, fontFamily: 'Roboto', fontWeight: FontWeight.normal);
const linkLabelStyle = TextStyle(
    fontSize: 14,
    fontFamily: 'Roboto',
    color: linkColor,
    decoration: TextDecoration.underline,
    decorationThickness: 1.5);
const errorMessageStyle =
    TextStyle(color: Colors.red, fontSize: 14, fontFamily: 'Roboto');
const hintStyle = TextStyle(fontSize: 12, fontFamily: 'Roboto');
const logoLabel =
    TextStyle(fontSize: 22, fontFamily: 'SecularOne', color: Colors.black);
const modalContent = TextStyle(fontSize: 14, fontFamily: 'Roboto', height: 1.5);
const boldContentTitle =
    TextStyle(fontSize: 14, fontFamily: 'Roboto', fontWeight: FontWeight.bold);
const categoryText = TextStyle(
  fontSize: 10,
  fontFamily: 'Roboto',
  fontWeight: FontWeight.normal,
  color: Colors.white,
);

//-------------------------- reg expression ------------------------------------
String emailReg =
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
String phoneReg = r"^(+?6?01)[0-46-9]-*[0-9]{7,8}";
