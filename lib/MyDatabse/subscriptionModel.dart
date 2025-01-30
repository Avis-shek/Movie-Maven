class Subscription{
  final String userld;
  final String modelname;
 

  Subscription({
    required this.modelname,
    required this.userld,
   
  });

  // Convert a User into a Map. The keys must correspond to the names of the
  // columns in the database table.
  Map<String, dynamic> toMap() {
    return {
      'modelname': modelname,
      'userld': userld,
      
    };
  }

  // Convert a Map into a User. The Map must contain all of the fields as keys.
  factory Subscription.fromMap(Map<String, dynamic> map) {
    return Subscription(
      modelname: map['modelname'],
      userld: map['userld'],
      

    );
  }

  // Override the toString method to return a custom string representation
  @override
  String toString() {
    return "Subscription:{ userld: $userld, modelname: $modelname}\n";
  }
}
