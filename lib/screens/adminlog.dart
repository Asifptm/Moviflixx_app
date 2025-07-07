import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviefliix/provider/river_pod.dart';
import 'package:moviefliix/screens/admindash.dart';
import 'package:moviefliix/utils/show_snackbar.dart';

class AdminAuthScreen extends ConsumerStatefulWidget {
  const AdminAuthScreen({super.key});

  @override
  ConsumerState<AdminAuthScreen> createState() => _AdminAuthScreenState();
}

class _AdminAuthScreenState extends ConsumerState<AdminAuthScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController(); // 👈 Username added
  bool isLogin = true;
  bool loading = false;
  bool passwordVisible = false;

  void _handleAuth() async {
    final authService = ref.read(adminAuthServiceProvider);
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final username = _usernameController.text.trim();

    if (email.isEmpty || password.isEmpty || (!isLogin && username.isEmpty)) {
      showCustomSnackBar(
        context,
        icon: Icons.warning_amber_rounded,
        reason: "All fields are required",
        color: Colors.orange,
      );
      return;
    }

    setState(() => loading = true);

    try {
      if (isLogin) {
        await authService.loginAdmin(email, password);

        // ✅ Login success
        showCustomSnackBar(
          context,
          icon: Icons.lock_open_rounded,
          reason: "Login successful!",
          color: Colors.green,
        );

        if (!context.mounted) return;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const AdminDashboard()),
        );
      } else {
        await authService.registerAdmin(email, password, username);

        // ✅ Registration success
        showCustomSnackBar(
          context,
          icon: Icons.verified_user_rounded,
          reason: "Registration successful!",
          color: Colors.blue,
        );

        setState(() => isLogin = true);
      }
    } catch (e) {
      // ❌ Error occurred
      showCustomSnackBar(
        context,
        icon: Icons.error_outline_rounded,
        reason: e.toString(),
        color: Colors.redAccent,
      );
    } finally {
      setState(() => loading = false);
    }
  }

  InputDecoration inputDecoration(
    String label,
    IconData icon, {
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: Colors.black),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.black, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.black, width: 1.5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final title = isLogin ? "Welcome Back 👋" : "Create Admin Account";

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 0.6, 1.0],
            colors: [
              Color.fromRGBO(105, 87, 202, 1),
              Colors.deepPurple,
              Colors.black,
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 420),
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    isLogin
                        ? "Login to your admin account"
                        : "Register a new admin account",
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 24),

                  // 👤 Username input (only in Register mode)
                  if (!isLogin) ...[
                    TextField(
                      controller: _usernameController,
                      decoration: inputDecoration(
                        "Username",
                        Icons.person_outline,
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],

                  // 📧 Email input
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: inputDecoration("Email", Icons.email_outlined),
                  ),
                  const SizedBox(height: 16),

                  // 🔒 Password input
                  TextField(
                    controller: _passwordController,
                    obscureText: !passwordVisible,
                    decoration: inputDecoration(
                      "Password",
                      Icons.lock_outline,
                      suffixIcon: IconButton(
                        icon: Icon(
                          passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.black,
                        ),
                        onPressed:
                            () => setState(
                              () => passwordVisible = !passwordVisible,
                            ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // ✅ Submit button
                  loading
                      ? const CircularProgressIndicator()
                      : SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _handleAuth,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            isLogin ? "Login" : "Register",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                  const SizedBox(height: 16),

                  // 🔁 Toggle login/register
                  TextButton(
                    onPressed: () => setState(() => isLogin = !isLogin),
                    child: Text(
                      isLogin
                          ? "Don't have an account? Register"
                          : "Already have an account? Login",
                      style: const TextStyle(color: Colors.deepPurple),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
