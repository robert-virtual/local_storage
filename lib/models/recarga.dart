class Recarga {
  String cod;
  String title;
  String description;
  String duracion;
  int price;

  Recarga(
      {required this.cod,
      required this.title,
      required this.description,
      required this.duracion,
      required this.price});
  factory Recarga.fromJson(Map<String, dynamic> json) {
    return Recarga(
        cod: json['cod'],
        title: json['title'],
        description: json['description'],
        duracion: json['duration'],
        price: json['price']);
  }
}
