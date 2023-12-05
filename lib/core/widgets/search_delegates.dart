import 'package:flutter/material.dart';
import 'package:real_estaye_app/features/posts/data/model/real_estate.dart';
import 'package:real_estaye_app/presentation/pages/details_page.dart';

class RealEstateSearchDelegate extends SearchDelegate<RealEstateModel> {
  final Stream<List<RealEstateModel>> items;

  RealEstateSearchDelegate({required this.items});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  Widget buildSearchResults(List<RealEstateModel> results) {
    if (results.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.warning,
              size: 100,
              color: Colors.grey,
            ),
            Text(
              "No results found",
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey,
              ),
            ),
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
        final item = results[index];
        return ListTile(
          title: Text(item.properyName),
          subtitle: Text(item.price),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => DetailsPage(realEstate: item),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return StreamBuilder<List<RealEstateModel>>(
      stream: items,
      builder: (context, snapshot) {
        final results = snapshot.data!.where((item) {
          return item.properyName.toLowerCase().contains(query.toLowerCase());
        }).toList();

        return buildSearchResults(results);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return StreamBuilder<List<RealEstateModel>>(
      stream: items,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final suggestions = snapshot.data!.where((item) {
            return item.properyName.toLowerCase().contains(query.toLowerCase());
          }).toList();

          return buildSearchResults(suggestions);
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          // Handle the case when data is still loading
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
