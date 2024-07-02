import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/auth/domain/domain.dart';
import 'package:teslo_shop/features/auth/infrastructure/infrastructure.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = AuthRepositoryImpl();
  return AuthNotifier(authRepository: authRepository);
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository authRepository;
  AuthNotifier({
    required this.authRepository,
  }) : super(AuthState());

  void loginUser(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    try {
      final user = await authRepository.login(email, password);
      _setLoggedUser(user);
    } on WrongCredentials {
      logOut('Credenciales no son correctas');
    } catch (e) {
      logOut('Error no controlado');
    }
    // final user = await authRepository.login(email, password);
    // state= state.copyWith(user: user, authStatus: AuthStatus.authenticated );
  }

  void registerUser(String email, String password, String name) async {}

  void checkAuthStatus() async {}

  // Estatblecer usuario
  void _setLoggedUser(User user) {
    // TODO: necesito guardar el token físicamente
    state = state.copyWith(
      user: user,
      authStatus: AuthStatus.authenticated,
    );
  }

  Future<void> logOut([String? errorMessage]) async {
    // TODO: Limpiar token
    state = state.copyWith(
        authStatus: AuthStatus.notAutheticated,
        user: null,
        errorMessage: errorMessage);
  }
}

enum AuthStatus { checking, authenticated, notAutheticated }

class AuthState {
  final AuthStatus authStatus;
  final User? user;
  final String errorMessage;

  AuthState({
    this.authStatus = AuthStatus.checking,
    this.user,
    this.errorMessage = '',
  });

  AuthState copyWith({
    AuthStatus? authStatus,
    User? user,
    String? errorMessage,
  }) {
    return AuthState(
      authStatus: authStatus ?? this.authStatus,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
