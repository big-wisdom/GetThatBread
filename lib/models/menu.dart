class Menu {
  final String title;

  Menu({this.title});

  Map<String, dynamic> toMap() {
    return {
      title: title,
    };
  }
}
