
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_cubit_app/screens/login_screen.dart';

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
	group('LoginScreen Widget Tests', () {
		testWidgets('LoginScreen displays LoginForm widget', (WidgetTester tester) async {
			await tester.pumpWidget(MaterialApp(home: LoginScreen()));

			expect(find.byType(LoginForm), findsOneWidget);
		});
	});

	group('AuthCubit Tests', () {
		late AuthCubit authCubit;

		setUp(() {
			authCubit = MockAuthCubit();
		});

		blocTest<AuthCubit, AuthState>(
			'AuthCubit emits Authenticated state when login is successful',
			build: () => authCubit,
			act: (cubit) => cubit.login('test@example.com', 'password'),
			expect: () => [isA<Authenticated>()],
		);

		blocTest<AuthCubit, AuthState>(
			'AuthCubit emits AuthError state when login fails',
			build: () => authCubit,
			act: (cubit) => cubit.login('test@example.com', 'wrongpassword'),
			expect: () => [isA<AuthError>()],
		);
	});
}
