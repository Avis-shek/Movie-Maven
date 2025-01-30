class favourite {
  final String movield;
  final String userld;

  favourite({
    required this.movield,
    required this.userld,
  });

  // Convert a User into a Map. The keys must correspond to the names of the
  // columns in the database table.
  Map<String, dynamic> toMap() {
    return {
      'movield': movield,
      'userld': userld,
    };
  }

  // Convert a Map into a User. The Map must contain all of the fields as keys.
  factory favourite.fromMap(Map<String, dynamic> map) {
    return favourite(
      movield: map['movield'],
      userld: map['userld'],
    );
  }

  // Override the toString method to return a custom string representation
  @override
  String toString() {
    return "User:{movield: $movield, userld: $userld}\n";
  }
}


// watchLaterld:INTEGER movield:INTEGER userld.INTEGER