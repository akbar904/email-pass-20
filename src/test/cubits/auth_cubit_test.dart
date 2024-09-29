
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_cubit_app/cubits/auth_cubit.dart';

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
	group('AuthCubit', () {
		late MockAuthCubit authCubit;

		setUp(() {
			authCubit = MockAuthCubit();
		});

		group('login', () {
			blocTest<MockAuthCubit, AuthState>(
				'emits [AuthLoading, AuthAuthenticated] when login is successful',
				build: () => authCubit,
				act: (cubit) => cubit.login('test@example.com', 'password123'),
				expect: () => [
					isA<AuthLoading>(),
					isA<AuthAuthenticated>(),
				],
			);

			blocTest<MockAuthCubit, AuthState>(
				'emits [AuthLoading, AuthError] when login fails',
				build: () => authCubit,
				act: (cubit) => cubit.login('test@example.com', 'wrongpassword'),
				expect: () => [
					isA<AuthLoading>(),
					isA<AuthError>(),
				],
			);
		});

		group('logout', () {
			blocTest<MockAuthCubit, AuthState>(
				'emits [AuthUnauthenticated] when logout is called',
				build: () => authCubit,
				act: (cubit) => cubit.logout(),
				expect: () => [
					isA<AuthUnauthenticated>(),
				],
			);
		});
	});
}
