import 'package:dartz/dartz.dart';
import 'package:real_estaye_app/core/failures/failures.dart';
import 'package:real_estaye_app/features/auth/data/model/user.dart';
import 'package:real_estaye_app/features/auth/domain/repositroy/repositroy.dart';


class LocalUseCases {
  final AuthRepository authRepository;

  LocalUseCases(this.authRepository);
  Future<Either<Failure, UserModel>> call() async {
    return await authRepository.getCurrentUser();
  }
}
