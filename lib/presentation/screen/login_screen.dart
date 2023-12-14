import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_market/generated/locale_keys.g.dart';
import 'package:flutter_market/presentation/bloc/authen_bloc.dart';
import 'package:flutter_market/presentation/bloc/authen_event.dart';
import 'package:flutter_market/presentation/bloc/authen_state.dart';
import 'package:easy_localization/easy_localization.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.Entrase.tr(), style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationSuccess) {
            Navigator.pushNamed(context, '/bottom');
          }
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildTextField(emailController, Icons.email, 'Email'),
              SizedBox(height: 10),
              _buildTextField(passwordController, Icons.lock, LocaleKeys.Password.tr(), isPassword: true),
              SizedBox(height: 20),
              _buildButton(context, LocaleKeys.Enter.tr(), Colors.deepPurple),
              SizedBox(height: 10),
              _buildButton(context, LocaleKeys.Registration.tr(), Colors.lightGreen, isRegister: true),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.grey[900],
    );
  }

  Widget _buildTextField(TextEditingController controller, IconData icon, String labelText, {bool isPassword = false}) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.white60),
        prefixIcon: Icon(icon, color: Colors.white60),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white60),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.deepPurple),
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String text, Color color, {bool isRegister = false}) {
    return ElevatedButton(
      onPressed: () {
        if (isRegister) {
          Navigator.pushNamed(context, '/registerPage');
        } else {
          BlocProvider.of<AuthenticationBloc>(context).add(
            AuthenticationLoginRequested(
              email: emailController.text,
              password: passwordController.text,
            ),
          );
        }
      },
      child: Text(text),
      style: ElevatedButton.styleFrom(
        primary: color,
        onPrimary: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}
