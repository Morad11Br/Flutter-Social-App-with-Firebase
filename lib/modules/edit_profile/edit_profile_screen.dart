import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_social_app/components/components.dart';
import 'package:flutter_social_app/cubit/cubit.dart';
import 'package:flutter_social_app/cubit/states.dart';
import 'package:flutter_social_app/styles/my_flutter_app_icons.dart';

// ignore: must_be_immutable
class EditProfileScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).userModel;
        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;

        nameController.text = userModel.name;
        bioController.text = userModel.bio;
        phoneController.text = userModel.phone;

        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Edit Profile',
            actions: [
              defaultTextButton(
                function: () {
                  SocialCubit.get(context).upDateUser(
                    name: nameController.text,
                    phone: phoneController.text,
                    bio: bioController.text,
                  );
                },
                text: 'UPDATE',
              ),
              SizedBox(
                width: 15,
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(4.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (state is UpdateUserLoadingState)
                    LinearProgressIndicator(),
                  if (state is UpdateUserLoadingState)
                    SizedBox(
                      height: 5,
                    ),
                  Container(
                    height: 200,
                    width: double.infinity,
                    //
                    child: Stack(
                      children: [
                        Container(
                          alignment: Alignment.topCenter,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5),
                            ),
                          ),
                          height: 160,
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Image(
                                width: double.infinity,
                                image: coverImage == null
                                    ? NetworkImage('${userModel.cover}')
                                    : FileImage(coverImage),
                                fit: BoxFit.cover,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: InkWell(
                                  onTap: () {
                                    SocialCubit.get(context).getCoverImage();
                                  },
                                  child: CircleAvatar(
                                    radius: 15,
                                    child: Icon(
                                      MyFlutterApp.camera,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: MediaQuery.of(context).size.width * 0.5 - 54,
                          child: CircleAvatar(
                            radius: 54,
                            backgroundColor: Colors.white,
                          ),
                        ),
                        Positioned(
                          bottom: 4,
                          left: MediaQuery.of(context).size.width * 0.5 - 50,
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              CircleAvatar(
                                radius: 50,
                                backgroundImage: profileImage == null
                                    ? NetworkImage('${userModel.image}')
                                    : FileImage(profileImage),
                              ),
                              InkWell(
                                onTap: () {
                                  SocialCubit.get(context).getProfileImage();
                                },
                                child: CircleAvatar(
                                  radius: 16,
                                  child: Icon(
                                    MyFlutterApp.camera,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  if (SocialCubit.get(context).coverImage != null ||
                      SocialCubit.get(context).profileImage != null)
                    Row(
                      children: [
                        if (SocialCubit.get(context).profileImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                defaultButton(
                                  function: () {
                                    SocialCubit.get(context).uploadProfileImage(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      bio: bioController.text,
                                    );
                                  },
                                  text: 'upload image',
                                ),
                                if (state is UpdateUserLoadingState)
                                  SizedBox(
                                    height: 5,
                                  ),
                                if (state is UpdateUserLoadingState)
                                  LinearProgressIndicator(),
                              ],
                            ),
                          ),
                        if (SocialCubit.get(context).profileImage != null)
                          SizedBox(
                            width: 5,
                          ),
                        if (SocialCubit.get(context).coverImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                defaultButton(
                                  function: () {
                                    SocialCubit.get(context).uploadCoverImage(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      bio: bioController.text,
                                    );
                                  },
                                  text: 'upload cover',
                                ),
                                if (state is UpdateUserLoadingState)
                                  SizedBox(
                                    height: 5,
                                  ),
                                if (state is UpdateUserLoadingState)
                                  LinearProgressIndicator(),
                              ],
                            ),
                          ),
                      ],
                    ),
                  if (SocialCubit.get(context).coverImage != null ||
                      SocialCubit.get(context).profileImage != null)
                    SizedBox(
                      height: 20,
                    ),
                  defaultFormField(
                    controller: nameController,
                    label: 'Name',
                    prefix: MyFlutterApp.user,
                    type: TextInputType.name,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'name must not be empty';
                      } else
                        return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  defaultFormField(
                    controller: bioController,
                    label: 'bio',
                    prefix: Icons.info_outline,
                    type: TextInputType.text,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'bio must not be empty';
                      } else
                        return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  defaultFormField(
                    controller: phoneController,
                    label: 'phone Number',
                    prefix: Icons.info_outline,
                    type: TextInputType.number,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'phone Number must not be empty';
                      } else
                        return null;
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
