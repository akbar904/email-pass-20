
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_cubit_app/main.dart';
import 'package:simple_cubit_app/cubits/auth_cubit.dart';
import 'package:simple_cubit_app/screens/login_screen.dart';
import 'package:simple_cubit_app/screens/home_screen.dart';

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
	group('MyApp', () {
		testWidgets('displays LoginScreen when not authenticated', (WidgetTester tester) async {
			final mockAuthCubit = MockAuthCubit();
			when(() => mockAuthCubit.state).thenReturn(AuthInitial());

			await tester.pumpWidget(
				BlocProvider<AuthCubit>(
					create: (_) => mockAuthCubit,
					child: MyApp(),
				),
			);

			expect(find.byType(LoginScreen), findsOneWidget);
		});

		testWidgets('displays HomeScreen when authenticated', (WidgetTester tester) async {
			final mockAuthCubit = MockAuthCubit();
			when(() => mockAuthCubit.state).thenReturn(AuthAuthenticated(user: User(id: '1', email: 'test@example.com', name: 'Test User')));

			await tester.pumpWidget(
				BlocProvider<AuthCubit>(
					create: (_) => mockAuthCubit,
					child: MyApp(),
				),
			);

			expect(find.byType(HomeScreen), findsOneWidget);
		});
	});
}
