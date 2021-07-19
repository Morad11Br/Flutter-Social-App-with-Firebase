import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_social_app/components/components.dart';
import 'package:flutter_social_app/cubit/cubit.dart';
import 'package:flutter_social_app/cubit/states.dart';
import 'package:flutter_social_app/models/postModel.dart';
import 'package:flutter_social_app/styles/colors.dart';
import 'package:flutter_social_app/styles/my_flutter_app_icons.dart';

class FeedsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: ConditionalBuilder(
            condition: SocialCubit.get(context).posts.length > 0 &&
                SocialCubit.get(context).userModel.image != null,
            builder: (context) => SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Card(
                    elevation: 5,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    margin: EdgeInsets.all(8),
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Image(
                          image: NetworkImage(
                            'https://image.freepik.com/free-photo/studio-shot-cheerful-religious-muslim-woman-keeps-arms-folded-smiles-broadly-has-white-teeth_273609-27065.jpg',
                          ),
                          fit: BoxFit.cover,
                          height: 200,
                          width: double.infinity,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'communicate with friends',
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => buildPostItem(
                      SocialCubit.get(context).posts[index],
                      context,
                      index,
                    ),
                    itemCount: SocialCubit.get(context).posts.length,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
            fallback: (context) => Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }

  Widget buildPostItem(
    PostModel model,
    context,
    index,
  ) =>
      Card(
        elevation: 5,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage('${model.image}'),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${model.name}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(fontSize: 18, height: 1.1),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.check_circle,
                              color: defaultColor,
                              size: 16,
                            )
                          ],
                        ),
                        Text(
                          '${model.dateTime}',
                          style: Theme.of(context)
                              .textTheme
                              .caption
                              .copyWith(height: 1.1),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.more_horiz),
                    onPressed: () {},
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: myDevider(),
              ),
              Text(
                '${model.text}',
                style:
                    Theme.of(context).textTheme.bodyText2.copyWith(height: 1.3),
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(
              //     vertical: 10,
              //   ),
              //   child: Container(
              //     width: double.infinity,
              //     child: Wrap(
              //       children: [
              //         Container(
              //           height: 15,
              //           child: MaterialButton(
              //             minWidth: 0,
              //             padding: EdgeInsetsDirectional.only(end: 5),
              //             onPressed: () {},
              //             child: Text(
              //               '#software',
              //               style: Theme.of(context).textTheme.caption.copyWith(
              //                     color: defaultColor,
              //                   ),
              //             ),
              //           ),
              //         ),
              //         Container(
              //           height: 15,
              //           child: MaterialButton(
              //             minWidth: 0,
              //             padding: EdgeInsetsDirectional.only(end: 5),
              //             onPressed: () {},
              //             child: Text(
              //               '#software',
              //               style: Theme.of(context).textTheme.caption.copyWith(
              //                     color: defaultColor,
              //                   ),
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              if (model.postImage != '')
                Container(
                  height: 180,
                  width: double.infinity,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Image(
                    image: NetworkImage('${model.postImage}'),
                    fit: BoxFit.cover,
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Row(
                          children: [
                            Icon(
                              MyFlutterApp.heart,
                              size: 14,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Text(
                              '${SocialCubit.get(context).likes[index]}',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              MyFlutterApp.comment,
                              size: 14,
                              color: Colors.amber,
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Text(
                              '0 comment',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  height: 1,
                  color: Colors.grey[300],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 15,
                            backgroundImage: NetworkImage(
                                '${SocialCubit.get(context).userModel.image}'),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'write a commet...',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      SocialCubit.get(context).likePost(
                        SocialCubit.get(context).postsId[index],
                      );
                    },
                    child: Row(
                      children: [
                        Icon(
                          MyFlutterApp.heart,
                          size: 14,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          'like',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
}
