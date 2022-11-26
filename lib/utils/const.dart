import 'dart:io';

import 'package:flutter/material.dart';

const String appName = "UPI";
const String noInternetMessage = "please check internet connection, try again";

// fonts
const String appFont = 'NotoSans-Regular';
const String appFontBold = 'NotoSans-Bold';

// route names
const String homeRoute = '/home_page_route';
const String inviteRoute = '/invite_route';

// baseUrl
const String baseUrl =
    "https://asia-southeast1-marlo-bank-dev.cloudfunctions.net/api_dev";

// endpoints
const String inviteUrl = "/invites";
const String getTeamsUrl =
    "/company/6dc9858b-b9eb-4248-a210-0f1f08463658/teams";

// shared pref KEY's

const String token = "TOKEN";

// colors
const Color primaryColor = Color(0xff0CABDF);
const Color iconColor = Color(0xff76808A);
const Color txtLightColor = Color(0xff75808A);
const Color txtDarkColor = Color(0xff000000);
const Color bgNameCardColor = Color(0xff1A62C6);
const Color bgTextFormFieldColor = Color(0xffE9EEF0);
const Color bgTxtColor = Color(0xffC6EBF6);
const Color bgInvitedNameCardColor = Color(0xffAC816E);
const Color txtHintColor = Color(0xff787F89);

// images
const String iconHome = "assets/images/home.svg";
const String iconLoan = "assets/images/loans.svg";
const String iconContract = "assets/images/contracts.svg";
const String iconTeam = "assets/images/teams.svg";
const String iconChat = "assets/images/chat.svg";
const String iconBack = "assets/images/back.svg";
const String iconDrag = "assets/images/indi.svg";
