
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_cubit_app/cubits/auth_cubit.dart';

class LoginForm extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		final emailController = TextEditingController();
		final passwordController = TextEditingController();

		return Padding(
			padding: const EdgeInsets.all(16.0),
			child: Column(
				mainAxisAlignment: MainAxisAlignment.center,
				children: [
					TextField(
						key: Key('emailField'),
						controller: emailController,
						decoration: InputDecoration(
							labelText: 'Email',
						),
						keyboardType: TextInputType.emailAddress,
					),
					SizedBox(height: 16.0),
					TextField(
						key: Key('passwordField'),
						controller: passwordController,
						decoration: InputDecoration(
							labelText: 'Password',
						),
						obscureText: true,
					),
					SizedBox(height: 16.0),
					ElevatedButton(
						onPressed: () {
							final email = emailController.text;
							final password = passwordController.text;
							context.read<AuthCubit>().login(email, password);
						},
						child: Text('Login'),
					),
				],
			),
		);
	}
}
