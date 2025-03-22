class Shoes {
  final String id;
  final String name; // nike gt cut 2 hyperpink
  final String imagePath; // assets/img/hyperpink.png
  final String
      description; // The Nike GT Cut 2 Hyperpink is a basketball shoe that is designed for players who want to take their game to the next level. It features a lightweight and breathable upper that provides support and stability. The shoe also has a responsive cushioning system that helps to absorb impact and reduce fatigue. The Nike GT Cut 2 Hyperpink is available in a range of sizes and colors, so you can find the perfect fit for your game.
  final int price; // 2.500.000
  final List<double> size; // [40, 40.5, 42, 43, 44]
  final SneakersCategory category; // basketball

  Shoes({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.description,
    required this.price,
    required this.size,
    required this.category,
  });
}

enum SneakersCategory {
  basketball,
  football,
  running,
  sneaker,
}
