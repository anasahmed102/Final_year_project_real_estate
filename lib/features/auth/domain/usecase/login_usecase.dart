import 'package:dartz/dartz.dart';
import 'package:real_estaye_app/core/failures/failures.dart';
import 'package:real_estaye_app/features/auth/data/model/user.dart';
import 'package:real_estaye_app/features/auth/domain/repositroy/repositroy.dart';

class LoginUserUseCase {
  final AuthRepository repository;

  LoginUserUseCase(this.repository);

  Future<Either<Failure, UserModel>> call({required Map authData}) async {
    return await repository.loginUser(authData: authData);
  }
}
