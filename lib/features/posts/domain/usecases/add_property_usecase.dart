import 'package:dartz/dartz.dart';
import 'package:real_estaye_app/core/failures/failures.dart';
import 'package:real_estaye_app/features/posts/data/model/real_estate.dart';
import 'package:real_estaye_app/features/posts/domain/repository/repositroy.dart';

class AddPropertyUsecases {
  final RealEstateRepository realEstateRepository;

  AddPropertyUsecases(this.realEstateRepository);

  Future<Either<Failure, Unit>> call(RealEstateModel realEstateModel) async {
    return await realEstateRepository.addNewProperty(realEstateModel);
  }
}
