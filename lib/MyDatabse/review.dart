class Review {
  final String movield;
  final String userld;
  final String rating;
  final String review;

  Review({
    required this.movield,
    required this.userld,
    required this.rating,
    required this.review,
  });

  // Convert a User into a Map. The keys must correspond to the names of the
  // columns in the database table.
  Map<String, dynamic> toMap() {
    return {
      'movield': movield,
      'userld': userld,
      'rating': rating,
      'review': review
    };
  }

  // Convert a Map into a User. The Map must contain all of the fields as keys.
  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      movield: map['movield'],
      userld: map['userld'],
      rating:map['rating'],
      review:map['review']

    );
  }

  // Override the toString method to return a custom string representation
  @override
  String toString() {
    return "User:{movield: $movield, userld: $userld, rating: $rating, review: $review }\n";
  }
}
