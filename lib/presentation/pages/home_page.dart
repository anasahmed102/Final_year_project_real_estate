import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estaye_app/core/widgets/snack_bar.dart';
import 'package:real_estaye_app/features/auth/logic/bloc/auth_bloc.dart';
import 'package:real_estaye_app/features/posts/logic/bloc/posts_bloc.dart';
import 'package:real_estaye_app/presentation/pages/add_property.dart';
import 'package:real_estaye_app/presentation/pages/sign_in_page.dart';
import 'package:real_estaye_app/presentation/widgets/loading_widget.dart';
import 'package:real_estaye_app/presentation/widgets/my_error_widget.dart';
import 'package:real_estaye_app/presentation/widgets/proerty_widget.dart';

class HomePageClean extends StatefulWidget {
  const HomePageClean({super.key});

  @override
  State<HomePageClean> createState() => _HomePageCleanState();
}

class _HomePageCleanState extends State<HomePageClean> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddPropertyPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                BlocProvider.of<AuthBloc>(context).add(LogoutEvent());
              },
              icon: const Icon(Icons.exit_to_app))
        ],
        title: const Text("Home Page"),
        centerTitle: true,
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthErrorState) {
            SnackBarMessage()
                .showErrorSnackBar(message: state.message, context: context);
          } else if (state is MessageState) {
            SnackBarMessage()
                .showSuccessSnackBar(message: state.message, context: context);
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginPage()),
                (route) => false);
          }
        },
        child: BlocConsumer<PostsBloc, PostsState>(
          builder: (context, state) {
            if (state is LoadedTodosState) {
              return RefreshIndicator(
                  onRefresh: () => _onRefresh(context),
                  child: PropertWidget(
                    realEstae: state.realEstate,
                  ));
            } else if (state is LoadedTodosState) {
              return PropertWidget(
                realEstae: state.realEstate,
              );
            } else if (state is ErrorTodosState) {
              return MyErrorWidget(
                message: state.message,
              );
            } else {
              return const LoadingWidget();
            }
          },
          listener: (context, state) {},
        ),
      ),
    );
  }

  Future<void> _onRefresh(BuildContext context) async {
    BlocProvider.of<PostsBloc>(context).add(RefreshAllPostEvent());
  }
}
