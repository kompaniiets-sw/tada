import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:url_launcher/url_launcher_string.dart';
class EDeviceUtils {
  // Метод для приховування екранної клавіатури
  static void hideKeyboard(BuildContext context){
    FocusScope.of(context).requestFocus(FocusNode());
  }

  // --- УСІ ФУНКЦІЇ, ПОВ'ЯЗАНІ З ПРИСТРОЄМ
  // Метод для встановлення кольору статус-бару
  static Future<void> setStatusBarColor(Color color) async {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: color),
    );
  }

  // Метод для перевірки, чи пристрій знаходиться в альбомній орієнтації
  static bool isLandscapeOrientation(BuildContext context){
    final viewInsets = View.of(context).viewInsets;
    return viewInsets.bottom == 0;
  }

  // Метод для перевірки, чи пристрій знаходиться в портретній орієнтації
  static bool isPortraitOrientation(BuildContext context){
    final viewInsets = View.of(context).viewInsets;
    return viewInsets.bottom != 0;
  }

  // Метод для встановлення повноекранного режиму
  static void setFullScreen(bool enable){
    SystemChrome.setEnabledSystemUIMode(enable ? SystemUiMode.immersiveSticky : SystemUiMode.edgeToEdge);
  }

  static double getScreenHeight(BuildContext context){
    return MediaQuery.of(context).size.height;
  }
  static double getScreenWidth(BuildContext context){
    return MediaQuery.of(context).size.width;
  }
  static double getPixelRatio(BuildContext context){
    return MediaQuery.of(context).devicePixelRatio;
  }

  static double getStatusBarHeight(BuildContext context){
    return MediaQuery.of(context).padding.top;
  }

  static double getBottomNavigationBarHeight(){
    return kBottomNavigationBarHeight;
  }

  static double getAppBarHeight(){
    return kToolbarHeight;
  }

  static double getKeyboardHeight(BuildContext context){
    final  viewInsets = MediaQuery.of(context).viewInsets;
    return viewInsets.bottom;
  }

  static Future<bool> isKeyboardVisible(BuildContext context) async {
    final viewInsets = View.of(context).viewInsets;
    return viewInsets.bottom > 0;
  }

  static Future<bool> isPhysicalDevice(BuildContext context) async {
    return defaultTargetPlatform == TargetPlatform.android || defaultTargetPlatform == TargetPlatform.iOS;
  }

  static void vibrate(Duration duration){
    HapticFeedback.vibrate();
    Future.delayed(duration, () => HapticFeedback.vibrate());
  }

  static Future<void> setPreferredOrientation(List<DeviceOrientation> orientations) async {
    await SystemChrome.setPreferredOrientations(orientations);
  }

  static void hideStatusBar(){
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
  }

  static Future<bool> hasInternetConnection() async{
    try{
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  static bool isIOS(){
    return Platform.isIOS;
  }

  static bool isAndroid(){
    return Platform.isAndroid;
  }

  static void launchUrl(String url) async {
    if (await canLaunchUrlString(url)){
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
