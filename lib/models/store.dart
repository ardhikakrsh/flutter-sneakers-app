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
    Shoes(
        name: 'Nike P-6000 Flat Pewter',
        imagePath: 'assets/img/sneaker/p6000_flatpewter.png',
        description:
            'The Flat Pewter iteration of the Nike P-6000 sports of base of matte gray mesh overlaid with strips of white leather and metallic-looking synthetic material with hits of aqua-green TPU.',
        price: 1900000,
        size: [40, 41, 42, 43, 44],
        category: SneakersCategory.sneaker),
    Shoes(
        name: 'Nike P-6000 Metallic Silver Sail',
        imagePath: 'assets/img/sneaker/p6000_metallic.png',
        description:
            'The Metallic Silver Nike P-6000 features an upper base crafted from breathable metallic fabric. Both vertical and horizontal overlays are constructed of chrome synthetic leather course across the upper, making it glisten.',
        price: 2100000,
        size: [40, 41, 42, 43, 44],
        category: SneakersCategory.sneaker),
    //running
    Shoes(
        name: 'Nike Air Zoom Alphafly Next% Barely Volt Orange',
        imagePath: 'assets/img/running/alphafly_volt.png',
        description:
            'The Nike Air Zoom Alphafly Next Barely Volt Orange has responsive Zoom X foam cushioning, woven cotton laces, and sock-like construction for a snug fit.',
        price: 3200000,
        size: [40, 41, 42, 43, 44],
        category: SneakersCategory.running),
    Shoes(
        name: 'Nike Air Zoom Alphafly NEXT% Eliud Kipchoge',
        imagePath: 'assets/img/running/alphafly_eliud.png',
        description:
            'The Nike Air Zoom Alphafly Next Kenya is a high-performance running shoe designed for serious athletes. This shoe features Nike`s innovative Zoom Air technology, which provides responsive cushioning and a comfortable fit.',
        price: 4240000,
        size: [40, 41, 42, 43, 44],
        category: SneakersCategory.running),
    //football
    Shoes(
        name: 'Nike Phantom GX Elite SE FG Thunder Pack',
        imagePath: 'assets/img/football/phantom_thunder.png',
        description:
            'Introducing the Nike Phantom GX Elite SE FG "Thunder Pack", the ultimate weapon for field domination. These electrifying cleats ignite the pitch with their bold black and yellow "Thunder Pack" design.',
        price: 8460000,
        size: [40, 41, 42, 43, 44],
        category: SneakersCategory.football),
    Shoes(
        name: 'Nike Mercurial Dream Speed Superfly 8 Elite FG Bright Mango',
        imagePath: 'assets/img/football/mecurial_mango.png',
        description:
            'These high-performance Nike shoes combine style and functionality to boost your game. Whether you`re playing on grass or turf, these bright and bold sneakers will help you stand out.',
        price: 6870000,
        size: [40, 41, 42, 43, 44],
        category: SneakersCategory.football),
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
