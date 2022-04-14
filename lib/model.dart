class Profile {
  String username;
  String password;
  String? expiryDate;

  Profile(this.username, this.password, [this.expiryDate]);

  Map<String, dynamic> toMap() {
    return {
      "username": username,
      "password": password,
      "expiryDate": expiryDate
    };
  }
}

class Plan {
  String name;
  int cost;
  int duration;

  Plan(this.name, this.cost, this.duration);
}
