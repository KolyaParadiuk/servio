// import 'package:fittrack_health_flutter/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

/// NAME         SIZE  WEIGHT  SPACING
/// headline1    96.0  light   -1.5
/// headline2    60.0  light   -0.5
/// headline3    48.0  regular  0.0
/// headline4    34.0  regular  0.25
/// headline5    24.0  regular  0.0
/// headline6    20.0  medium   0.15
/// subtitle1    16.0  regular  0.15
/// subtitle2    14.0  medium   0.1
/// body1        16.0  regular  0.5   (bodyText1)
/// body2        14.0  regular  0.25  (bodyText2)
/// button       14.0  medium   1.25
/// caption      12.0  regular  0.4
/// overline     10.0  regular  1.5

BoxShadow kHeroShadow = BoxShadow(
  color: Colors.grey.withOpacity(0.2),
  spreadRadius: 5,
  blurRadius: 7,
  offset: Offset(0, 3), // changes position of shadow
);

double kCommonTiny = 10.sp;
double kCommonXSmall = 12.sp;
double kCommonSmall = 14.sp;
double kCommonSMedium = 15.sp;
double kCommonMedium = 16.sp;
double kCommonLarge = 18.sp;
double kCommonXLarge = 20.sp;
double kCommonHuge = 22.sp;
double kCommonXHuge = 24.sp;
double kCommonEnormous = 28.sp;
double kCommonXEnormous = 30.sp;
double kCommonXLEnormous = 32.sp;
double kCommonXXEnormous = 34.sp;
double kCommon1XLEnormous = 40.sp;
double kCommon1XXEnormous = 48.sp;
double kCommon2XLEnormous = 60.sp;
double kCommon3XLEnormous = 96.sp;
double kCommon4XLEnormous = 120.sp;
double kCommon5XLEnormous = 160.sp;

const FontWeight kRegular = FontWeight.w400;
const FontWeight kMedium = FontWeight.w500;
const FontWeight kSemiBold = FontWeight.w600;
const FontWeight kBold = FontWeight.w700;
const FontWeight kHeavy = FontWeight.w800;
const FontWeight kBlack = FontWeight.w900;

double kCollapsedHeaderHeight = 100.h;
double kExpandedHeaderHeight = 160.h;
double kCommonAppBarBottomWidgetHeight = 64.h;

double kPageHeaderHeight = 200.w;
double kSleepDataHeight = 420.w;
double kSleepNoDataHeight = 380.w;
double kSleepHeaderHeight = 520.w;
double kSleepNoDataHeaderHeight = 500.w;

double kButtonBorderWidth = 1.h;
double kButtonPadding = 15.h;

TextStyle kBody = TextStyle(
  fontSize: kCommonLarge,
  fontWeight: kRegular,
);
TextStyle kButton = TextStyle(
  fontSize: kCommonSMedium,
  fontWeight: kHeavy,
  letterSpacing: -0.1,
);

TextStyle kFootnote = TextStyle(
  fontSize: kCommonSmall,
  fontWeight: kRegular,
  color: kBlackColor,
);
TextStyle kTitle4 = TextStyle(
  fontSize: kCommonSmall,
  fontWeight: kBold,
  letterSpacing: (18 * -0.0044).sp,
);

TextStyle kTitle3 = TextStyle(
  fontSize: kCommonMedium,
  fontWeight: kBold,
  letterSpacing: (18 * -0.0044).sp,
);
TextStyle kTitle3White = kTitle3.copyWith(color: kWhiteButtonContentColor);

TextStyle kTitle2 = TextStyle(
  fontSize: kCommonXLarge,
  fontWeight: kBold,
  letterSpacing: (18 * -0.0044).sp,
);
TextStyle kTitle2White = kTitle3.copyWith(color: kWhiteButtonContentColor);

TextStyle kSubTitle3 = TextStyle(
    fontSize: kCommonSmall,
    fontWeight: kRegular,
    letterSpacing: (18 * -0.0044).sp,
    color: kBlackColor.withOpacity(0.6));
