import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_social_app/cubit/cubit.dart';
import 'package:flutter_social_app/cubit/states.dart';
import 'package:flutter_social_app/models/create_user_model.dart';
import 'package:flutter_social_app/models/message_model.dart';
import 'package:flutter_social_app/styles/colors.dart';

// ignore: must_be_immutable
class ChatDetailsScreen extends StatelessWidget {
  CreatUserModel userModel;
  ChatDetailsScreen({this.userModel});

  var textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        SocialCubit.get(context).getMessages(receiverId: userModel.uId);
        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(userModel.image),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(userModel.name),
                  ],
                ),
              ),
              body: ConditionalBuilder(
                condition: SocialCubit.get(context).messages.length > 0,
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            var message =
                                SocialCubit.get(context).messages[index];

                            if (SocialCubit.get(context).userModel.uId ==
                                message.senderId)
                              return buildReceiverMessages(message);
                            return buildMyMessages(message);
                          },
                          separatorBuilder: (context, index) => SizedBox(
                            height: 10,
                          ),
                          itemCount: SocialCubit.get(context).messages.length,
                        ),
                      ),
                      Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsetsDirectional.only(start: 5),
                                child: TextFormField(
                                  controller: textController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'type your message here...',
                                  ),
                                ),
                              ),
                            ),
                            MaterialButton(
                              height: 50,
                              color: defaultColor,
                              onPressed: () {
                                SocialCubit.get(context).sendMessage(
                                    receiverId: userModel.uId,
                                    dateTime: DateTime.now().toString(),
                                    text: textController.text);
                              },
                              child: Icon(Icons.send),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                fallback: (context) =>
                    Center(child: CircularProgressIndicator()),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildMyMessages(MessageModel model) => Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(
                10,
              ),
              topEnd: Radius.circular(
                10,
              ),
              topStart: Radius.circular(
                10,
              ),
            ),
          ),
          child: Text(model.text),
        ),
      );
  Widget buildReceiverMessages(MessageModel model) => Align(
        alignment: Alignment.centerRight,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          decoration: BoxDecoration(
            color: defaultColor.withOpacity(0.2),
            borderRadius: BorderRadiusDirectional.only(
              bottomStart: Radius.circular(
                10,
              ),
              topEnd: Radius.circular(
                10,
              ),
              topStart: Radius.circular(
                10,
              ),
            ),
          ),
          child: Text(model.text),
        ),
      );
}
