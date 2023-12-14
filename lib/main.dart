import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_market/data/datasource/userdata_datasource.dart';
import 'package:flutter_market/data/repository/authen_repository.dart';
import 'package:flutter_market/data/repository/card_api.dart';
import 'package:flutter_market/data/repository/card_repository.dart';
import 'package:flutter_market/domain/uses_case/card_usecase.dart';
import 'package:flutter_market/generated/codegen_loader.g.dart';
import 'package:flutter_market/presentation/bloc/authen_bloc.dart';
import 'package:flutter_market/presentation/bloc/bloc/card_bloc.dart';
import 'package:flutter_market/presentation/screen/bottom.dart'; 
import 'package:flutter_market/presentation/screen/login_screen.dart';
import 'package:flutter_market/presentation/screen/reg_screen.dart';
import 'package:flutter_market/presentation/screen/splash_screen.dart';
import 'package:flutter_market/presentation/screen/user_screen.dart';
import 'package:flutter_market/firebase_options.dart'; 
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart'; 
import 'package:easy_localization/easy_localization.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final UserDataSource userDataSource = UserDataSource(
    firestore: FirebaseFirestore.instance,
  );

  final AuthenticationRepository authenticationRepository = AuthenticationRepository(
    firebaseAuth: FirebaseAuth.instance, 
    userDataSource: userDataSource,
  );

  final dio = Dio();
dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
final apiClient = ApiClient(dio);

  final cardsRepository = CardsRepository(apiClient);

  runApp(
      EasyLocalization(
          supportedLocales: [Locale('en'), Locale('ru'), Locale('kk')],
          path: 'assets/translations', // <-- change the path of the translation files
          fallbackLocale: Locale('en'),
          assetLoader: CodegenLoader(),
          child: MyApp(
    authenticationRepository: authenticationRepository, 
    userDataSource: userDataSource,
    cardsRepository: cardsRepository,
          )
      ),
  );
}

class MyApp extends StatelessWidget {
  final AuthenticationRepository authenticationRepository;
  final UserDataSource userDataSource;
  final CardsRepository cardsRepository;

  MyApp({
    required this.authenticationRepository, 
    required this.userDataSource,
    required this.cardsRepository,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthenticationBloc(
            authenticationRepository: authenticationRepository,
            userDataSource: userDataSource,
          ),
        ),
        BlocProvider(
          create: (context) => CardBloc(
            getCardsUseCase: GetCardsUseCase(cardsRepository),
          ),
        ),
      ],
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
        title: 'Flutter Market',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen(),
        routes: {
          '/loginPage': (context) => LoginPage(),
          '/registerPage': (context) => RegisterPage(),
          '/userPage': (context) => UserPage(userEmail: 'rrrauka@mail.ru'),
          '/splashPage': (context) => SplashScreen(),
          '/bottom': (context) => Bottom()
        },
      ),
    );
  }
}
