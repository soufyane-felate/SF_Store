class Product {
  final String name;
  final String description;
  final String quantite;
  final String price;
  final bool isSwitched;
  final List<String> sizes;
  final List<String> imagePaths;

  Product({
    required this.name,
    required this.description,
    required this.quantite,
    required this.price,
    required this.isSwitched,
    required this.sizes,
    required this.imagePaths, 
  });
}
