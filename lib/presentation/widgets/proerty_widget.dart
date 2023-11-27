import 'package:flutter/material.dart';
import 'package:real_estaye_app/presentation/pages/details_page.dart';
import 'package:real_estaye_app/features/posts/data/model/real_estate.dart';

class PropertWidget extends StatelessWidget {
  final Stream<List<RealEstateModel>> realEstae;

  const PropertWidget({Key? key, required this.realEstae}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<RealEstateModel>>(
      stream: realEstae,
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
                          builder: (_) => DetailsPage(realEstate: realEstate)));
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
    );
  }
}
