import 'shoes.dart';

class Store {
  final List<Shoes> _sneakers = [
    //basketball
    Shoes(
        name: 'Nike GT Cut 2 Hyperpink',
        imagePath: 'assets/img/basketball/hyperpink.png',
        description:
            'The Nike Zoom GT Cut 2 Hyper Pink is part of the second edition of Nike’s Greater Than (GT) series with a focus on Air Zoom technology.',
        price: 2500000,
        size: [40, 41, 42, 43, 44],
        category: SneakersCategory.basketball),
    Shoes(
        name: 'Nike GT Cut 2 We Are All Greater',
        imagePath: 'assets/img/basketball/weareallgreater.png',
        description:
            'The Nike Zoom GT Cut 2 We Are All Greater is a basketball shoe from the Nike Zoom GT Cut 2 lineup that celebrates the power of unity and collective strength.',
        price: 2200000,
        size: [40, 41, 42, 43, 44],
        category: SneakersCategory.basketball),
    Shoes(
        name: 'Nike Kobe 4 Philly',
        imagePath: 'assets/img/basketball/kobe4philly.png',
        description:
            'Introducing the Nike Kobe 4 Protro Philly 2024, a stunning tribute to Kobe Bryant`s birthplace and the historical city of Philadelphia',
        price: 4200000,
        size: [40, 41, 42, 43, 44],
        category: SneakersCategory.basketball),
    Shoes(
        name: 'Nike Kobe 5 Undeafeated',
        imagePath: 'assets/img/basketball/kobe5undefeated.png',
        description:
            'The Nike Kobe 5 Protro Undefeated What If Multi is a unique pair of sneakers with right and left shoes, each sporting different colors such as black, metallic gold, university red, and white.',
        price: 5600000,
        size: [40, 41, 42, 43, 44],
        category: SneakersCategory.basketball),
    Shoes(
        name: 'Nike Kobe 8 Protro Radiant Emerald',
        imagePath: 'assets/img/basketball/kobe8emerald.png',
        description:
            'This sneaker captures the essence of Kobe Bryant`s dynamic playstyle and his legacy on the court, featuring a sleek White, Radiant Emerald, White colorway that stands out in any crowd.',
        price: 5600000,
        size: [40, 41, 42, 43, 44],
        category: SneakersCategory.basketball),

    //sneaker
    Shoes(
        name: 'Air Jordan 1 High Dark Mocha',
        imagePath: 'assets/img/sneaker/aj1mocha.png',
        description:
            'The Dark Mocha 1 was one of the most anticipated releases in 2020 due to its familiar colorblocking that referenced two of the greatest Jordan 1s of all-time, the Jordan 1 Travis Scott and the Jordan 1 Black Toe.',
        price: 5200000,
        size: [40, 41, 42, 43, 44],
        category: SneakersCategory.sneaker),
    Shoes(
        name: 'Nike Dunk Low Georgetown',
        imagePath: 'assets/img/sneaker/dunklowgeorge.png',
        description:
            'The Nike Dunk Low Georgetown arrives with a smooth grey leather upper with Midnight Navy overlays and Swooshes.',
        price: 2200000,
        size: [40, 41, 42, 43, 44],
        category: SneakersCategory.sneaker),
    Shoes(
        name: 'Nike Dunk Low Grey Fog',
        imagePath: 'assets/img/sneaker/dunklowgrey.png',
        description:
            'The Nike Dunk Low Grey Fog features a white leather upper with Grey Fog leather overlays and Swooshes.',
        price: 1800000,
        size: [40, 41, 42, 43, 44],
        category: SneakersCategory.sneaker),

    //running

    //football
  ];

  /*
  * Getter 
  */

  List<Shoes> get sneakers => _sneakers;

  /*
  * operations 
  */

  // add to chart

  // remove from chart

  // get total price of chart

  // get total number of items in chart

  // clear chart

  /*
  * helpers 
  */

  // generate a receipt

  // generate a unique id for each transaction
}
