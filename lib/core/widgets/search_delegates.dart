import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:real_estaye_app/features/posts/data/model/real_estate.dart';
import 'package:real_estaye_app/presentation/pages/details_page.dart';

class PropertySearchDelegate extends SearchDelegate<String> {
  final Stream<List<RealEstateModel>> realEstateStream;

  PropertySearchDelegate({required this.realEstateStream});
  @override
  Widget buildResults(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Real_Estate').snapshots(),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
        if (snapshot.hasData) {
          final results = snapshot.data!.docs
              .map((doc) =>
                  RealEstateModel.fromMap(doc.data() as Map<String, dynamic>))
              .where((realEstate) => realEstate.properyName
                  .toLowerCase()
                  .contains(query.toLowerCase()))
              .toList();

          if (results.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error,
                    size: 50,
                    color: Colors.red,
                  ),
                  Text('No results found'),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: results.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(results[index].properyName),
                subtitle: Text(results[index].price),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailsPage(
                        realEstate: results[index],
                      ),
                    ),
                  );
                },
              );
            },
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Real_Estate').snapshots(),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
        if (snapshot.hasData) {
          final results = snapshot.data!.docs
              .map((doc) =>
                  RealEstateModel.fromMap(doc.data() as Map<String, dynamic>))
              .where((realEstate) => realEstate.properyName
                  .toLowerCase()
                  .contains(query.toLowerCase()))
              .toList();

          if (results.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error,
                    size: 50,
                    color: Colors.red,
                  ),
                  Text('No results found'),
                ],
              ),
            );
          }

          return ListView.separated(
            separatorBuilder: (context, index) {
              return const Divider(
                thickness: 1,
              );
            },
            itemCount: results.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(results[index].properyName),
                subtitle: Text(results[index].price),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailsPage(
                        realEstate: results[index],
                      ),
                    ),
                  );
                },
              );
            },
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, '');
      },
      icon: const Icon(Icons.arrow_back),
    );
  }
}
