import 'package:dartz/dartz.dart';
import 'package:real_estaye_app/core/failures/failures.dart';
import 'package:real_estaye_app/features/posts/data/model/real_estate.dart';

abstract class RealEstateRepository {
  Future<Either<Failure, Stream<List<RealEstateModel>>>> getAllPosts();
  Future<Either<Failure, Unit>> addNewProperty(RealEstateModel realEstateModel);
}
