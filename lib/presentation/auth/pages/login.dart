import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:music_player/common/widgets/appbar/my_app_bar.dart';
import 'package:music_player/common/widgets/button/basic_app_button.dart';
import 'package:music_player/common/widgets/textfield/my_textfield.dart';
import 'package:music_player/core/assets/app_vectors.dart';
import 'package:music_player/data/models/auth/signin_user_request.dart';
import 'package:music_player/domain/usecase/auth/signin.dart';
import 'package:music_player/presentation/auth/pages/register.dart';
import 'package:music_player/service_locator.dart';
import 'package:music_player/presentation/root/pages/root.dart';


class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _signInText(context),
      appBar: MyAppBar(
        title: SvgPicture.asset(AppVectors.logo,height: 40,width: 40,),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _registerText(),
            const SizedBox(height: 30,),
            _emailTextField(),
            const SizedBox(height: 30,),
            _passwordTextField(),
            const SizedBox(height: 30,),
            AppButton(onPressed: () async {
              var register = await serviceLocator<SignInUseCase>().call(
                  params: SignInUserRequest(
                      email: _email.text.toString(),
                      password: _password.text.toString(),
                     ));
              register.fold((l) {
                var snackBar = SnackBar(content: Text(l));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }, (r) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                        const RootPage()),
                        (route) => false);
              });
            }, title: 'Login')
          ],
        ),
      ),
    );
  }
  Widget _registerText(){
    return const Text(
      'Login',
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25
      ),
      textAlign: TextAlign.center,
    );
  }


  Widget _emailTextField(){
    return  MyTextField(
      controller: _email,
      hintText: 'E-mail',
    );
  }
  Widget _passwordTextField(){
    return  MyTextField(
      controller: _password,
      hintText: 'Password',
    );
  }
  Widget _signInText(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Not a Member?',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14),),
          TextButton(onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>  RegisterPage()));

          }, child: const Text('Register Here',style: TextStyle(color: Colors.blue),))
        ],
      ),
    );
  }


}
