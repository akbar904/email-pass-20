
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_cubit_app/models/user_model.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
	final User user;
	AuthAuthenticated(this.user);
}

class AuthUnauthenticated extends AuthState {}

class AuthError extends AuthState {
	final String message;
	AuthError(this.message);
}

class AuthCubit extends Cubit<AuthState> {
	AuthCubit() : super(AuthInitial());

	void login(String email, String password) async {
		emit(AuthLoading());
		try {
			// Simulate a login call
			if (email == 'test@example.com' && password == 'password123') {
				final user = User(id: '1', email: email, name: 'Test User');
				emit(AuthAuthenticated(user));
			} else {
				emit(AuthError('Invalid credentials'));
			}
		} catch (e) {
			emit(AuthError('An error occurred'));
		}
	}

	void logout() {
		emit(AuthUnauthenticated());
	}
}
