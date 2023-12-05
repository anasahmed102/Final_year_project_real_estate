import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estaye_app/core/widgets/search_delegates.dart';
import 'package:real_estaye_app/core/widgets/snack_bar.dart';
import 'package:real_estaye_app/features/auth/logic/bloc/auth_bloc.dart';
import 'package:real_estaye_app/features/posts/data/model/real_estate.dart';
import 'package:real_estaye_app/presentation/pages/add_property.dart';
import 'package:real_estaye_app/presentation/pages/details_page.dart';
import 'package:real_estaye_app/presentation/pages/sign_in_page.dart';

class PropertWidget extends StatefulWidget {
  final Stream<List<RealEstateModel>> realEstae;

  const PropertWidget({Key? key, required this.realEstae}) : super(key: key);

  @override
  State<PropertWidget> createState() => _PropertWidgetState();
}

class _PropertWidgetState extends State<PropertWidget> {
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
      appBar: _appbarBuild(context),
      body: _buildBody(),
    );
  }

  BlocListener<AuthBloc, AuthState> _buildBody() {
    return BlocListener<AuthBloc, AuthState>(
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
      child: StreamBuilder<List<RealEstateModel>>(
        stream: widget.realEstae,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final realEstateList = snapshot.data!;
            return ListView.builder(
              itemCount: realEstateList.length,
              itemBuilder: (context, index) {
                final realEstate = realEstateList[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailsPage(realEstate: realEstate),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Image(
                            image: NetworkImage(realEstate.photo),
                            width: 120,
                            height: 90,
                          ),
                          const SizedBox(width: 10.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  realEstate.properyName,
                                  style: const TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Palatino',
                                  ),
                                ),
                                Text(realEstate.price),
                                Text("Location ${realEstate.location}"),
                                Text("size ${realEstate.size}"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }

  AppBar _appbarBuild(BuildContext context) {
    return AppBar(
      actions: [
        IconButton(
            onPressed: () {
              BlocProvider.of<AuthBloc>(context).add(LogoutEvent());
            },
            icon: const Icon(Icons.exit_to_app)),
        IconButton(
            onPressed: () {
              showSearch(
                  context: context,
                  delegate: PropertySearchDelegate(
                      realEstateStream: widget.realEstae));
            },
            icon: const Icon(Icons.search))
      ],
      title: const Text("Home Page"),
      centerTitle: true,
    );
  }
}
