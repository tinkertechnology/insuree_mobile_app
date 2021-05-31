import 'package:flutter/material.dart';
import 'colors.dart';

class CustomTheme{
	static ThemeData get lightTheme {
		return ThemeData(
			primaryColor: CustomColors.LightGreen,
			splashColor: CustomColors.LightGreen1,
			accentColor: CustomColors.LightGreen2,
			scaffoldBackgroundColor: Colors.white,
			fontFamily: 'Montserrat',
			buttonTheme: ButtonThemeData(
				shape: RoundedRectangleBorder(
					borderRadius: BorderRadius.circular(18.0)
				),
				buttonColor: CustomColors.BlueDark
			)
		);
	}
}