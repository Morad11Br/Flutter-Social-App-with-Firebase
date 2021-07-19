import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_social_app/components/components.dart';
import 'package:flutter_social_app/cubit/cubit.dart';
import 'package:flutter_social_app/cubit/states.dart';
import 'package:flutter_social_app/styles/my_flutter_app_icons.dart';

// ignore: must_be_immutable
class AddPostScreen extends StatelessWidget {
  var textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var now = DateTime.now();
          return Scaffold(
            appBar: defaultAppBar(
              context: context,
              title: 'Create post',
              actions: [
                defaultTextButton(
                    function: () {
                      if (SocialCubit.get(context).postImage == null) {
                        SocialCubit.get(context).createPost(
                          text: textController.text,
                          dateTime: now.toString(),
                        );
                      } else if (SocialCubit.get(context).postImage != null) {
                        SocialCubit.get(context).uploadPostImage(
                          text: textController.text,
                          dateTime: now.toString(),
                        );
                      }
                    },
                    text: 'post'),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  if (state is CreatePostLoadingState)
                    LinearProgressIndicator(),
                  if (state is CreatePostLoadingState)
                    SizedBox(
                      height: 10,
                    ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(
                            SocialCubit.get(context).userModel.image),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Text(
                          SocialCubit.get(context).userModel.name,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              .copyWith(fontSize: 18, height: 1.1),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: textController,
                      decoration: InputDecoration(
                        hintText: 'What is in your mind...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  if (SocialCubit.get(context).postImage != null)
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Image(
                          height: 200,
                          width: double.infinity,
                          image: FileImage(SocialCubit.get(context).postImage),
                          fit: BoxFit.cover,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: InkWell(
                            onTap: () {
                              SocialCubit.get(context).removePostImage();
                            },
                            child: CircleAvatar(
                              radius: 15,
                              child: Icon(
                                Icons.close,
                                size: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            SocialCubit.get(context).getPostImage();
                          },
                          child: Row(
                            children: [
                              Icon(MyFlutterApp.photo),
                              SizedBox(
                                width: 5,
                              ),
                              Text('Add Photo'),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () {},
                          child: Text('# Tags'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
