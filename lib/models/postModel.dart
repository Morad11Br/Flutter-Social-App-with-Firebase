class PostModel {
  String name;
  String dateTime;
  String image;
  String text;
  String postImage;
  String uId;

  PostModel({
    this.name,
    this.postImage,
    this.uId,
    this.text,
    this.image,
    this.dateTime,
  });

  PostModel.fromJson(Map<String, dynamic> json) {
    postImage = json['postImage'];
    name = json['name'];
    text = json['text'];
    uId = json['uId'];
    image = json['image'];
    dateTime = json['dateTime'];
  }

  Map<String, dynamic> toMap() {
    return {
      "postImage": postImage,
      'name': name,
      'text': text,
      'image': image,
      'uId': uId,
      'dateTime': dateTime,
    };
  }
}
