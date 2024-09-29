
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:com.example.simple_cubit_app/screens/home_screen.dart';

void main() {
	group('HomeScreen', () {
		testWidgets('renders Logout button', (WidgetTester tester) async {
			await tester.pumpWidget(MaterialApp(
				home: HomeScreen(),
			));
			
			expect(find.text('Logout'), findsOneWidget);
		});
		
		testWidgets('triggers logout on button click', (WidgetTester tester) async {
			final mockAuthCubit = MockAuthCubit();
			when(() => mockAuthCubit.logout()).thenReturn(null);
			
			await tester.pumpWidget(MaterialApp(
				home: BlocProvider<AuthCubit>(
					create: (_) => mockAuthCubit,
					child: HomeScreen(),
				),
			));
			
			await tester.tap(find.text('Logout'));
			await tester.pumpAndSettle();
			
			verify(() => mockAuthCubit.logout()).called(1);
		});
	});

	group('AuthCubit', () {
		blocTest<AuthCubit, AuthState>(
			'Logout should emit unauthenticated state',
			build: () => AuthCubit(),
			act: (cubit) => cubit.logout(),
			expect: () => [isA<Unauthenticated>()],
		);
	});
}

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}
