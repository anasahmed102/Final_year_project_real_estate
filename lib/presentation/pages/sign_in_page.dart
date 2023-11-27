import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:real_estaye_app/features/auth/logic/bloc/auth_bloc.dart';
import 'package:real_estaye_app/presentation/pages/home_page.dart';
import 'package:real_estaye_app/presentation/pages/sign_up_page.dart';

class TempLoginPage extends StatefulWidget {
  const TempLoginPage({Key? key}) : super(key: key);

  @override
  State<TempLoginPage> createState() => _TempLoginPageState();
}

class _TempLoginPageState extends State<TempLoginPage> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  bool _obscureText = false;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoadedUserState) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const HomePageClean()),
            (route) => false,
          );
        } else if (state is AuthErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.message,
                selectionColor: Colors.red,
              ),
            ),
          );
        }
      },
      child: Scaffold(
        key: scaffoldKey,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const FlutterLogo(
                  size: 120,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Login To Your Account',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email_outlined),
                      labelText: 'Email',
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        child: Icon(
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                      ),
                    ),
                    obscureText: !_obscureText,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      Map authData = {
                        "email": emailController.text,
                        "password": passwordController.text,
                      };
                      BlocProvider.of<AuthBloc>(context)
                          .add(LoginUserEvent(authData));
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      minimumSize: const Size(0, 60),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(FontAwesomeIcons.facebook)),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(FontAwesomeIcons.twitter)),
                    IconButton(
                        onPressed: () {
                          BlocProvider.of<AuthBloc>(context)
                              .add(GoogleSignInSignUpEvent());
                        },
                        icon: const Icon(FontAwesomeIcons.google)),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(FontAwesomeIcons.whatsapp)),
                  ],
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const SignUpPage()));
                  },
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 10),
                      Container(
                        height: 1,
                        width: 200,
                        color: Colors.black,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Don't have an account? Sign Up",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
