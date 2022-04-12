class Profile {
  String username;
  String password;
  String? expiryDate;

  Profile(this.username, this.password, [this.expiryDate]);
}

class Plan {
  String name;
  int cost;
  int duration;

  Plan(this.name, this.cost, this.duration);
}
