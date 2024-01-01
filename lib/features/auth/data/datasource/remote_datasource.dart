
import 'package:firebase_auth/firebase_auth.dart' as firebaseauth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:real_estaye_app/core/failures/excemption.dart';
import 'package:real_estaye_app/features/auth/data/model/user.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> loginUser({required Map authData});
  Future<UserModel> registerUser({required Map authData});
  Future<UserModel> googleSignInOrSignUp();
    Future<bool> logOut();

}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final firebaseauth.FirebaseAuth auth;
  final GoogleSignIn googleSignIn;

  firebaseauth.User? get getCurrentUser => auth.currentUser;

  AuthRemoteDataSourceImpl({
    required this.auth,
    required this.googleSignIn,
  });
  @override
  Future<UserModel> loginUser({required Map authData}) async {
    try {
      final firebaseUser = await auth.signInWithEmailAndPassword(
          email: authData['email'], password: authData['password']);

      final UserModel user = UserModel(
        id: firebaseUser.user!.uid,
        email: firebaseUser.user!.email ?? "",
        name: firebaseUser.user!.displayName ?? "",
      );
      return Future.value(user);
    } on firebaseauth.FirebaseAuthException catch (e) {
      throw ("Wrond Data Please Check Your Email And Password");
    }
  }

  @override
  Future<UserModel> registerUser({required Map authData}) async {
    try {
      final firebaseUser = await auth.createUserWithEmailAndPassword(
        email: authData['email'],
        password: authData['password'],
      );

      final UserModel user = UserModel(
        id: firebaseUser.user!.uid,
        email: firebaseUser.user!.email ?? "",
        name: firebaseUser.user!.displayName ?? "",
      );

      return Future.value(user);
    } on firebaseauth.FirebaseAuthException catch (e) {
      throw (e.message!);
    }
  }

  @override
  Future<UserModel> googleSignInOrSignUp() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount == null) throw (CanceledByUserException());
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final firebaseauth.AuthCredential credential =
          firebaseauth.GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      await auth.signInWithCredential(credential);

      final UserModel user = UserModel(
        id: googleSignInAccount.id,
        name: googleSignInAccount.displayName ?? "",
        email: googleSignInAccount.email,
      );

      return Future.value(user);
    } on firebaseauth.FirebaseAuthException catch (e) {
      throw FirebaseDataException(e.message!);
    }
  }
  
  @override
  Future<bool> logOut() async{
  
    try {
      await googleSignIn.signOut();
      await auth.signOut();

      return true;
    } catch (e) {
      throw (OfflineException);
    }
  }
}
