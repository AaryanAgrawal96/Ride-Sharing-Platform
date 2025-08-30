import 'package:flutter/material.dart';
import 'package:ride_tracking_platform/repositories/auth_repository.dart';
import '../services/auth_service.dart';
import '../models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  final AuthService _authService;

  AuthController(AuthRepository authRepository)
    : _authService = AuthService(authRepository);

  Future<UserModel> signIn() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      throw Exception('Please fill in all fields');
    }

    if (!email.contains('@')) {
      throw Exception('Please enter a valid email');
    }

    try {
      final user = await _authService.signInWithEmail(email, password);
      if (user == null) {
        throw Exception('Login failed - please try again');
      }
      return user;
    } on FirebaseAuthException catch (e) {
      print('Firebase Auth Error: ${e.code} - ${e.message}');
      switch (e.code) {
        case 'user-not-found':
          throw Exception('No account found with this email');
        case 'wrong-password':
          throw Exception('Incorrect password');
        case 'invalid-email':
          throw Exception('Invalid email format');
        case 'user-disabled':
          throw Exception('This account has been disabled');
        default:
          throw Exception('Login failed: ${e.message}');
      }
    } catch (e) {
      print('General Auth Error: $e');
      throw Exception('Login failed - please try again');
    }
  }

  Future<UserModel> signUp(UserRole role) async {
    final email = emailController.text.trim();
    final password = passwordController.text;
    final name = nameController.text.trim();

    if (email.isEmpty || password.isEmpty || name.isEmpty) {
      throw Exception('Please fill in all fields');
    }

    if (!email.contains('@')) {
      throw Exception('Please enter a valid email');
    }

    if (password.length < 6) {
      throw Exception('Password must be at least 6 characters');
    }

    try {
      return await _authService.signUpWithEmail(email, password, name, role);
    } on FirebaseAuthException catch (e) {
      print('Firebase Auth Error: ${e.code} - ${e.message}');
      switch (e.code) {
        case 'email-already-in-use':
          throw Exception('This email is already registered');
        case 'invalid-email':
          throw Exception('Invalid email format');
        case 'weak-password':
          throw Exception('Password is too weak');
        default:
          throw Exception('Registration failed: ${e.message}');
      }
    } catch (e) {
      print('General Auth Error: $e');
      throw Exception('Registration failed - please try again');
    }
  }

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
  }
}
