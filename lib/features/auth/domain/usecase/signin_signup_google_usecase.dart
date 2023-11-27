import 'package:dartz/dartz.dart';
import 'package:real_estaye_app/core/failures/failures.dart';
import 'package:real_estaye_app/features/auth/data/model/user.dart';
import 'package:real_estaye_app/features/auth/domain/repositroy/repositroy.dart';

class SinginSignUpGoogleUseCase {
  final AuthRepository repository;

  SinginSignUpGoogleUseCase(this.repository);

  Future<Either<Failure, UserModel>> call() async {
    return await repository.googleSignInOrSignUp();
  }
}
