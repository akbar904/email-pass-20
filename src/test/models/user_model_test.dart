
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_cubit_app/models/user_model.dart';

void main() {
	group('User Model Tests', () {
		test('User model should serialize from JSON correctly', () {
			// Arrange
			final json = {
				'id': '123',
				'email': 'test@example.com',
				'name': 'Test User'
			};

			// Act
			final user = User.fromJson(json);

			// Assert
			expect(user.id, '123');
			expect(user.email, 'test@example.com');
			expect(user.name, 'Test User');
		});

		test('User model should serialize to JSON correctly', () {
			// Arrange
			final user = User(
				id: '123',
				email: 'test@example.com',
				name: 'Test User'
			);

			// Act
			final json = user.toJson();

			// Assert
			expect(json['id'], '123');
			expect(json['email'], 'test@example.com');
			expect(json['name'], 'Test User');
		});

		test('User model should create a copy with updated values correctly', () {
			// Arrange
			final user = User(
				id: '123',
				email: 'test@example.com',
				name: 'Test User'
			);

			// Act
			final updatedUser = user.copyWith(name: 'Updated User');

			// Assert
			expect(updatedUser.id, '123');
			expect(updatedUser.email, 'test@example.com');
			expect(updatedUser.name, 'Updated User');
		});
	});
}
