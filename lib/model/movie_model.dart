class Movie{
  final String name;
  final String addr;

  Movie(
    {
    required this.name,
    required this.addr,
    }
  );

  String get getName{
    return name;
  }
  String get getAddr{
    return addr;
  }
}