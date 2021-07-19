import 'package:flutter_social_app/network/cache_helper.dart';

import 'components.dart';

String apiKey = 'f0347c75d90c484fa40ac287425bb07a';

// https://newsapi.org/
// v2/top-headlines
// ?country=us&apiKey=API_KEY
// category='business'
// https://newsapi.org/v2/everything?q=Apple&apiKey=f0347c75d90c484fa40ac287425bb07a

void signOut(context, widget) {
  CacheHelper.removeData(key: 'token').then((value) {
    if (value) {
      navigateAndDestroy(
        context,
        widget,
      );
    }
  });
}

String uId = '';
