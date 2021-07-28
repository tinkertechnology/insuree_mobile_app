import 'package:openimis_web_app/auth/register_card.dart';
import 'package:openimis_web_app/auth/reset-password.dart';
import 'package:openimis_web_app/models/insuree.dart';
import 'package:openimis_web_app/models/user_location.dart';
import 'package:openimis_web_app/pages/base.dart';
import 'package:openimis_web_app/pages/card_details.dart';
import 'package:openimis_web_app/pages/contactus.dart';
import 'package:openimis_web_app/pages/faq.dart';
import 'package:openimis_web_app/pages/feedback.dart';
import 'package:openimis_web_app/pages/service_provider.dart';
import 'package:openimis_web_app/pages/notice.dart';
import 'package:openimis_web_app/pages/notification.dart';
import 'package:openimis_web_app/pages/office.dart';
import 'package:openimis_web_app/pages/policy_information.dart';
import 'package:openimis_web_app/pages/profile.dart';
import 'package:openimis_web_app/pages/userhistory.dart';
import 'package:openimis_web_app/theme/dark_theme_provider.dart';
import 'package:openimis_web_app/theme/dark_theme_styles.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:openimis_web_app/auth/auth.dart';
import 'package:openimis_web_app/blocks/auth_block.dart';
import 'package:openimis_web_app/ui/splash_screen.dart';
import 'package:openimis_web_app/services/bottom_nav_bar_service.dart';
import 'package:openimis_web_app/auth/login_card.dart';
import 'package:openimis_web_app/pages/settings.dart';
import 'package:openimis_web_app/auth/validate_otp_card.dart';
import 'package:openimis_web_app/services/location_service.dart';
import 'langlang/app_localization_deligate.dart';
import 'package:openimis_web_app/auth/verify_insuree.dart';
import 'package:openimis_web_app/services/connectivity.dart';
import 'package:openimis_web_app/pages/claimed_item_services.dart';
import 'package:openimis_web_app/pages/submission_page.dart';
import 'package:openimis_web_app/langlang/application.dart';
import 'package:openimis_web_app/blocks/bool_provider.dart';

void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    runApp(MyApp());
}

//  WidgetsFlutterBinding.ensureInitialized();
//  final Locale locale = Locale('en');
class MyApp extends StatefulWidget {
    @override
    _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
    AppTranslationsDelegate _newLocaleDelegate;
    Insuree insuree;
    DarkThemeProvider themeChangeProvider = new DarkThemeProvider();
    ConnectivityService connectivityStatus = new ConnectivityService();

    @override
    void initState() {
        super.initState();
        _newLocaleDelegate = AppTranslationsDelegate(newLocale: null);
        application.onLocaleChanged = onLocaleChange;
        getCurrentAppTheme();
    }

    void getCurrentAppTheme() async {
        themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreference.getTheme();
    }

    void onLocaleChange(Locale locale) {
        setState(() {
            _newLocaleDelegate = AppTranslationsDelegate(newLocale: locale);
        });
    }
    @override
    Widget build(BuildContext context) {
        return MultiProvider(
            providers: [
                ChangeNotifierProvider<AuthBlock>.value(value: AuthBlock()),
                ChangeNotifierProvider<BottomNavigationBarProvider>.value(value: BottomNavigationBarProvider()),
                ChangeNotifierProvider<LoadingProvider>.value(value: LoadingProvider(),),
                ChangeNotifierProvider(create: (_) {
                    return themeChangeProvider;
                }),
	            StreamProvider<UserLocation>.value(value: LocationService().locationStream),
                StreamProvider(
                    create: (context) => Connectivity().onConnectivityChanged),

            ],
            child: Consumer<DarkThemeProvider>(
                builder: (BuildContext context, value, Widget child) {
                    return MaterialApp(

                        localizationsDelegates: [
                            _newLocaleDelegate,
                            //provides localised strings
                            GlobalMaterialLocalizations.delegate,
                            //provides RTL support
                            GlobalWidgetsLocalizations.delegate,
                        ],
                        supportedLocales: [
                            const Locale("en", ""),
                            const Locale("es", ""),
                        ],
                        // locale: locale,
                        debugShowCheckedModeBanner: false,
                        theme: Styles.themeData(themeChangeProvider.darkTheme, context),
                        initialRoute: '/splash',
                        routes: <String, WidgetBuilder>{
                            '/ggg': (BuildContext context) => Auth(),
                            '/card' :(BuildContext context) => Display(initIndex: null,),
                            '/profile' :(BuildContext context) => SettingsPage(null),
                            
                            '/splash':(BuildContext context) => SplashScreen(),
                            '/':(BuildContext context) => LoginScreen(), //OTP this is
                            '/register':(BuildContext context) => RegisterScreen(),

                            '/otp-verify' :(BuildContext context) => OtpScreen(),
                            '/insuree_verify' :(BuildContext context) => VerifyInsuree(),

                            // SIGN UP
                            '/reset-password':(BuildContext context) => ResetPassword(),

                            //POLICY INFORMATION
                            '/policy-information':(BuildContext context) => PolicyInformationPage(),

                            // SERVICES
                            '/service-provider-list':(BuildContext context) => ServiceProviderPage(),

                            // NOTIFICATIONS
                            '/notifications':(BuildContext context) => NotificationPage(),

                            // FEEDBACK
                            '/feedback':(BuildContext context) => FeedbackPage(),

                            // PROFILE INFO
                            '/profile-info' :(BuildContext context) => ProfileInfo(),

                            // USER HISTORY
                            '/user-history' :(BuildContext context) => UserHistoryPage(),

                            // SHOW VIRTUAL CARD
                            '/show-card' :(BuildContext context) => CardDetailPage(),

                            // FAQ
                            '/faq' :(BuildContext context) => FAQ(),

                            //Claimed item Services
                            '/claimed_item_services' : (BuildContext context) => ClaimedItemServicesPage(),

                            '/PaymentsubmissionPage': (BuildContext context) => SubmissionPage(),
    
                            // NOTICE BOARD
                            '/notice': (BuildContext context) => NoticePage(),
                            
                            // OFFICE RELATED TO HIB
                            '/offices': (BuildContext context) => OfficePage(),
    
                            // CONTACT US
                            '/contact': (BuildContext context) => ContactUsPage(),


                        },
                    );
                }));
    }
}
