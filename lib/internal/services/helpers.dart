import 'package:rate_my_app/rate_my_app.dart';
import 'package:url_launcher/url_launcher.dart';

void openTerms() => launchUrl(Uri.parse('https://docs.google.com/document/d/1TYHzUU6HrAJ_aN0YjefE5iLRY7uzl94j5xhkMIdJFWc/edit?usp=sharing'));
void openPrivacy() => launchUrl(Uri.parse('https://docs.google.com/document/d/1hNfQXGbcEjm43w11B0tu4jNMG6rtOr1iBEBAM3dE3UM/edit?usp=sharing'));
void openSupport() => launchUrl(Uri.parse('https://docs.google.com/forms/d/e/1FAIpQLScROyPKBF_WwJzDFxbuPuQkT3j7261ORAxjMS1li_yJ3gj14g/viewform?usp=sf_link'));

RateMyApp rateMyApp = RateMyApp(
  preferencesPrefix: 'rateMyApp_',
  minDays: 0, // Show rate popup on first day of install.
  minLaunches: 0, // Show rate popup after 5 launches of app after minDays is passed.
  appStoreIdentifier: '1631536751',
);
