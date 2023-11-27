import 'package:dartz/dartz.dart';
import 'package:real_estaye_app/core/failures/failures.dart';
import 'package:real_estaye_app/features/auth/data/model/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserModel>> loginUser({required Map authData});
  Future<Either<Failure, UserModel>> registerUser({required Map authData});
    Future<Either<Failure, UserModel>> googleSignInOrSignUp();
  Future<Either<Failure, bool>> logout();
    Future<Either<Failure, UserModel>> getCurrentUser();


}
