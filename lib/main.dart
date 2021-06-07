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
import 'package:card_app/pages/policy.dart';
import 'package:card_app/pages/services.dart';
import 'package:card_app/pages/userhistory.dart';
import 'package:card_app/theme/dark_theme_provider.dart';
import 'package:card_app/theme/dark_theme_styles.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
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
import 'localization/locale_constant.dart';
import 'localization/localizations_delegate.dart';
import 'package:card_app/auth/verify_insuree.dart';
import 'package:card_app/services/connectivity.dart';
import 'package:card_app/pages/notification.dart';
import 'package:card_app/pages/claimed_item_services.dart';
import 'package:card_app/pages/submission_page.dart';



void main() async{
    WidgetsFlutterBinding.ensureInitialized();
    runApp(MyApp());
}


//  WidgetsFlutterBinding.ensureInitialized();
//  final Locale locale = Locale('en');
class MyApp extends StatefulWidget {
    static void setLocale(BuildContext context, Locale newLocale) {
        var state = context.findAncestorStateOfType<_MyAppState>();
        state.setLocale(newLocale);
    }
    @override
    _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
    Insuree insuree;
    DarkThemeProvider themeChangeProvider = new DarkThemeProvider();
    ConnectivityService connectivityStatus = new ConnectivityService();

    Locale _locale;
    void setLocale(Locale locale) {
        setState(() {
            _locale = locale;
        });
    }

    @override
    void didChangeDependencies() async {
        getLocale().then((locale) {
            setState(() {
                _locale = locale;
            });
        });
        super.didChangeDependencies();
    }

    @override
    void initState() {
        super.initState();
        getCurrentAppTheme();
    }

    void getCurrentAppTheme() async {
        themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreference.getTheme();
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
                        locale: _locale,
                        supportedLocales: [
                            Locale('en', ''),
                            Locale('ar', ''),
                            Locale('hi', '')
                        ],
                        localizationsDelegates: [
                            AppLocalizationsDelegate(),
                            GlobalMaterialLocalizations.delegate,
                            GlobalWidgetsLocalizations.delegate,
                            GlobalCupertinoLocalizations.delegate,
                        ],
                        localeResolutionCallback: (locale, supportedLocales) {
                            for (var supportedLocale in supportedLocales) {
                                if (supportedLocale?.languageCode == locale?.languageCode &&
                                    supportedLocale?.countryCode == locale?.countryCode) {
                                    return supportedLocale;
                                }
                            }
                            return supportedLocales?.first;
                        },
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
    
                            '/notice': (BuildContext context) => NoticePage(),

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
