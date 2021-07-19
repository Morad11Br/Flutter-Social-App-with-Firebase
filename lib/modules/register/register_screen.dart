import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_social_app/components/components.dart';
import 'package:flutter_social_app/layout/social_layout.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) => SocialRegisterCubit(),
        child: BlocConsumer<SocialRegisterCubit, SocialRegisterStates>(
          listener: (context, state) {
            if (state is SocialCreateUserSuccessState) {
              navigateAndDestroy(context, SocialLayout());
            }
          },
          builder: (context, state) {
            var cubit = SocialRegisterCubit.get(context);
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'REGISTER',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        Text(
                          'Register now to communicate with friends',
                          style: Theme.of(context).textTheme.headline6.copyWith(
                                color: Colors.grey,
                              ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                          controller: emailController,
                          label: 'Email',
                          prefix: Icons.email,
                          type: TextInputType.emailAddress,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'email must not be empty!';
                            } else
                              return null;
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        defaultFormField(
                          controller: passwordController,
                          label: 'password',
                          prefix: Icons.lock_outline,
                          suffix: cubit.icon,
                          isPassword: cubit.isVisible,
                          suffixPressed: () {
                            cubit.passwordVisible();
                          },
                          onSubmit: (value) {},
                          type: TextInputType.visiblePassword,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'password to short!';
                            } else
                              return null;
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        defaultFormField(
                          controller: nameController,
                          label: 'Name',
                          prefix: Icons.person,
                          type: TextInputType.text,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'name must not be empty!';
                            } else
                              return null;
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        defaultFormField(
                          controller: phoneController,
                          label: 'Phone',
                          prefix: Icons.phone,
                          type: TextInputType.number,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'phone must not be empty!';
                            } else
                              return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ConditionalBuilder(
                          condition: state is! SocialRegisterLoadingState,
                          builder: (context) => defaultButton(
                            function: () {
                              if (formKey.currentState.validate()) {
                                cubit.userRegister(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  name: nameController.text,
                                  phone: phoneController.text,
                                );
                              }
                            },
                            text: 'register',
                          ),
                          fallback: (context) => Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
