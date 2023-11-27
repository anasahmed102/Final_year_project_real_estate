import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estaye_app/features/auth/logic/bloc/auth_bloc.dart';
import 'package:real_estaye_app/features/posts/logic/addUpdateDeleteProperty/bloc/add_update_delete_propery_bloc.dart';
import 'package:real_estaye_app/features/posts/logic/bloc/posts_bloc.dart';
import 'package:real_estaye_app/firebase_options.dart';
import 'package:real_estaye_app/core/helper/bloc_observer.dart';
import 'package:real_estaye_app/injection.dart';
import 'package:real_estaye_app/splash_screen.dart';

void main() async {
  Bloc.observer = MyBlocObserver();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.debug,
    appleProvider: AppleProvider.debug,
   
  );
  initBinding();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<PostsBloc>()..add(GetAllPostEvent()),
        ),
        BlocProvider(
          create: (context) => AddUpdateDeleteProperyBloc(),
        ),
        BlocProvider(
          create: (context) => getIt<AuthBloc>()..add(GetCurrentUserEvent()),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
