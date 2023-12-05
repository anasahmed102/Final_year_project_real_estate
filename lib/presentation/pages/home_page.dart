import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estaye_app/features/posts/logic/bloc/posts_bloc.dart';
import 'package:real_estaye_app/presentation/widgets/proerty_widget.dart';

class HomePageClean extends StatefulWidget {
  const HomePageClean({super.key});

  @override
  State<HomePageClean> createState() => _HomePageCleanState();
}

class _HomePageCleanState extends State<HomePageClean> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostsBloc, PostsState>(
      builder: (context, state) {
        if (state is LoadedPostsState) {
          return RefreshIndicator(
              onRefresh: () => _onRefresh(context),
              child: PropertWidget(
                realEstae: state.realEstate,
              ));
        } else if (state is LoadedPostsState) {
          return PropertWidget(
            realEstae: state.realEstate,
          );
        } else {
          return const SizedBox();
        }
      },
      listener: (context, state) {},
    );
    // return BlocListener<PostsBloc, PostsState>(
    //     listener: (context, state) {
    //       if (state is LoadedTodosState) {
    //         Navigator.pushAndRemoveUntil(
    //             context,
    //             MaterialPageRoute(
    //                 builder: (_) => PropertWidget(realEstae: state.realEstate)),
    //             (route) => false);
    //       }
    //     else  if (state is LoadedTodosState) {
    //         RefreshIndicator(onRefresh:  () => _onRefresh(context),
    //         child:  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=> PropertWidget(realEstae: state.realEstate,)), (route) => false)
    //          );
    //       }
    //        else if (state is ErrorTodosState) {
    //         Navigator.pushAndRemoveUntil(
    //             context,
    //             MaterialPageRoute(builder: (_) => ErrorWidget(state.message)),
    //             (route) => false);
    //       }
    //     },
    //     child: const SizedBox());
  }

  Future<void> _onRefresh(BuildContext context) async {
    BlocProvider.of<PostsBloc>(context).add(RefreshAllPostEvent());
  }
}
// BlocConsumer<PostsBloc, PostsState>(
//         builder: (context, state) {
//           if (state is LoadedTodosState) {
//             return RefreshIndicator(
//                 onRefresh: () => _onRefresh(context),
//                 child: PropertWidget(
//                   realEstae: state.realEstate,
//                 ),);
//           } else if (state is LoadedTodosState) {
//             return PropertWidget(
//               realEstae: state.realEstate,
//             );
//           } else if (state is ErrorTodosState) {
//             return MyErrorWidget(
//               message: state.message,
//             );
//           } else {
//             return const SizedBox();
//           }
//         },
//         listener: (context, state) {},
//       ),