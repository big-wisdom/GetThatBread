class Menu {
  final String title;
  final String id;

  Menu({
    this.title,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      title: title,
      id: id,
    };
  }
}
