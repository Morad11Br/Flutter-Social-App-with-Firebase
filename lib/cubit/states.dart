abstract class SocialStates {}

class SocialInitialState extends SocialStates {}

class ChangeNavBarState extends SocialStates {}

class AddNewPostState extends SocialStates {}

class SocialGetUserDataLoadingState extends SocialStates {}

class SocialGetUserDataSuccessState extends SocialStates {}

class SocialGetUserDataErrorState extends SocialStates {
  final String error;

  SocialGetUserDataErrorState(this.error);
}

class SocialGetAllUsersLoadingState extends SocialStates {}

class SocialGetAllUsersSuccessState extends SocialStates {}

class SocialGetAllUsersErrorState extends SocialStates {
  final String error;

  SocialGetAllUsersErrorState(this.error);
}

class SocialGetPostDataLoadingState extends SocialStates {}

class SocialGetPostDataSuccessState extends SocialStates {}

class SocialGetPostDataErrorState extends SocialStates {
  final String error;

  SocialGetPostDataErrorState(this.error);
}

class SocialLikePostSuccessState extends SocialStates {}

class SocialLikePostErrorState extends SocialStates {
  final String error;

  SocialLikePostErrorState(this.error);
}

class PickedProfileImageSuccessState extends SocialStates {}

class PickedProfileImageErrorState extends SocialStates {}

class PickedCoverImageSuccessState extends SocialStates {}

class PickedCoverImageErrorState extends SocialStates {}

class UpLoadProfileImageSuccessState extends SocialStates {}

class UpLoadProfileImageErrorState extends SocialStates {}

class UpLoadCoverImageSuccessState extends SocialStates {}

class UpLoadCoverImageErrorState extends SocialStates {}

class UpdateUserSuccessState extends SocialStates {}

class UpdateUserErrorState extends SocialStates {}

class UpdateUserLoadingState extends SocialStates {}

// Create Post States

class PickedPostImageSuccessState extends SocialStates {}

class PickedPostImageErrorState extends SocialStates {}

class UploadPostSuccessState extends SocialStates {}

class UploadPostErrorState extends SocialStates {}

class UploadPostLoadingState extends SocialStates {}

class CreatePostErrorState extends SocialStates {}

class CreatePostSuccessState extends SocialStates {}

class CreatePostLoadingState extends SocialStates {}

class RemovePostImageState extends SocialStates {}

class SendMessageSuccessState extends SocialStates {}

class SendMessageErrorState extends SocialStates {}

class GetMessageSuccessState extends SocialStates {}
