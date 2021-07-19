import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_social_app/components/components.dart';
import 'package:flutter_social_app/cubit/cubit.dart';
import 'package:flutter_social_app/cubit/states.dart';
import 'package:flutter_social_app/models/create_user_model.dart';
import 'package:flutter_social_app/modules/chat_details/chat_details_screen.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: ConditionalBuilder(
            condition: SocialCubit.get(context).users.length > 0,
            builder: (context) => ListView.separated(
              itemBuilder: (context, index) {
                return buildUserItem(
                    context, SocialCubit.get(context).users[index]);
              },
              separatorBuilder: (context, index) {
                return myDevider();
              },
              itemCount: SocialCubit.get(context).users.length,
            ),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }

  Widget buildUserItem(context, CreatUserModel model) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: InkWell(
        onTap: () {
          navigateTo(
            context,
            ChatDetailsScreen(
              userModel: model,
            ),
          );
        },
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(model.image),
            ),
            SizedBox(
              width: 15,
            ),
            Expanded(
              child: Text(
                model.name,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .copyWith(fontSize: 18, height: 1.1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
