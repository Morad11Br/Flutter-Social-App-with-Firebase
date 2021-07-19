import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_social_app/components/components.dart';
import 'package:flutter_social_app/cubit/cubit.dart';
import 'package:flutter_social_app/cubit/states.dart';
import 'package:flutter_social_app/modules/new_post/add_post_screen.dart';
import 'package:flutter_social_app/styles/my_flutter_app_icons.dart';

class SocialLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is AddNewPostState) {
          navigateTo(context, AddPostScreen());
        }
      },
      builder: (context, stete) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.title[cubit.currentIndex]),
            actions: [
              IconButton(icon: Icon(MyFlutterApp.search), onPressed: () {}),
              IconButton(icon: Icon(MyFlutterApp.lightbulb), onPressed: () {}),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeNavBarItem(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(MyFlutterApp.doc),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  MyFlutterApp.paper_plane,
                ),
                label: 'Chats',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  MyFlutterApp.photo,
                ),
                label: 'Post',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  MyFlutterApp.user,
                ),
                label: 'Users',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  MyFlutterApp.cog,
                ),
                label: 'Settings',
              ),
            ],
          ),
        );
      },
    );
  }
}
