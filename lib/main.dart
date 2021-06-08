import 'package:card_app/auth/register_card.dart';
import 'package:card_app/auth/reset-password.dart';
import 'package:card_app/models/connectivity.dart';
import 'package:card_app/models/insuree.dart';
import 'package:card_app/models/user_location.dart';
import 'package:card_app/pages/card.dart';
import 'package:card_app/pages/faq.dart';
import 'package:card_app/pages/feedback.dart';
import 'package:card_app/pages/notice.dart';
import 'package:card_app/pages/healthFacilitiesCoordinates.dart';
import 'package:card_app/pages/notification.dart';
import 'package:card_app/pages/office.dart';
import 'package:card_app/pages/policy.dart';
import 'package:card_app/pages/services.dart';
import 'package:card_app/pages/userhistory.dart';
import 'package:card_app/theme/dark_theme_provider.dart';
import 'package:card_app/theme/dark_theme_styles.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:card_app/auth/auth.dart';
import 'package:card_app/blocks/auth_block.dart';
import 'package:card_app/services/linked_card_state.dart';
import 'package:card_app/card/card_page.dart';
import 'package:card_app/ui/splash_screen.dart';
import 'package:card_app/services/bottom_nav_bar_service.dart';
import 'package:card_app/auth/login_card.dart';
import 'package:card_app/card/add_card.dart';
import 'package:card_app/profile/profile_main.dart';
import 'package:card_app/profile/pages/profile_info.dart';
import 'card/sync.dart';
import 'package:card_app/auth/validate_otp_card.dart';
import 'package:card_app/services/location_service.dart';
import 'langlang/app_localization_deligate.dart';
import 'package:card_app/auth/verify_insuree.dart';
import 'package:card_app/services/connectivity.dart';
import 'package:card_app/pages/notification.dart';
import 'package:card_app/pages/claimed_item_services.dart';
import 'package:card_app/pages/submission_page.dart';
import 'package:card_app/langlang/application.dart';


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
                ChangeNotifierProvider<LinkedCardState>.value(value: LinkedCardState()),
                ChangeNotifierProvider<BottomNavigationBarProvider>.value(value: BottomNavigationBarProvider()),
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
                        initialRoute: '/card',
                        routes: <String, WidgetBuilder>{
                            '/ggg': (BuildContext context) => Auth(),
                            '/card' :(BuildContext context) => Display(initIndex: null,),
                            '/profile' :(BuildContext context) => ProfilePageView(),

                            '/sync' :(BuildContext context) => Sync(),
                            '/splash':(BuildContext context) => SplashScreen(),
                            '/':(BuildContext context) => LoginScreen(), //OTP this is
                            '/register':(BuildContext context) => RegisterScreen(),
                            '/add_card':(BuildContext context) => AddCard(affiliate_id: null, cardpk: null,),
                            '/otp-verify' :(BuildContext context) => OtpScreen(),
                            '/insuree_verify' :(BuildContext context) => VerifyInsuree(),

                            // SIGN UP
                            '/reset-password':(BuildContext context) => ResetPassword(),

                            //POLICY INFORMATION
                            '/policy-information':(BuildContext context) => PolicyInformationPage(),

                            // SERVICES
                            '/services':(BuildContext context) => ClaimedItemServicesPage(),

                            // NOTIFICATIONS
                            '/notifications':(BuildContext context) => NotificationPage(),

                            // FEEDBACK
                            '/feedback':(BuildContext context) => FeedbackPage(),

                            // PROFILE INFO
                            '/profile-info' :(BuildContext context) => ProfileInfo(),

                            // USER HISTORY
                            '/user-history' :(BuildContext context) => UserHistory(),

                            // SHOW VIRTUAL CARD
                            '/show-card' :(BuildContext context) => ShowCard(),

                            // FAQ
                            '/faq' :(BuildContext context) => FAQ(),

                            //Claimed item Services
                            '/claimed_item_services' : (BuildContext context) => ClaimedItemServicesPage(),

                            '/PaymentsubmissionPage': (BuildContext context) => SubmissionPage(),
    
                            // NOTICE BOARD
                            '/notice': (BuildContext context) => NoticePage(),
                            
                            // OFFICE RELATED TO HIB
                            '/offices': (BuildContext context) => OfficePage(),

                            //test
//                            '/profile-info' :(BuildContext context) => HealthFacilityCoordinatesPage(),
//                            '/services':(BuildContext context) => HealthFacilityCoordinatesPage(),
//                            '/register':(BuildContext context) => HealthFacilityCoordinatesPage(),
//                            '/add_card':(BuildContext context) => HealthFacilityCoordinatesPage(),
//                            '/policy-information':(BuildContext context) => HealthFacilityCoordinatesPage(),
                        },
                    );
                }));
    }
}
