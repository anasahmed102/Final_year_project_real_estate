import 'package:dartz/dartz.dart';
import 'package:real_estaye_app/core/failures/failures.dart';
import 'package:real_estaye_app/features/posts/data/model/real_estate.dart';
import 'package:real_estaye_app/features/posts/domain/repository/repositroy.dart';

class GetAllTodoUsecases {
  final RealEstateRepository realEstateRepository;

  GetAllTodoUsecases(this.realEstateRepository);

  Future<Either<Failure, Stream<List<RealEstateModel>>>> call() async {
    return await realEstateRepository.getAllPosts();
  }
}
