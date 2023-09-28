import 'package:hive/hive.dart';

part 'pessoa.g.dart';

@HiveType(typeId: 0)
class Pessoa extends HiveObject {
  @HiveField(0)
  String nome;

  @HiveField(1)
  double peso;

  @HiveField(2)
  double altura;

  Pessoa(this.nome, this.peso, this.altura);
}
