class Transacao {
  int id, tipo, conta;
  String titulo, descricao, data;
  double valor;

  Transacao({this.id, this.tipo, this.conta, this.titulo, this.descricao,
  this.data, this.valor});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'tipo': tipo,
      'conta': conta,
      'titulo': titulo,
      'descricao': descricao,
      'data': data,
      'valor': valor,
    };
  }

  Transacao.fromMap(Map map){
    id = map["id"];
    tipo = map["tipo"];
    conta = map["conta"];
    titulo = map["titulo"];
    descricao = map["descricao"];
    data = map["data"];
    valor = map["valor"];
  }
}