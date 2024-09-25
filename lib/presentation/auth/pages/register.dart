import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:music_player/common/widgets/appbar/my_app_bar.dart';
import 'package:music_player/common/widgets/button/basic_app_button.dart';
import 'package:music_player/common/widgets/textfield/my_textfield.dart';
import 'package:music_player/core/assets/app_vectors.dart';
import 'package:music_player/data/models/auth/create_user_request.dart';
import 'package:music_player/domain/usecase/auth/signup.dart';
import 'package:music_player/presentation/auth/pages/login.dart';
import 'package:music_player/service_locator.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _signInText(context),
      appBar: MyAppBar(
        title: SvgPicture.asset(
          AppVectors.logo,
          height: 40,
          width: 40,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _registerText(),
              const SizedBox(
                height: 30,
              ),
              _fullNameTextField(),
              const SizedBox(
                height: 30,
              ),
              _emailTextField(),
              const SizedBox(
                height: 30,
              ),
              _passwordTextField(),
              const SizedBox(
                height: 30,
              ),
              _confirmPasswordTextField(),
              const SizedBox(
                height: 30,
              ),
              AppButton(
                  onPressed: () async {
                    var register = await serviceLocator<SignUpUseCase>().call(
                        params: CreateUserRequest(
                            fullName: _fullName.text.toString(),
                            email: _email.text.toString(),
                            password: _password.text.toString(),
                            confirmPassword: _confirmPassword.text.toString()));
                    register.fold((l) {
                      var snackBar = SnackBar(content: Text(l));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }, (r) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  RegisterPage()),
                          (route) => false);
                    });
                  },
                  title: 'Create Account')
            ],
          ),
        ),
      ),
    );
  }

  Widget _registerText() {
    return const Text(
      'Register',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
      textAlign: TextAlign.center,
    );
  }

  Widget _fullNameTextField() {
    return MyTextField(
      controller: _fullName,
      hintText: 'Full Name',
    );
  }

  Widget _emailTextField() {
    return MyTextField(
      controller: _email,
      hintText: 'E-mail',
    );
  }

  Widget _passwordTextField() {
    return MyTextField(
      controller: _password,
      hintText: 'Password',
    );
  }

  Widget _confirmPasswordTextField() {
    return MyTextField(
      controller: _confirmPassword,
      hintText: 'Confirm Password',
    );
  }

  Widget _signInText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Do you have an account?',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
          ),
          TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => LoginPage()));
              },
              child: const Text(
                'Login',
                style: TextStyle(color: Colors.blue),
              ))
        ],
      ),
    );
  }
}
