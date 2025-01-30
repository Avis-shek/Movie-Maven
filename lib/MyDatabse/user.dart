class User {
  final String fullName;
  final String email;
  final String passwrd;
  final String number;

  User({
    required this.fullName,
    required this.email,
    required this.passwrd,
    required this.number,
  });

  // Convert a User into a Map. The keys must correspond to the names of the
  // columns in the database table.
  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'email': email,
      'passwrd': passwrd,
      'number': number,
    };
  }

  // Convert a Map into a User. The Map must contain all of the fields as keys.
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
        fullName: map['fullName'],
        email: map['email'],
        passwrd: map['passwrd'],
        number: map['number']);
  }

  // Override the toString method to return a custom string representation
  @override
  String toString() {
    return "User:{fullName: $fullName, email: $email, password: $passwrd, dob: $number}\n";
  }
}


// watchLaterld:INTEGER movield:INTEGER userld.INTEGER