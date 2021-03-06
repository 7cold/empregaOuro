import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

const String fontHeavy = "FontHeavy";
const String fontBold = "FontBold";
const String fontLight = "FontLight";
const String fontMedium = "FontMedium";
const String fontRegular = "FontRegular"; //textos
const String fontSemiBold = "FontSemiBold";
const String fontThin = "FontThin";
const String fontUltraLight = "FontUltraLight";

//heavy

TextStyle fontHeavy24Grey = TextStyle(
  fontFamily: fontHeavy,
  color: Color(corCinza),
  fontSize: 24,
);

TextStyle fontHeavy24Dark = TextStyle(
  fontFamily: fontHeavy,
  color: Color(corDark),
  fontSize: 24,
);

TextStyle fontHeavy20White = TextStyle(
  fontFamily: fontHeavy,
  color: Color(corPrincipal),
  fontSize: 20,
);

TextStyle fontHeavy20Dark = TextStyle(
  fontFamily: fontHeavy,
  color: Color(corDark),
  fontSize: 20,
);

TextStyle fontHeavy20Grey = TextStyle(
  fontFamily: fontHeavy,
  color: Color(corCinza),
  fontSize: 20,
);

TextStyle fontHeavy18Grey = TextStyle(
  fontFamily: fontHeavy,
  color: Color(corCinza),
  fontSize: 18,
);

TextStyle fontHeavy18Dark = TextStyle(
  fontFamily: fontHeavy,
  color: Color(corDark),
  fontSize: 18,
);

TextStyle fontHeavy16Dark = TextStyle(
  fontFamily: fontHeavy,
  color: Color(corDark),
  fontSize: 16,
);

TextStyle fontHeavy14Dark = TextStyle(
  fontFamily: fontHeavy,
  color: Color(corDark),
  fontSize: 14,
);

//bold

TextStyle fontBold24Grey = TextStyle(
  fontFamily: fontBold,
  color: Color(corCinza),
  fontSize: 24,
);

TextStyle fontBold24Dark = TextStyle(
  fontFamily: fontBold,
  color: Color(corDark),
  fontSize: 24,
);

TextStyle fontBold18GreyPromo = TextStyle(
    fontFamily: fontBold,
    color: CupertinoColors.inactiveGray,
    fontSize: 18,
    decoration: TextDecoration.lineThrough);

TextStyle fontBold18Grey = TextStyle(
  fontFamily: fontBold,
  color: Color(corCinza),
  fontSize: 18,
);

TextStyle fontBold16Grey = TextStyle(
  fontFamily: fontBold,
  color: Color(corCinza),
  fontSize: 16,
);

TextStyle fontBold22Dark = TextStyle(
  fontFamily: fontBold,
  color: Color(corDark),
  fontSize: 22,
);

TextStyle fontBold22DarkAlt = TextStyle(
  fontFamily: fontBold,
  color: Color(corSecundaria2),
  fontSize: 22,
);

TextStyle fontBold22White = TextStyle(
  fontFamily: fontBold,
  color: Colors.white,
  fontSize: 22,
);

TextStyle fontBold20Dark = TextStyle(
  fontFamily: fontBold,
  color: Color(corDark),
  fontSize: 20,
);

TextStyle fontBold20Light = TextStyle(
  fontFamily: fontBold,
  color: Color(corPrincipal),
  fontSize: 20,
);

TextStyle fontBold16White = TextStyle(
  fontFamily: fontBold,
  color: Color(corPrincipal),
  fontSize: 16,
);

TextStyle fontBold16Dark = TextStyle(
  fontFamily: fontBold,
  color: Color(corDark),
  fontSize: 16,
);

TextStyle fontBold18Dark = TextStyle(
  fontFamily: fontBold,
  color: Color(corDark),
  fontSize: 18,
);
TextStyle fontBold18Light = TextStyle(
  fontFamily: fontBold,
  color: Color(corPrincipal),
  fontSize: 18,
);

TextStyle fontBold14Dark = TextStyle(
  fontFamily: fontBold,
  color: Color(corDark),
  fontSize: 14,
);
TextStyle fontBold14Grey = TextStyle(
  fontFamily: fontBold,
  color: Color(corCinza),
  fontSize: 14,
);

TextStyle fontBold14White = TextStyle(
  fontFamily: fontBold,
  color: Color(corPrincipal),
  fontSize: 14,
);

TextStyle fontBold14WhiteS = TextStyle(
  fontFamily: fontBold,
  color: Color(corPrincipal),
  fontSize: 14,
  shadows: <Shadow>[
    Shadow(
      offset: Offset(1, 1),
      blurRadius: 3.0,
      color: Color(corCinza),
    ),
  ],
);

TextStyle fontBold14DarkSpace = TextStyle(
  fontFamily: fontBold,
  color: Color(corDark),
  height: 0.9,
  fontSize: 14,
);

//Medium

TextStyle fontMedium14Dark = TextStyle(
  fontFamily: fontMedium,
  color: Color(corDark),
  fontSize: 14,
);
TextStyle fontMedium16Dark = TextStyle(
  fontFamily: fontMedium,
  color: Color(corDark),
  fontSize: 16,
);

//Regular

TextStyle fontRegular16Dark = TextStyle(
  fontFamily: fontRegular,
  color: Color(corDark),
  fontSize: 16,
);
TextStyle fontRegular14Dark = TextStyle(
  fontFamily: fontRegular,
  color: Color(corDark),
  fontSize: 14,
);
TextStyle fontRegular14Light = TextStyle(
  fontFamily: fontRegular,
  color: Colors.white,
  fontSize: 14,
);

TextStyle fontRegular16Grey = TextStyle(
  fontFamily: fontRegular,
  color: CupertinoColors.systemGrey,
  fontSize: 16,
);

TextStyle fontRegular16Light = TextStyle(
  fontFamily: fontRegular,
  color: Color(corPrincipal),
  fontSize: 16,
);

TextStyle fontRegular16Branco = TextStyle(
  fontFamily: fontLight,
  color: Colors.white,
  fontSize: 16,
);

TextStyle fontRegular18Dark = TextStyle(
  fontFamily: fontRegular,
  color: Color(corDark),
  fontSize: 18,
);

TextStyle fontRegular18Grey = TextStyle(
  fontFamily: fontRegular,
  color: CupertinoColors.systemGrey,
  fontSize: 18,
);

TextStyle fontRegular25White = TextStyle(
  fontFamily: fontRegular,
  color: Colors.white,
  fontSize: 25,
);

TextStyle fontRegular20White = TextStyle(
  fontFamily: fontRegular,
  color: Colors.white,
  fontSize: 20,
);

TextStyle fontRegular18White = TextStyle(
  fontFamily: fontRegular,
  color: Colors.white,
  fontSize: 18,
  shadows: [
    Shadow(
      color: Colors.black.withOpacity(0.6),
      offset: Offset(-1, -1),
      blurRadius: 8,
    ),
  ],
);

TextStyle fontRegular16White = TextStyle(
  fontFamily: fontRegular,
  color: Colors.white,
  fontSize: 16,
);

//light

TextStyle fontLight18White = TextStyle(
  fontFamily: fontLight,
  color: Color(corPrincipal),
  fontSize: 18,
);

TextStyle fontLight16White = TextStyle(
  fontFamily: fontLight,
  color: Color(corPrincipal),
  fontSize: 16,
);

TextStyle fontLight18Dark = TextStyle(
  fontFamily: fontLight,
  color: Color(corDark),
  fontSize: 18,
);

TextStyle fontLight16Dark = TextStyle(
  fontFamily: fontLight,
  color: Color(corDark),
  fontSize: 16,
);

TextStyle fontLight16Grey = TextStyle(
  fontFamily: fontLight,
  color: Color(corCinza),
  fontSize: 16,
);

TextStyle fontLight14Grey = TextStyle(
  fontFamily: fontLight,
  color: Color(corCinza),
  fontSize: 14,
);

TextStyle fontLight14Dark = TextStyle(
  fontFamily: fontLight,
  color: Color(corDark),
  fontSize: 14,
);
