import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:music_player/data/models/auth/create_user_request.dart';
import 'package:music_player/data/models/auth/signin_user_request.dart';

abstract class AuthFirebaseService{
  Future<Either> signIn(SignInUserRequest request);
  Future<Either> signUp(CreateUserRequest request);

}
class AuthFirebaseServiceImplementation extends AuthFirebaseService{

  @override
  Future<Either> signIn(SignInUserRequest request) async{

    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: request.email, password: request.password);
      return  const Right("Login was successful");
    }on FirebaseAuthException catch(error){
      String message = '';
      if(error.code == 'invalid-email'){
        message = 'No user found with that email';
      }else if(error.code == 'invalid-credential'){
        message = 'Wrong password provided for that user.';
      }
      return Left(message);
    }
  }

  @override
  Future<Either> signUp(CreateUserRequest request) async {
    try{
      var data  = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: request.email, password: request.password);
      FirebaseFirestore.instance.collection('Users').add({
        'name': request.fullName,
        'email': data.user?.email
      });

      return  const Right("Registration was successful");
    }on FirebaseAuthException catch(error){
      String message = '';
      if(error.code == 'weak-password'){
        message = 'The password provided was took weak';
      }else if(error.code == 'email-already-in-use'){
        message = 'An account already exist with that email';
      }
      return Left(message);
    }
  }

}