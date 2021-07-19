import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget myDevider() => Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 1,
      ),
      child: Container(
        height: 1,
        width: double.infinity,
        color: Colors.grey[300],
      ),
    );

Widget defaultFormField({
  @required TextEditingController controller,
  @required TextInputType type,
  Function onSubmit,
  Function onChange,
  Function onTap,
  bool isPassword = false,
  @required Function validate,
  @required String label,
  @required IconData prefix,
  IconData suffix,
  Function suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: OutlineInputBorder(),
      ),
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => widget),
    );

void navigateAndDestroy(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget),
      (route) => false,
    );

Widget defaultButton({
  @required Function function,
  @required String text,
}) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      color: Colors.blue,
      borderRadius: BorderRadius.circular(3),
    ),
    child: MaterialButton(
      onPressed: function,
      child: Text(
        text.toUpperCase(),
        style: TextStyle(color: Colors.white),
      ),
    ),
  );
}

Widget defaultTextButton({
  @required Function function,
  @required String text,
}) {
  return TextButton(
    onPressed: function,
    child: Text(text.toUpperCase()),
  );
}

void showToast({
  @required String message,
  @required ToastState state,
}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

enum ToastState { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastState state) {
  Color color;
  switch (state) {
    case ToastState.SUCCESS:
      color = Colors.green;
      break;
    case ToastState.ERROR:
      color = Colors.red;
      break;
    case ToastState.WARNING:
      color = Colors.yellow;
      break;
  }
  return color;
}

Widget defaultAppBar({
  @required BuildContext context,
  String title,
  List<Widget> actions,
}) {
  return AppBar(
    titleSpacing: 5,
    leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.pop(context);
        }),
    title: Text(title),
    actions: actions,
  );
}
