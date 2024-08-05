class Model {
  final int id;
  final String nombre;
  final String tipo;
  final String longitud;
  final String velocidadMaxima;

  Model({
    required this.id,
    required this.nombre,
    required this.tipo,
    required this.longitud,
    required this.velocidadMaxima,
  });

  factory Model.fromJson(Map<String, dynamic> json) {
    return Model(
      id: json['id'],
      nombre: json['nombre'],
      tipo: json['tipo'],
      longitud: json['longitud'],
      velocidadMaxima: json['velocidadMaxima'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'tipo': tipo,
      'longitud': longitud,
      'velocidadMaxima': velocidadMaxima,
    };
  }
}
