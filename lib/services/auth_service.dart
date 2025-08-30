import 'package:firebase_auth/firebase_auth.dart';
import '../repositories/auth_repository.dart';
import '../models/user_model.dart';

class AuthService {
  final AuthRepository _authRepository;

  AuthService(this._authRepository);

  Future<UserModel> signUpWithEmail(
    String email,
    String password,
    String name,
    UserRole role,
  ) async {
    return await _authRepository.signUpWithEmail(email, password, name, role);
  }

  Future<UserModel> signInWithEmail(String email, String password) async {
    try {
      print('AuthService: Attempting sign in'); // Debug log
      final user = await _authRepository.signInWithEmail(email, password);
      print('AuthService: Repository response: $user'); // Debug log

      if (user == null) {
        print('AuthService: Null user returned from repository'); // Debug log
        throw FirebaseAuthException(
          code: 'null-user',
          message: 'Authentication failed - null user returned',
        );
      }
      return user;
    } on FirebaseAuthException catch (e) {
      print(
        'AuthService Firebase Error: ${e.code} - ${e.message}',
      ); // Debug log
      rethrow;
    } catch (e) {
      print('AuthService General Error: $e'); // Debug log
      rethrow;
    }
  }
}
