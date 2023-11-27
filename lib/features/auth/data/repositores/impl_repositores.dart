
import 'package:dartz/dartz.dart';
import 'package:real_estaye_app/core/failures/excemption.dart';
import 'package:real_estaye_app/core/failures/failures.dart';
import 'package:real_estaye_app/core/netwrok/network.dart';
import 'package:real_estaye_app/features/auth/data/datasource/local_datasource.dart';
import 'package:real_estaye_app/features/auth/data/datasource/remote_datasource.dart';
import 'package:real_estaye_app/features/auth/data/model/user.dart';
import 'package:real_estaye_app/features/auth/domain/repositroy/repositroy.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final AuthLocalDataSource authLocalDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.authRemoteDataSource,
    required this.authLocalDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, UserModel>> loginUser({required Map authData}) async {
    return _loginOrRegister(() {
      return authRemoteDataSource.loginUser(authData: authData);
    });
  }

  @override
  Future<Either<Failure, UserModel>> registerUser(
      {required Map authData}) async {
    return await _loginOrRegister(() {
      return authRemoteDataSource.registerUser(authData: authData);
    });
  }

  @override
  Future<Either<Failure, UserModel>> googleSignInOrSignUp() async {
    return await _loginOrRegister(() {
      return authRemoteDataSource.googleSignInOrSignUp();
    });
  }


  @override
  Future<Either<Failure, bool>> logout() async {
    try {
      await authLocalDataSource.logOut();
      await authRemoteDataSource.logOut();
      return const Right(true);
    } on CacheException {
      return const Left(EmptycacheFailure(message: "No Data"));
    } on OfflineException {
      return const Left(OfflineFailure(message: "No internet connection"));
    }
  }

  Future<Either<Failure, UserModel>> _loginOrRegister(
    Future<UserModel> Function() loginOrRegister,
  ) async {
    if (await networkInfo.isconnected) {
      try {
        final user = await loginOrRegister();

        final userModel = UserModel(
          id: user.id,
          email: user.email,
          name: user.name,
        );

        authLocalDataSource.saveUser(userModel);
        return Right(user);
      } on ServerException {
        return const Left(ServerFailure(message: "Server exception"));
      } on OfflineException {
        return const Left(OfflineFailure(message: "No internet connection"));
      } catch (e) {
        return Left(OfflineFailure(message: e.toString()));
      }
    } else {
      return const Left(OfflineFailure(message: "No internet connection"));
    }
  }

  @override
  Future<Either<Failure, UserModel>> getCurrentUser() async {
    try {
      final currentUser = await authLocalDataSource.getCurrentUser();
      return Right(currentUser);
    } on CacheException {
      return const Left(EmptycacheFailure(message: "dfghjkl"));
    }
  }
}
