class GetPhotos {
  String imgSrc;
  String namePhoto;

  GetPhotos({required this.namePhoto, required this.imgSrc});

  static GetPhotos fromAPI2App(Map<String, dynamic> photoMap) {
    return GetPhotos(
        namePhoto: photoMap["photographer"],
        imgSrc: (photoMap["src"])["portrait"]);
  }
}
