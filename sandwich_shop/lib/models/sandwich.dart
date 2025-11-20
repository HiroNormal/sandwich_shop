enum BreadType { white, wheat, wholemeal }

enum SandwichType {
  veggieDelight,
  chickenTeriyaki,
  tunaMelt,
  meatballMarinara,
}

class Sandwich {
  final SandwichType type;
  final bool isFootlong;
  final BreadType breadType;

  Sandwich({
    required this.type,
    required this.isFootlong,
    required this.breadType,
  });

  // Price logic: base price per 6-inch, footlong = 2x
  double get price {
    double base;
    switch (type) {
      case SandwichType.veggieDelight:
        base = 5.0;
        break;
      case SandwichType.chickenTeriyaki:
        base = 6.5;
        break;
      case SandwichType.tunaMelt:
        base = 6.0;
        break;
      // add other types as needed
      default:
        base = 5.0;
    }
    return isFootlong ? base * 2 : base;
  }

  // Optional helpers used by main.dart
  String get name {
    switch (type) {
      case SandwichType.veggieDelight:
        return 'Veggie Delight';
      case SandwichType.chickenTeriyaki:
        return 'Chicken Teriyaki';
      case SandwichType.tunaMelt:
        return 'Tuna Melt';
      case SandwichType.meatballMarinara:
        return 'Meatball Marinara';
    }
  }

  String get image {
    // adjust to match your assets layout
    return 'assets/images/${type.name}_${isFootlong ? "footlong" : "sixinch"}.png';
  }
}

