class CreatUserModel {
  String email;
  String name;
  String phone;
  String image;
  String cover;
  String bio;
  String uId;
  bool isEmailVerefied;

  CreatUserModel({
    this.email,
    this.name,
    this.phone,
    this.uId,
    this.isEmailVerefied,
    this.image,
    this.cover,
    this.bio,
  });

  CreatUserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    uId = json['uId'];
    image = json['image'];
    cover = json['cover'];
    bio = json['bio'];
    isEmailVerefied = json['isEmailVerefied'];
  }

  Map<String, dynamic> toMap() {
    return {
      "email": email,
      'name': name,
      'phone': phone,
      'image': image,
      'uId': uId,
      'isEmailVerefied': isEmailVerefied,
      'bio': bio,
      'cover': cover,
    };
  }
}
