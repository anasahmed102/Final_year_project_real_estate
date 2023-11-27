import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estaye_app/features/auth/logic/bloc/auth_bloc.dart';
import 'package:real_estaye_app/presentation/pages/home_page.dart';
import 'package:real_estaye_app/presentation/pages/sign_in_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          Timer(const Duration(seconds: 1), () {
            if (state is LoadedUserState) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const HomePageClean()),
                  (route) => false);
            } else if (state is AuthInitial) {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => const LoginPage(),
              ));
            }
          });
        },
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FlutterLogo(
                size: 150,
              )
            ],
          ),
        ),
      ),
    );
  }
}
