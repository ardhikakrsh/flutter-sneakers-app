import 'package:flutter/material.dart';
import 'package:ppb_test/models/shoes.dart';

class MyCategories extends StatefulWidget {
  final SneakersCategory selectedCategory;
  final Function(SneakersCategory) onCategorySelected;
  const MyCategories(
      {super.key,
      required this.selectedCategory,
      required this.onCategorySelected});

  @override
  State<MyCategories> createState() => _MyCategoriesState();
}

class _MyCategoriesState extends State<MyCategories> {
  int selectedIndex = 0; // Untuk melacak kategori yang dipilih

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40, // Meningkatkan tinggi agar lebih proporsional
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: SneakersCategory.values.length,
        itemBuilder: (context, index) {
          bool isSelected = selectedIndex == index;
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
                // Perbarui kategori yang dipilih
              });
              widget.onCategorySelected(SneakersCategory
                  .values[index]); // Panggil fungsi onCategorySelected
// untuk memberikan kategori yang dipilih ke parent widget
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.blue
                    : Colors.grey[300], // Warna berubah jika dipilih
                borderRadius: BorderRadius.circular(25),
              ),
              child: SizedBox(
                width: 80,
                child: Center(
                  child: Text(
                    SneakersCategory.values[index].toString().split('.').last,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
