import 'package:flutter/material.dart';
import 'package:shoppingapp/global_variables.dart';
import 'package:shoppingapp/product_card.dart';
import 'package:shoppingapp/product_details_page.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final List<String> filters = const ['All', 'Bata', 'Service', 'Addidas'];
  late String selectfilter;

  @override
  void initState() {
    super.initState();
    selectfilter = filters[0];
  }

  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromRGBO(255, 255, 255, 1),
      ),
      borderRadius: BorderRadius.horizontal(
        left: Radius.circular(50),
      ),
    );
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    'Shoes\nCollection',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: Icon(Icons.search),
                      border: border,
                      enabledBorder: border,
                      focusedBorder: border,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 120,
              child: ListView.builder(
                itemCount: filters.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final filter = filters[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectfilter = filter;
                        });
                      },
                      child: Chip(
                        backgroundColor: selectfilter == filter
                            ? Theme.of(context).colorScheme.primary
                            : const Color.fromRGBO(245, 245, 249, 1),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        label: Text(filter),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return ProductDetailsPage(product: product);
                          },
                        ),
                      );
                    },
                    child: ProductCard(
                      title: product['title'] as String,
                      price: product['price'] as double,
                      image: product['imageUrl'] as String,
                      backgroundcolor: index.isEven
                          ? const Color.fromRGBO(216, 240, 253, 1)
                          : const Color.fromRGBO(245, 245, 249, 1),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
