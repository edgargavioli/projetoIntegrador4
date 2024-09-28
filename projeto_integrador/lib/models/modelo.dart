import 'package:projeto_integrador/models/marca.dart';

class Modelo {
  final int id_modelo;
  final String nome;
  final Marca marca;

  Modelo({
    required this.id_modelo,
    required this.nome,
    required this.marca,
  });

  factory Modelo.fromJson(Map<String, dynamic> json) {
    return Modelo(
      id_modelo: json['id_modelo'],
      nome: json['nome'],
      marca: json[
          'marca'], // problema: pelo marca estar dentro de modelo, ele não consegue executar o construtor de marca, dando problema ao iniciar o item no inventario page
    ); // soluções possiveis: iniciar o construtor de marca dentro do construtor de modelo, ou separar marca e modelo em dois objetos distintos
  }

  Map<String, dynamic> toJson() {
    return {
      'id_modelo': id_modelo,
      'nome': nome,
      'marca': marca.toJson(),
    };
  }
}
