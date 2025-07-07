// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:moviefliix/firebase/auth_service.dart';
import 'package:moviefliix/utils/show_snackbar.dart';
// For Feather Icons
import 'login_screen.dart'; // Import the LoginScreen

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      // Show loading spinner
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(child: CircularProgressIndicator());
        },
      );

      try {
        await AuthService().signUpWithEmail(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          username: _usernameController.text.trim(),
        );

        // Dismiss the loading spinner
        Navigator.of(context).pop();

        // Show success snackbar
        showCustomSnackBar(
          context,
          icon: Icons.check_circle_outline,
          reason: 'Sign Up successful!',
          color: Colors.green,
        );

        // Navigate to login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      } catch (e) {
        // Dismiss the loading spinner
        Navigator.of(context).pop();

        // Show error snackbar
        showCustomSnackBar(
          context,
          icon: Icons.error_outline_rounded,
          reason: e.toString(),
          color: Colors.redAccent,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple, // Solid deep purple AppBar
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const SizedBox(),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 27),
            child: Image.asset(
              'assets/images/logo.png',
              width: 140,
              height: 140,
              color: Colors.white, // ensures visibility on purple
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.deepPurple, Colors.black],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Sign Up',
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Username
                    TextFormField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: 'Username',
                        labelStyle: TextStyle(
                          color: Color.fromARGB(255, 43, 41, 41),
                        ),
                        prefixIcon: Icon(
                          FeatherIcons.user,
                          color: Color.fromARGB(255, 31, 29, 29),
                        ),
                      ),
                      style: const TextStyle(
                        color: Color.fromARGB(255, 22, 20, 20),
                      ),
                      validator:
                          (value) =>
                              value == null || value.isEmpty
                                  ? 'Please enter a username'
                                  : null,
                    ),
                    const SizedBox(height: 20),

                    // Email
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(
                          color: Color.fromARGB(255, 31, 28, 28),
                        ),
                        prefixIcon: Icon(
                          FeatherIcons.mail,
                          color: Color.fromARGB(255, 22, 19, 19),
                        ),
                      ),
                      style: const TextStyle(
                        color: Color.fromARGB(255, 32, 28, 28),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator:
                          (value) =>
                              value == null || !value.contains('@')
                                  ? 'Please enter a valid email'
                                  : null,
                    ),
                    const SizedBox(height: 20),

                    // Password
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: const TextStyle(
                          color: Color.fromARGB(255, 26, 23, 23),
                        ),
                        prefixIcon: const Icon(
                          FeatherIcons.lock,
                          color: Color.fromARGB(255, 27, 24, 24),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? FeatherIcons.eye
                                : FeatherIcons.eyeOff,
                            color: const Color.fromARGB(255, 26, 23, 23),
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
                      style: const TextStyle(
                        color: Color.fromARGB(255, 24, 21, 21),
                      ),
                      obscureText: !_isPasswordVisible,
                      validator:
                          (value) =>
                              value == null || value.length < 6
                                  ? 'Password must be at least 6 characters'
                                  : null,
                    ),
                    const SizedBox(height: 20),

                    // Confirm Password
                    TextFormField(
                      controller: _confirmPasswordController,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        labelStyle: const TextStyle(
                          color: Color.fromARGB(255, 27, 24, 24),
                        ),
                        prefixIcon: const Icon(
                          FeatherIcons.check,
                          color: Color.fromARGB(255, 22, 19, 19),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isConfirmPasswordVisible
                                ? FeatherIcons.eye
                                : FeatherIcons.eyeOff,
                            color: const Color.fromARGB(255, 31, 26, 26),
                          ),
                          onPressed: () {
                            setState(() {
                              _isConfirmPasswordVisible =
                                  !_isConfirmPasswordVisible;
                            });
                          },
                        ),
                      ),
                      style: const TextStyle(
                        color: Color.fromARGB(255, 17, 15, 15),
                      ),
                      obscureText: !_isConfirmPasswordVisible,
                      validator:
                          (value) =>
                              value != _passwordController.text
                                  ? 'Passwords do not match'
                                  : null,
                    ),
                    const SizedBox(height: 30),

                    // Sign Up Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _submit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Footer
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already have an account?',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            'Sign In',
                            style: TextStyle(
                              color: Color.fromARGB(255, 93, 91, 197),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
