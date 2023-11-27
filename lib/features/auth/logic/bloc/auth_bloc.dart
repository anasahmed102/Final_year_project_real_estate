import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:real_estaye_app/core/failures/failures.dart';
import 'package:real_estaye_app/features/auth/data/model/user.dart';
import 'package:real_estaye_app/features/auth/domain/usecase/login_usecase.dart';
import 'package:real_estaye_app/features/auth/domain/usecase/logout_usecase.dart';
import 'package:real_estaye_app/features/auth/domain/usecase/read_from_local_usecase.dart';
import 'package:real_estaye_app/features/auth/domain/usecase/signin_signup_google_usecase.dart';
import 'package:real_estaye_app/features/auth/domain/usecase/signup_usecase.dart';
import 'package:real_estaye_app/injection.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is LoginUserEvent) {
        emit(AuthLoadingState());
        final failureOrUser =
            await LoginUserUseCase(getIt()).call(authData: event.authData);
        emit(_eitherFailureOrUser(failureOrUser));
      } else if (event is SignUpUserEvent) {
        emit(AuthLoadingState());
        final failureOrUser =
            await SignUpUserUseCase(getIt()).call(authData: event.authData);
        emit(_eitherFailureOrUser(failureOrUser));
      } else if (event is GoogleSignInSignUpEvent) {
        emit(AuthLoadingState());
        final failureOrUser = await SinginSignUpGoogleUseCase(getIt()).call();
        emit(_eitherFailureOrUser(failureOrUser));
      } else if (event is LogoutEvent) {
        emit(AuthLoadingState());
        final failureOrDone = await LogoutUserUseCase(getIt()).call();
        emit(failureOrDone.fold(
          (failure) => AuthErrorState(message: _mapFailureToMessage(failure)),
          (isDone) => const MessageState(message: " Logout Succesfuly"),
        ));
      } else if (event is GetCurrentUserEvent) {
        emit(AuthLoadingState());
        final failureOrUser = await LocalUseCases(getIt()).call();
        emit(failureOrUser.fold(
          (_) => AuthInitial(),
          (user) => LoadedUserState(user: user),
        ));
      }

    });
  }
  AuthState _eitherFailureOrUser(Either<Failure, UserModel> either) {
    return either.fold(
      (failure) {
        return AuthErrorState(message: failure.message);
      },
      (user) => LoadedUserState(user: user),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return "Error";

      case OfflineFailure:
        return "Error";

      default:
        return 'Unexpected Error, Please try again later .';
    }
  }
}
