import 'dart:io';

import 'package:ecomappkoray/blocs/bloc/auth_bloc.dart';
import 'package:ecomappkoray/firebase_options.dart';
import 'package:ecomappkoray/locator.dart';
import 'package:ecomappkoray/pages/Dashboard.dart';
import 'package:ecomappkoray/pages/DashboardLogin.dart';
import 'package:ecomappkoray/pages/HomePage.dart';
import 'package:ecomappkoray/repositories/authrepo.dart';
import 'package:ecomappkoray/repositories/firestorerepo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SetupLocator();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp(
    firebaseRepository: FirebaseRepository(),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({required this.firebaseRepository});
  FirebaseRepository firebaseRepository;

  User? user;
  @override
  Widget build(BuildContext context) {
    user = FirebaseAuth.instance.currentUser;

    return RepositoryProvider(
      create: (context) => AuthRepository(),
      child: BlocProvider(
        create: (context) => AuthBloc(
            authRepository: RepositoryProvider.of<AuthRepository>(context)),
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Ecommerce App',
            home: kIsWeb
                ? user != null
                    ? Dashboard(
                        firebaseRepository: firebaseRepository,
                      )
                    : DashboardLogin(
                        firebaseRepository: firebaseRepository,
                      )
                : HomePage()),
      ),
    );
  }
}
