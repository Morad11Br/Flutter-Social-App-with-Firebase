import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_social_app/models/create_user_model.dart';
import 'package:flutter_social_app/modules/register/cubit/states.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  bool isVisible = false;
  IconData icon;

  void passwordVisible() {
    isVisible = !isVisible;
    if (isVisible) {
      icon = Icons.visibility_off;
    } else {
      icon = Icons.visibility;
    }
    emit(SocialRegisterIsPasswordState());
  }

  void userRegister({
    @required String email,
    @required String password,
    @required String name,
    @required String phone,
  }) {
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user.uid);
      createUser(
        email: email,
        uId: value.user.uid,
        name: name,
        phone: phone,
      );
    }).catchError((e) {
      print(e.toString());
      emit(SocialRegisterErrorState());
    });
  }

  void createUser({
    @required String email,
    @required String uId,
    @required String name,
    @required String phone,
  }) {
    CreatUserModel userModel = CreatUserModel(
      email: email,
      isEmailVerefied: false,
      name: name,
      phone: phone,
      uId: uId,
      image:
          'https://image.freepik.com/free-photo/smiley-little-boy-isolated-pink_23-2148984796.jpg',
      cover:
          'https://image.freepik.com/free-photo/happy-stylish-man-casual-clothes-standing-cliff-mountain_158538-13995.jpg',
      bio: 'write a bio...',
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(userModel.toMap())
        .then((value) {
      emit(SocialCreateUserSuccessState());
    }).catchError((e) {
      print(e.toString());
      emit(SocialCreateUserErrorState(e.toString()));
    });
  }
}
