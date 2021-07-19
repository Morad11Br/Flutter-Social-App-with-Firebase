import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_social_app/components/components.dart';
import 'package:flutter_social_app/cubit/cubit.dart';
import 'package:flutter_social_app/cubit/states.dart';
import 'package:flutter_social_app/modules/edit_profile/edit_profile_screen.dart';
import 'package:flutter_social_app/styles/my_flutter_app_icons.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).userModel;
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
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
                      child: Image(
                        width: double.infinity,
                        image: NetworkImage('${userModel.cover}'),
                        fit: BoxFit.cover,
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
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage('${userModel.image}'),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '${userModel.name}',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Text(
                '${userModel.bio}',
                style: Theme.of(context).textTheme.caption,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Column(
                        children: [
                          Text('Posts'),
                          Text(
                            '256',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Column(
                        children: [
                          Text('Followers'),
                          Text(
                            '10k',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Column(
                        children: [
                          Text('Following'),
                          Text(
                            '5k',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Column(
                        children: [
                          Text('Photos'),
                          Text(
                            '158',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      child: Text('Add Photos'),
                    ),
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      navigateTo(context, EditProfileScreen());
                    },
                    child: Icon(
                      MyFlutterApp.pencil,
                      size: 16,
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
