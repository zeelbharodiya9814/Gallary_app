


class Gallary {
   // final String createdAt;
   // final String color;
   // // Map<String, dynamic>? urls;
   // final String urls;
   final String largeImageURL;
   final String type;
   final int comments;


  Gallary({
    // required this.createdAt,
    // required this.color,
    // required this.urls,
   required  this.largeImageURL,
   required  this.type,
   required  this.comments,
  });

  factory Gallary.fromMap({required Map data}) {
    return Gallary (
      // createdAt : data['created_at'],
      // color : data['color'],
      // urls : data['urls']['full'],
      largeImageURL: data['largeImageURL'],
      type: data['type'],
      comments: data['comments'],
    );
  }
}
