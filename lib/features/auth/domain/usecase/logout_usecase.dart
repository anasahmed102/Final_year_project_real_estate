import 'package:dartz/dartz.dart';
import 'package:real_estaye_app/core/failures/failures.dart';
import 'package:real_estaye_app/features/auth/domain/repositroy/repositroy.dart';

class LogoutUserUseCase {
  final AuthRepository repository;

  LogoutUserUseCase(this.repository);

  Future<Either<Failure, bool>> call() async {
    return await repository.logout();
  }
}
