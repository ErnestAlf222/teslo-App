import 'package:teslo_shop/features/shared/shared.dart';

// 1. State del provider

class LoginFormState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final Email email;
  final Password password;

  LoginFormState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
  });
}

// 2. Implementar un notifier

// 1. StateNotifierProvider - consume afuera


