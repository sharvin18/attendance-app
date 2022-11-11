import 'package:flutter/material.dart';
import 'dart:ui';

var textColor;
var bgColor;
var iconColor;
var bgCardColor;
var textSnack;
var bgSnack;
var cardDark;
var cardLight;
var dividerColor;

var flourescentBlue1 = Color(0XFF00C2BA);
var flourescentBlue2 = Color(0XFF79FFFE);
var blue1 = Color(0XFF189CC4);
var blue2 = Colors.blue[200];

var flourescentGreen1 = Color(0XFF7FFF00);
var flourescentGreen2 = Color(0XFFB8FB3C);
var green1 = Colors.green[500];
var green2 = Colors.green[200];

var flourescentOrange1 = Color(0XFFFF5F01);
var flourescentOrange2 = Color(0XFFFFAA01);
var orange1 = Colors.orange[500];
var orange2 = Colors.orange[200];

var flourescentYellow1 = Color(0XFFFFCC33);
var flourescentYellow2 = Color(0XFFFFFF76);
var yellow1 = Color(0XFFFFFF14);
var yellow2 = Color(0XFFFFFF76);

appTheme(String themeType){

	if(themeType == "dark"){

		textColor = Color(0XFFffffff);   // white text
		bgColor = Color(0XFF000000);  // perfect black color
		iconColor = Color(0XFFffffff);  //white icon
		bgCardColor = Color(0XFF2d2e2d);  // black shade bg
		textSnack = Color(0XFF000000);
		bgSnack = Color(0XFFffffff);
		dividerColor = Colors.grey;

		cardDark = flourescentBlue1;
		cardLight = flourescentBlue2;

	}else{

		textColor = Color(0XFF000000);  // perfect black color
		bgColor = Color(0XFFffffff);    // white bg
		iconColor = Color(0XFF292828);  // black Icon
		bgCardColor = Color(0XFFffffff);  // card white bg
		textSnack = Color(0XFFffffff);
		bgSnack = Color(0XFF000000);
		dividerColor = Colors.grey[200];

		cardDark = blue1;
		cardLight = blue2;
	}
}

