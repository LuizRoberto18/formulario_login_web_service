import 'package:projeto_carros/pages/carro/carro.dart';

class ApiCarros{
  static Future<List<Carro>> getCarros() async {

    final carros = <Carro>[];

    await Future.delayed(Duration(seconds: 21));

    carros.add(Carro(nome: "Chevrolet Corvette Z06", urlFoto: "https://s3-sa-east-1.amazonaws.com/videos.livetouchdev.com.br/esportivos/Chevrolet_Corvette_Z06.png"));
    carros.add(Carro(nome: "BMW M5", urlFoto: "https://s3-sa-east-1.amazonaws.com/videos.livetouchdev.com.br/esportivos/BMW.png"));
    carros.add(Carro(nome: "Renault Megane RS Trophy", urlFoto: "https://s3-sa-east-1.amazonaws.com/videos.livetouchdev.com.br/esportivos/Renault_Megane_Trophy.png"));

    return carros;
  }
}