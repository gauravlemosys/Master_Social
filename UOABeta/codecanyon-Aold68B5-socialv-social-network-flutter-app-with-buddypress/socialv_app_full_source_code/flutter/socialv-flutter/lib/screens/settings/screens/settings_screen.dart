import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialv/components/loading_widget.dart';
import 'package:socialv/main2.dart';
import 'package:socialv/network/rest_apis.dart';
import 'package:socialv/screens/blockReport/blocked_accounts.dart';
import 'package:socialv/screens/profile/screens/edit_profile_screen.dart';
import 'package:socialv/screens/settings/screens/change_password_screen.dart';
import 'package:socialv/screens/settings/screens/coupon_list_screen.dart';
import 'package:socialv/screens/settings/screens/edit_shop_details_screen.dart';
import 'package:socialv/screens/settings/screens/language_screen.dart';
import 'package:socialv/screens/settings/screens/notification_settings.dart';
import 'package:socialv/screens/settings/screens/profile_visibility_screen.dart';
import 'package:socialv/utils/app_constants.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isUpdate = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        finish(context, isUpdate);
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: context.iconColor),
          title: Text(language!.settings, style: boldTextStyle(size: 20)),
          elevation: 0,
          centerTitle: true,
        ),
        body: Observer(
          builder: (_) => Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    SettingSection(
                      title: Text(language!.appSetting.toUpperCase(), style: boldTextStyle(color: context.primaryColor)),
                      headingDecoration: BoxDecoration(color: context.cardColor),
                      items: [
                        SettingItemWidget(
                          title: language!.appTheme,
                          titleTextStyle: primaryTextStyle(color: appStore.isDarkMode ? bodyDark : bodyWhite),
                          leading: Image.asset(ic_dark_mode, height: 18, width: 18, color: context.primaryColor, fit: BoxFit.cover),
                          trailing: Icon(Icons.arrow_forward_ios, color: appStore.isDarkMode ? bodyDark : bodyWhite, size: 16),
                          onTap: () async {
                            if (!appStore.isLoading)
                              await showGeneralDialog(
                                context: context,
                                transitionDuration: Duration(milliseconds: 250),
                                barrierColor: Colors.black26,
                                transitionBuilder: (ctx, a1, a2, widget) {
                                  return Transform.scale(
                                    scale: a1.value,
                                    child: Opacity(
                                      opacity: a1.value,
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3, tileMode: TileMode.repeated),
                                        child: Dialog(
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(defaultRadius)),
                                          clipBehavior: Clip.antiAliasWithSaveLayer,
                                          elevation: 0,
                                          insetAnimationCurve: Curves.linear,
                                          insetAnimationDuration: 0.seconds,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(16),
                                                width: ctx.width(),
                                                decoration: BoxDecoration(color: context.primaryColor),
                                                child: Text(language!.appTheme, style: boldTextStyle(color: Colors.white, size: 20)),
                                              ),
                                              RadioListTile(
                                                value: getIntAsync(SharePreferencesKey.APP_THEME),
                                                groupValue: AppThemeMode.ThemeModeSystem,
                                                onChanged: (val) async {
                                                  appStore.toggleDarkMode(value: MediaQuery.of(context).platformBrightness == Brightness.dark);
                                                  await setValue(SharePreferencesKey.APP_THEME, AppThemeMode.ThemeModeSystem);
                                                  await setValue(SharePreferencesKey.IS_DARK_MODE, MediaQuery.of(context).platformBrightness == Brightness.dark);
                                                  finish(ctx);
                                                },
                                                title: Text(language!.systemDefault, style: primaryTextStyle()),
                                              ),
                                              RadioListTile(
                                                value: getIntAsync(SharePreferencesKey.APP_THEME),
                                                groupValue: AppThemeMode.ThemeModeDark,
                                                onChanged: (val) async {
                                                  appStore.toggleDarkMode(value: true);
                                                  await setValue(SharePreferencesKey.APP_THEME, AppThemeMode.ThemeModeDark);
                                                  await setValue(SharePreferencesKey.IS_DARK_MODE, true);
                                                  finish(ctx);
                                                },
                                                title: Text(language!.darkMode, style: primaryTextStyle()),
                                              ),
                                              RadioListTile(
                                                value: getIntAsync(SharePreferencesKey.APP_THEME),
                                                groupValue: AppThemeMode.ThemeModeLight,
                                                onChanged: (val) async {
                                                  appStore.toggleDarkMode(value: false);
                                                  await setValue(SharePreferencesKey.APP_THEME, AppThemeMode.ThemeModeLight);
                                                  await setValue(SharePreferencesKey.IS_DARK_MODE, false);
                                                  finish(ctx);
                                                },
                                                title: Text(language!.lightMode, style: primaryTextStyle()),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                pageBuilder: (context, animation1, animation2) => Offstage(),
                              );
                          },
                        ),
                        SettingItemWidget(
                          title: language!.appLanguage,
                          titleTextStyle: primaryTextStyle(color: appStore.isDarkMode ? bodyDark : bodyWhite),
                          leading: Image.asset(ic_network, height: 18, width: 18, color: context.primaryColor, fit: BoxFit.cover),
                          trailing: Icon(Icons.arrow_forward_ios, color: appStore.isDarkMode ? bodyDark : bodyWhite, size: 16),
                          onTap: () {
                            if (!appStore.isLoading) LanguageScreen().launch(context);
                          },
                        ),
                      ],
                    ),
                    SettingSection(
                      title: Text('${language!.account.toUpperCase()} ${language!.settings.toUpperCase()}', style: boldTextStyle(color: context.primaryColor)),
                      headingDecoration: BoxDecoration(color: context.cardColor),
                      items: [
                        SettingItemWidget(
                          title: language!.editProfile,
                          titleTextStyle: primaryTextStyle(color: appStore.isDarkMode ? bodyDark : bodyWhite),
                          leading: Image.asset(ic_edit, height: 18, width: 18, color: context.primaryColor, fit: BoxFit.cover),
                          trailing: Icon(Icons.arrow_forward_ios, color: appStore.isDarkMode ? bodyDark : bodyWhite, size: 16),
                          onTap: () {
                            if (!appStore.isLoading)
                              EditProfileScreen().launch(context).then((value) {
                                isUpdate = value;
                              });
                          },
                        ),

                        SettingItemWidget(
                          title: language!.editShopDetails,
                          titleTextStyle: primaryTextStyle(color: appStore.isDarkMode ? bodyDark : bodyWhite),
                          leading: Image.asset(ic_bag, height: 18, width: 18, color: context.primaryColor, fit: BoxFit.cover),
                          trailing: Icon(Icons.arrow_forward_ios, color: appStore.isDarkMode ? bodyDark : bodyWhite, size: 16),
                          onTap: () {
                            if (!appStore.isLoading)
                              EditShopDetailsScreen().launch(context).then((value) {
                                isUpdate = value;
                              });
                          },
                        ),
                        SettingItemWidget(
                          title: language!.coupons,
                          titleTextStyle: primaryTextStyle(color: appStore.isDarkMode ? bodyDark : bodyWhite),
                          leading: Image.asset(ic_coupon, height: 18, width: 18, color: context.primaryColor, fit: BoxFit.cover),
                          trailing: Icon(Icons.arrow_forward_ios, color: appStore.isDarkMode ? bodyDark : bodyWhite, size: 16),
                          onTap: () {
                            CouponListScreen().launch(context);
                          },
                        ),
                        SettingItemWidget(
                          title: language!.changePassword,
                          titleTextStyle: primaryTextStyle(color: appStore.isDarkMode ? bodyDark : bodyWhite),
                          leading: Image.asset(ic_lock, height: 18, width: 18, color: context.primaryColor, fit: BoxFit.cover),
                          trailing: Icon(Icons.arrow_forward_ios, color: appStore.isDarkMode ? bodyDark : bodyWhite, size: 16),
                          onTap: () {
                            if (!appStore.isLoading) ChangePasswordScreen().launch(context);
                          },
                        ),
                        SettingItemWidget(
                          title: '${language!.notifications.capitalizeFirstLetter()} ${language!.settings.capitalizeFirstLetter()}',
                          titleTextStyle: primaryTextStyle(color: appStore.isDarkMode ? bodyDark : bodyWhite),
                          leading: Image.asset(ic_notification, height: 18, width: 18, color: context.primaryColor, fit: BoxFit.cover),
                          trailing: Icon(Icons.arrow_forward_ios, color: appStore.isDarkMode ? bodyDark : bodyWhite, size: 16),
                          onTap: () {
                            if (!appStore.isLoading) NotificationSettings().launch(context);
                          },
                        ),
                        SettingItemWidget(
                          title: language!.profileVisibility,
                          titleTextStyle: primaryTextStyle(color: appStore.isDarkMode ? bodyDark : bodyWhite),
                          leading: Image.asset(ic_profile, height: 18, width: 18, color: context.primaryColor, fit: BoxFit.cover),
                          trailing: Icon(Icons.arrow_forward_ios, color: appStore.isDarkMode ? bodyDark : bodyWhite, size: 16),
                          onTap: () {
                            if (!appStore.isLoading) ProfileVisibilityScreen().launch(context);
                          },
                        ),
                      ],
                    ),
                    SettingSection(
                      title: Text(language!.about.toUpperCase(), style: boldTextStyle(color: context.primaryColor)),
                      headingDecoration: BoxDecoration(color: context.cardColor),
                      items: [
                        SnapHelperWidget<PackageInfoData>(
                          future: getPackageInfo(),
                          onSuccess: (d) => SettingItemWidget(
                            title: language!.rateUs,
                            titleTextStyle: primaryTextStyle(color: appStore.isDarkMode ? bodyDark : bodyWhite),
                            leading: Image.asset(ic_star, height: 18, width: 18, color: context.primaryColor, fit: BoxFit.cover),
                            trailing: Icon(Icons.arrow_forward_ios, color: appStore.isDarkMode ? bodyDark : bodyWhite, size: 16),
                            onTap: () {
                              if (!appStore.isLoading) launchUrl(Uri.parse('$playStoreBaseURL${d.packageName}'), mode: LaunchMode.externalApplication);
                            },
                          ),
                        ),
                        SettingItemWidget(
                          title: language!.shareApp,
                          titleTextStyle: primaryTextStyle(color: appStore.isDarkMode ? bodyDark : bodyWhite),
                          leading: Image.asset(ic_send, height: 18, width: 18, color: context.primaryColor, fit: BoxFit.cover),
                          trailing: Icon(Icons.arrow_forward_ios, color: appStore.isDarkMode ? bodyDark : bodyWhite, size: 16),
                          onTap: () {
                            if (!appStore.isLoading) onShareTap(context);
                          },
                        ),
                        SettingItemWidget(
                          title: language!.privacyPolicy,
                          titleTextStyle: primaryTextStyle(color: appStore.isDarkMode ? bodyDark : bodyWhite),
                          leading: Image.asset(ic_shield_done, height: 16, width: 18, color: context.primaryColor, fit: BoxFit.cover),
                          trailing: Icon(Icons.arrow_forward_ios, color: appStore.isDarkMode ? bodyDark : bodyWhite, size: 16),
                          onTap: () {
                            if (!appStore.isLoading) openWebPage(context, url: PRIVACY_POLICY_URL);
                          },
                        ),
                        SettingItemWidget(
                          title: language!.termsCondition,
                          titleTextStyle: primaryTextStyle(color: appStore.isDarkMode ? bodyDark : bodyWhite),
                          leading: Image.asset(ic_document, height: 18, width: 18, color: context.primaryColor, fit: BoxFit.cover),
                          trailing: Icon(Icons.arrow_forward_ios, color: appStore.isDarkMode ? bodyDark : bodyWhite, size: 16),
                          onTap: () {
                            if (!appStore.isLoading) openWebPage(context, url: TERMS_AND_CONDITIONS_URL);
                          },
                        ),
                        SettingItemWidget(
                          title: language!.helpSupport,
                          titleTextStyle: primaryTextStyle(color: appStore.isDarkMode ? bodyDark : bodyWhite),
                          leading: Image.asset(ic_question_circle, height: 18, width: 18, color: appColorPrimary, fit: BoxFit.cover),
                          trailing: Icon(Icons.arrow_forward_ios, color: appStore.isDarkMode ? bodyDark : bodyWhite, size: 16),
                          onTap: () {
                            if (!appStore.isLoading) openWebPage(context, url: SUPPORT_URL);
                          },
                        ),
                      ],
                    ),
                    SettingSection(
                      title: Text(language!.manageAccount.toUpperCase(), style: boldTextStyle(color: context.primaryColor)),
                      headingDecoration: BoxDecoration(color: context.cardColor),
                      items: [
                        SettingItemWidget(
                          title: language!.blockedAccounts,
                          titleTextStyle: primaryTextStyle(color: appStore.isDarkMode ? bodyDark : bodyWhite),
                          leading: Icon(Icons.cancel_outlined, size: 18, color: context.primaryColor),
                          trailing: Icon(Icons.arrow_forward_ios, color: appStore.isDarkMode ? bodyDark : bodyWhite, size: 16),
                          onTap: () {
                            if (!appStore.isLoading) BlockedAccounts().launch(context);
                          },
                        ),
                        Observer(
                          builder: (_) => SettingItemWidget(
                            title: language!.deleteAccount,
                            titleTextStyle: primaryTextStyle(color: Colors.redAccent),
                            leading: Image.asset(ic_delete, height: 18, width: 18, color: Colors.redAccent, fit: BoxFit.cover),
                            onTap: () {
                              if (!appStore.isLoading)
                                showConfirmDialogCustom(
                                  context,
                                  onAccept: (c) {
                                    ifNotTester(() async {
                                      appStore.setLoading(true);
                                      await deleteAccount().then((value) {
                                        toast(value.message);
                                        logout(context);
                                      }).catchError((e) {
                                        appStore.setLoading(false);
                                        toast(e.toString());
                                      });
                                    });
                                  },
                                  dialogType: DialogType.DELETE,
                                  title: language!.deleteAccountConfirmation,
                                );
                            },
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        showConfirmDialogCustom(
                          context,
                          primaryColor: appColorPrimary,
                          title:  language!.logoutConfirmation,
                          onAccept: (s) {
                            logout(context);
                          },
                        );
                        showConfirmDialogCustom(
                          context,
                          primaryColor: appColorPrimary,
                          title: language!.logoutConfirmation,
                          onAccept: (s) {
                            logout(context);
                          },
                        );
                      },
                      child: Text(language!.logout, style: boldTextStyle(color: context.primaryColor)),
                    ).paddingAll(16),
                    30.height,
                  ],
                ),
              ),
              LoadingWidget().center().visible(appStore.isLoading),
            ],
          ),
        ),
      ),
    );
  }
}
