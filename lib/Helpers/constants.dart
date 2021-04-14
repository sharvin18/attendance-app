import 'package:flutter/material.dart';
import 'dart:ui';

var textColor;
var bgColor;
var iconColor;
var bgCardColor;
var textSnack;
var bgSnack;
var card1Dark;
var card1Light;
var card2Dark;
var card2Light;
var card3Dark;
var card3Light;
var card4Dark;
var card4Light;
var dividerColor;

var flourescentBlue1 = Color(0XFF00C2BA);
//var flourescentBlue1 = Color(0XFF189CC4);
var flourescentBlue2 = Color(0XFF79FFFE);
// var blue1 = Colors.blue[500];
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

var flourescentPurple1 = Color(0XFF8A2BE2);
var flourescentPurple2 = Color(0XFFE936A7);
var purple1 = Colors.purple[500];
var purple2 = Colors.purple[200];

var yellow1 = Color(0XFFFFFF14);
var yellow2 = Color(0XFFFFFF76);
appTheme(String themeType){

	if(themeType == "dark"){

		textColor = Color(0XFFffffff);   // white text
		//bgColor = Color(0XFF363534);
		bgColor = Color(0XFF000000);  // perfect black color
		//bgColor = Color(0XFF212121);
		iconColor = Color(0XFFffffff);  //white icon
		bgCardColor = Color(0XFF2d2e2d);  // black shade bg
		textSnack = Color(0XFF000000);
		bgSnack = Color(0XFFffffff);
		dividerColor = Colors.grey;

		card1Dark = flourescentBlue1;
		card1Light = flourescentBlue2;
		card2Dark = flourescentGreen1;
		card2Light = flourescentGreen2;
		card3Dark = flourescentOrange1;
		card3Light = flourescentOrange2;
		card4Dark = flourescentPurple1;
		card4Light = flourescentPurple1;

	}else{

		textColor = Color(0XFF000000);  // perfect black color
		bgColor = Color(0XFFffffff);    // white bg
		iconColor = Color(0XFF292828);  // black Icon
		bgCardColor = Color(0XFFffffff);  // card white bg

		textSnack = Color(0XFFffffff);
		bgSnack = Color(0XFF000000);
		dividerColor = Colors.grey[200];

		card1Dark = blue1;
		card1Light = blue2;
		card2Dark = green1;
		card2Light = green2;
		card3Dark = orange1;
		card3Light = orange2;
		card4Dark = yellow1;
		card4Light = yellow2;
	}
}

