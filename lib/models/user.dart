class User {
  final int id;
  final String firstName;
  final String lastName;
  final String username;
  final String genre;
  final String allergens;
  final bool isVegetarian;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.username,
    this.genre,
    this.allergens,
    this.isVegetarian,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      username: json['username'],
      genre: json['genre'],
      allergens: json['allergens'],
      isVegetarian: json['isVegetarian'],
    );
  }
}