import 'package:socialv/lib_msater_stufy/data/models/AppSettings.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SplashState {}

class InitialSplashState extends SplashState {}

class CloseSplash extends SplashState {
  final bool isSigned;
  final AppSettings? appSettings;

  CloseSplash(this.isSigned, this.appSettings);
}

class SplashOfflineState extends SplashState {}

class ErrorSplashState extends SplashState {}
