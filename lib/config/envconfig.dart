import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {
  String getEnv(String key) {
    return dotenv.env[key]!;
  }

  //web based Keys
  String get firebaseWebApiKey => getEnv('FIREBASE_WEB_API_KEY');
  String get firebaseWebAppId => getEnv('FIREBASE_WEB_APP_ID');
  String get firebaseWebMessagingSenderId =>
      getEnv('FIREBASE_WEB_MESSAGING_SENDER_ID');
  String get firebaseWebProjectId => getEnv('FIREBASE_WEB_PROJECT_ID');
  String get firebaseWebStorageBucket => getEnv('FIREBASE_WEB_STORAGE_BUCKET');
  String get firebaseWebMeasurementId => getEnv('FIREBASE_WEB_MEASUREMENT_ID');
  String get firebaseWebAuthDomain => getEnv('FIREBASE_WEB_AUTH_DOMAIN');

  //android based Keys

  String get firebaseAndroidApiKey => getEnv('FIREBASE_ANDROID_API_KEY');
  String get firebaseAndroidAppId => getEnv('FIREBASE_ANDROID_APP_ID');
  String get firebaseAndroidMessagingSenderId =>
      getEnv('FIREBASE_ANDROID_MESSAGING_SENDER_ID');
  String get firebaseAndroidProjectId => getEnv('FIREBASE_ANDROID_PROJECT_ID');
  String get firebaseAndroidStorageBucket =>
      getEnv('FIREBASE_ANDROID_STORAGE_BUCKET');

  //ios based Keys

  String get firebaseIosApiKey => getEnv('FIREBASE_IOS_API_KEY');
  String get firebaseIosAppId => getEnv('FIREBASE_IOS_APP_ID');
  String get firebaseIosMessagingSenderId =>
      getEnv('FIREBASE_IOS_MESSAGING_SENDER_ID');
  String get firebaseIosProjectId => getEnv('FIREBASE_IOS_PROJECT_ID');
  String get firebaseIosStorageBucket => getEnv('FIREBASE_IOS_STORAGE_BUCKET');
  String get firebaseIosBundleId => getEnv('FIREBASE_IOS_BUNDLE_ID');

  String get appName => getEnv('APP_NAME');
  String get appDescription => getEnv('APP_DESCRIPTION');
  String get appVersion => getEnv('APP_VERSION');
  String get appBuildNumber => getEnv('APP_BUILD_NUMBER');
  String get appPackageName => getEnv('APP_PACKAGE_NAME');
  String get appBundleId => getEnv('APP_BUNDLE_ID');
  String get appDeveloperName => getEnv('APP_DEVELOPER_NAME');
  String get appDeveloperEmail => getEnv('APP_DEVELOPER_EMAIL');
  String get appDeveloperWebsite => getEnv('APP_DEVELOPER_WEBSITE');
}
