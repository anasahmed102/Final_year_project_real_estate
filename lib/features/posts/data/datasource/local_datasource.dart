// ignore_for_file: constant_identifier_names, void_checks, unnecessary_null_comparison

import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:real_estaye_app/core/failures/excemption.dart';
import 'package:real_estaye_app/core/failures/failures.dart';
import 'package:real_estaye_app/features/posts/data/model/real_estate.dart';

abstract class RealEstateLocalDataSource {
  Future<Unit> todoWriteData(List<RealEstateModel> realEstate);
  Future<Either<Failure, List<RealEstateModel>>> todoReadData();
  Future<void> todoDeleteData();
}

const String REAL_ESTATE_CACHE = "REAL_ESTATE";
const _fluttersecurstorage = FlutterSecureStorage();

class RealEstateLocalDataSourceImpl implements RealEstateLocalDataSource {
  @override
  Future<Unit> todoWriteData(List<RealEstateModel> realEstate) async {
    List todosToJson = realEstate
        .map<Map<String, dynamic>>((realEstate) => realEstate.toMap())
        .toList();
    _fluttersecurstorage.write(
        key: REAL_ESTATE_CACHE, value: jsonEncode(todosToJson));
    return Future.value(unit);
  }

  @override
  Future<Either<Failure, List<RealEstateModel>>> todoReadData() async {
    try {
      final jsonString =
          await _fluttersecurstorage.read(key: REAL_ESTATE_CACHE);
      if (jsonString != null) {
        List decodeJsonData = json.decode(jsonString);
        List<RealEstateModel> jsonToPostModels = decodeJsonData
            .map<RealEstateModel>(
                (jsonPostModel) => RealEstateModel.fromMap(jsonPostModel))
            .toList();
        return Right(jsonToPostModels);
      } else {
        return const Left(EmptycacheFailure(message: "No Data"));
      }
    } on Exception catch (e) {
      if (e is EmptycacheException) {
        return const Left(EmptycacheFailure(
            message:
                "No data please connect to the internet and try again later"));
      } else {
        return const Left(EmptycacheFailure(
            message:
                "No Data please connect to the internet and try again later"));
      }
    }
  }

  @override
  Future<void> todoDeleteData() async {
    await _fluttersecurstorage.delete(key: REAL_ESTATE_CACHE);
  }
}
