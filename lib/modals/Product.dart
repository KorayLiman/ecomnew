class Product {
  String ProductID;
  String ProductName;
  int? Amount;
  double? Weight;
  String ImageURL;
  double Price;
  String Explanation;

  Product(
      {required this.Explanation,
      required this.ImageURL,
      required this.Price,
      required this.ProductID,
      required this.ProductName,
      this.Amount,
      this.Weight});

  Map<String, dynamic> ToMap() {
    return {
      "ProductID": ProductID,
      "ProductName": ProductName,
      "ImageURL": ImageURL,
      "Price": Price,
      "Explanation": Explanation,
      "Amount": Amount ?? -1,
      "Weight": Weight ?? -1.0
    };
  }

  Product.FromMap(Map<String, dynamic> map)
      : ProductID = map["ProductID"],
        ProductName = map["ProductName"],
        ImageURL = map["ImageURL"],
        Price = map["Price"],
        Explanation = map["Explanation"],
        Amount = map["Amount"],
        Weight = map["Weight"];
}
