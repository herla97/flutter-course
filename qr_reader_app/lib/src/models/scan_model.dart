class ScanModel {
    int id;
    String type;
    String value;

    ScanModel({
        this.id,
        this.type,
        this.value,
    }){
      if (this.value.contains('http')) {
        this.type = 'http';
      }else {
        this.type = 'geo';
      }
    }

    // El factory: es poder crear una nueva instancia del scan model
    factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
        id   : json["id"],
        type : json["type"],
        value: json["value"],
    );


    Map<String, dynamic> toJson() => {
        "id"   : id,
        "type" : type,
        "value": value,
    };
}
