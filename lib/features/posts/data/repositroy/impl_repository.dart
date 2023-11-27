import 'package:dartz/dartz.dart';
import 'package:real_estaye_app/core/failures/excemption.dart';
import 'package:real_estaye_app/core/failures/failures.dart';
import 'package:real_estaye_app/core/netwrok/network.dart';
import 'package:real_estaye_app/features/posts/data/datasource/remote_datasource.dart';
import 'package:real_estaye_app/features/posts/data/model/real_estate.dart';
import 'package:real_estaye_app/features/posts/domain/repository/repositroy.dart';

class ImplRealEstateRepository extends RealEstateRepository {
  final RealEstateRemoteDataSource realEstateRemoteDataSource;
  final NetworkInfo networkInfo;

  ImplRealEstateRepository({
    required this.realEstateRemoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Stream<List<RealEstateModel>>>> getAllPosts() async {
    if (await networkInfo.isconnected) {
      try {
        Stream<List<RealEstateModel>> remotePosts =
            realEstateRemoteDataSource.getAllPosts();

        return Right(remotePosts);
      } on ServerException {
        return const Left(ServerFailure(message: "No Internet Connection"));
      } on Exception {
        return const Left(EmptycacheFailure(
            message:
                "No Data, please connect to the internet and try again later"));
      }
    } else {
      return const Left(OfflineFailure(message: ""));
    }
  }

  @override
  Future<Either<Failure, Unit>> addNewProperty(
      RealEstateModel realEstateModel) async {
    if (await networkInfo.isconnected) {
      try {
        realEstateRemoteDataSource.addProperty(RealEstateModel(
            id: realEstateModel.id,
            description: realEstateModel.description,
            location: realEstateModel.location,
            photo: realEstateModel.photo,
            price: realEstateModel.price,
            properyName: realEstateModel.properyName,
            size: realEstateModel.size));
        return Future.value(const Right(unit));
      } on ServerException {
        return const Left(
            ServerFailure(message: "Server Failure try Again Later"));
      }
    } else {
      return const Left(
          OfflineFailure(message: "Please Cheack Ur internet connection "));
    }
  }
}
