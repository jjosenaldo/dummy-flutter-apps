class Contact {
  Contact({
    required this.name,
    required this.email,
    required this.phone,
    this.photoName,
  });

  final String name;
  final String email;
  final String phone;
  final String? photoName;
}
