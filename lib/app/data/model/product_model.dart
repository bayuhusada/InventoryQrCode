class ProductModel {
    String code;
    String name;
    int prize;
    String productId;
    int qty;

    ProductModel({
        required this.code,
        required this.name,
        required this.prize,
        required this.productId,
        required this.qty,
    });

    factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        code: json["code"] ?? '',
        name: json["name"] ?? '',
        prize: json["prize"] ?? 0,
        productId: json["productId"] ?? '',
        qty: json["qty"] ?? 0,
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
        "prize": prize,
        "productId": productId,
        "qty": qty,
    };
}
