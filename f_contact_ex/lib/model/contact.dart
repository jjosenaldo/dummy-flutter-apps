class Contact {
  Contact({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.photoName,
  });

  final int id;
  final String name;
  final String email;
  final String phone;
  final String? photoName;

  @override
  String toString() {
    return '[$id] $name, $phone, $email, ${photoName ?? ''}';
  }
}
