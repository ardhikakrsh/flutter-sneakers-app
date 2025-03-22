import 'package:flutter/material.dart';
import 'package:ppb_test/components/my_categories.dart';
import 'package:ppb_test/models/shoes.dart';
import 'package:ppb_test/models/store.dart';
import 'package:ppb_test/view/pages/sneakers/sneakers_detail_page.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SneakersCategory selectedCategory = SneakersCategory.basketball; // by default

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    List<Shoes> categoryShoes = Store()
        .sneakers
        .where((shoes) => shoes.category == selectedCategory)
        .toList();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 10,
                ),
                child: Column(
                  children: [
                    const Row(
                      children: [
                        Expanded(
                          child: Text(
                            'What sneakers\nare you looking for?',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              height: 1.2,
                            ),
                            softWrap: true,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const SizedBox(height: 15),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Search sneakers',
                            prefixIcon: const Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset(
                                'assets/img/slide1.jpg',
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: 30,
                              left: 15,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Find the latest\nsneakers here',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      height: 1,
                                      shadows: [
                                        Shadow(
                                          color: Colors.black,
                                          blurRadius: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  ElevatedButton(
                                    onPressed: () {},
                                    child: const Text('Explore'),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Categories',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        MyCategories(
                          selectedCategory: selectedCategory,
                          onCategorySelected: (category) {
                            setState(() {
                              selectedCategory = category;
                            });
                          },
                        ),
                        const SizedBox(height: 10),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: categoryShoes.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading:
                                  Image.asset(categoryShoes[index].imagePath),
                              title: Text(categoryShoes[index].name),
                              subtitle: Text(
                                NumberFormat.currency(
                                  locale: 'id',
                                  symbol: 'Rp',
                                  decimalDigits: 0,
                                ).format(categoryShoes[index].price),
                                style: TextStyle(
                                  color: isDarkMode
                                      ? Colors.greenAccent
                                      : Colors.green,
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SneakersDetailPage(
                                      shoe: categoryShoes[index],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
