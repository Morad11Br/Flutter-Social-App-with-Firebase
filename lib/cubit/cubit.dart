import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_social_app/components/constants.dart';
import 'package:flutter_social_app/cubit/states.dart';
import 'package:flutter_social_app/models/create_user_model.dart';
import 'package:flutter_social_app/models/message_model.dart';
import 'package:flutter_social_app/models/postModel.dart';
import 'package:flutter_social_app/modules/chats/chat_screen.dart';
import 'package:flutter_social_app/modules/feeds/feeds_screen.dart';
import 'package:flutter_social_app/modules/new_post/add_post_screen.dart';
import 'package:flutter_social_app/modules/settings/settings_screen.dart';
import 'package:flutter_social_app/modules/users/users_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens = [
    FeedsScreen(),
    ChatScreen(),
    AddPostScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];

  List<String> title = [
    'News Feed',
    'Chats',
    'Post',
    'Users',
    'Settings',
  ];

  void changeNavBarItem(int index) {
    if (index == 1) getAllUsers();
    if (index == 2)
      emit(AddNewPostState());
    else {
      currentIndex = index;
      emit(ChangeNavBarState());
    }
  }

//   bool isDark = false;

//   void changeAppTheme({bool fromShared}) {
//     if (fromShared != null) {
//       isDark = fromShared;
//     } else
//       isDark = !isDark;
//     CacheHelper.saveData(key: 'isDark', value: isDark).then((value) {});
//   }

  CreatUserModel userModel;

  void getUserData() {
    emit(SocialGetUserDataLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      print(value.data());
      userModel = CreatUserModel.fromJson(value.data());
      emit(SocialGetUserDataSuccessState());
    }).catchError((e) {
      print(e.toString());
      emit(SocialGetUserDataErrorState(e.toString()));
    });
  }

  File profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(PickedProfileImageSuccessState());
    } else {
      print('No image selected');
      emit(PickedProfileImageErrorState());
    }
  }

  File coverImage;

  Future<void> getCoverImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(PickedCoverImageSuccessState());
    } else {
      print('No image selected');
      emit(PickedCoverImageErrorState());
    }
  }

  void uploadProfileImage({
    @required String name,
    @required String phone,
    @required String bio,
  }) {
    emit(UpdateUserLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage.path).pathSegments.last}')
        .putFile(profileImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        upDateUser(
          name: name,
          phone: phone,
          bio: bio,
          image: value,
        );
      }).catchError((e) {
        print(e);
        emit(UpLoadProfileImageErrorState());
      });
    }).catchError((e) {
      print(e);
      emit(UpLoadProfileImageErrorState());
    });
  }

  void uploadCoverImage({
    @required String name,
    @required String phone,
    @required String bio,
  }) {
    emit(UpdateUserLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage.path).pathSegments.last}')
        .putFile(coverImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        upDateUser(
          name: name,
          phone: phone,
          bio: bio,
          cover: value,
        );
      }).catchError((e) {
        print(e);
        emit(UpLoadCoverImageErrorState());
      });
    }).catchError((e) {
      print(e);
      emit(UpLoadCoverImageErrorState());
    });
  }

  // void updateUser({
  //   @required String name,
  //   @required String phone,
  //   @required String bio,
  // }) {
  //   emit(UpdateUserLoadingState());
  //   if (coverImage != null) {
  //     uploadCoverImage();
  //   }
  //   if (profileImage != null) {
  //     uploadProfileImage();
  //   } else {
  //     updateUser(
  //       name: name,
  //       phone: phone,
  //       bio: bio,
  //     );
  //   }
  // }

  void upDateUser({
    @required String name,
    @required String phone,
    @required String bio,
    String image,
    String cover,
  }) {
    CreatUserModel model = CreatUserModel(
      isEmailVerefied: false,
      name: name,
      phone: phone,
      uId: uId,
      email: userModel.email,
      image: image ?? userModel.image,
      cover: cover ?? userModel.cover,
      bio: bio,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((e) {
      print(e);
      emit(UpdateUserErrorState());
    });
  }

  File postImage;

  void removePostImage() {
    postImage = null;
    emit(RemovePostImageState());
  }

  Future<void> getPostImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(PickedPostImageSuccessState());
    } else {
      print('No image selected');
      emit(PickedPostImageErrorState());
    }
  }

  void uploadPostImage({
    @required String text,
    @required String dateTime,
  }) {
    emit(CreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage.path).pathSegments.last}')
        .putFile(postImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        createPost(
          text: text,
          dateTime: dateTime,
          postImage: value,
        );
      }).catchError((e) {
        print(e);
        emit(UploadPostLoadingState());
      });
    }).catchError((e) {
      print(e);
      emit(UploadPostErrorState());
    });
  }

  void createPost({
    @required String text,
    @required String dateTime,
    String postImage,
  }) {
    emit(CreatePostLoadingState());
    PostModel model = PostModel(
      dateTime: dateTime,
      uId: userModel.uId,
      image: userModel.image,
      name: userModel.name,
      text: text,
      postImage: postImage ?? '',
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(CreatePostSuccessState());
    }).catchError((e) {
      print(e);
      emit(CreatePostErrorState());
    });
  }

  List<PostModel> posts = [];
  List likes = [];
  List postsId = [];

  void getPosts() {
    emit(SocialGetPostDataLoadingState());
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
          postsId.add(element.id);
          posts.add(
            PostModel.fromJson(
              element.data(),
            ),
          );
        }).catchError((e) {});
      });

      emit(SocialGetPostDataSuccessState());
    }).catchError((e) {
      print(e.toString());
      emit(SocialGetPostDataErrorState(e.toString()));
    });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel.uId)
        .set({'like': true}).then((value) {
      emit(SocialLikePostSuccessState());
    }).catchError((e) {
      print(e.toString());
      emit(SocialLikePostErrorState(e.toString()));
    });
  }

  List<CreatUserModel> users = [];

  void getAllUsers() {
    if (users.length == 0)
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uId'] != userModel.uId)
            users.add(
              CreatUserModel.fromJson(element.data()),
            );
        });

        emit(SocialGetAllUsersSuccessState());
      }).catchError((e) {
        print(e.toString());
        emit(SocialGetAllUsersErrorState(e.toString()));
      });
  }

  void sendMessage({
    @required String receiverId,
    @required String dateTime,
    @required String text,
  }) {
    MessageModel model = MessageModel(
      dateTime: dateTime,
      senderId: userModel.uId,
      receiverId: receiverId,
      text: text,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((e) {
      print(e.toString());
      emit(SendMessageErrorState());
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((e) {
      print(e.toString());
      emit(SendMessageErrorState());
    });
  }

  List<MessageModel> messages = [];

  void getMessages({
    @required String receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
        emit(GetMessageSuccessState());
      });
    });
  }
}
