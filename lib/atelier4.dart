import 'package:flutter/material.dart';

// ============================
// Modèle de données
// ============================
class Product {
  final String name;
  final double price;
  final String image;
  final bool isNew;
  final double rating;

  const Product(
    this.name,
    this.price,
    this.image, {
    this.isNew = false,
    this.rating = 0.0,
  });
}

// ============================
// Page Liste des Produits
// ============================
class ProductListPageM3 extends StatelessWidget {
  const ProductListPageM3({super.key});

  final List<Product> products = const [
    Product(
      'iPhone 15',
      999,
      'assets/images/iphone-15.jpg',
      isNew: true,
      rating: 4.5,
    ),
    Product(
      'Samsung Galaxy',
      799,
      'assets/images/samsung.jpg',
      isNew: false,
      rating: 4.2,
    ),
    Product(
      'Google Pixel',
      699,
      'assets/images/google.jpg',
      isNew: true,
      rating: 4.7,
    ),
  ];

  // Construction d'une carte produit
  Widget _buildProductCard(Product product, BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image du produit avec badge
            Stack(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: colorScheme.surfaceContainerHighest,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(product.image, fit: BoxFit.cover),
                  ),
                ),
                if (product.isNew)
                  Positioned(
                    top: 4,
                    right: 4,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme.primary,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'Nouveau',
                        style: TextStyle(
                          color: colorScheme.onPrimary,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 16),

            // Infos du produit
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Rating
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        product.rating.toString(),
                        style: TextStyle(
                          color: colorScheme.onSurfaceVariant,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Prix
                  Text(
                    '${product.price.toStringAsFixed(0)}€',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),

            // Bouton +
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: colorScheme.primary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: IconButton(
                    onPressed: () {
                      // Navigation vers la page de détail
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => ProductDetailPage(product: product),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.add,
                      color: colorScheme.onPrimary,
                      size: 20,
                    ),
                    padding: const EdgeInsets.all(4),
                    constraints: const BoxConstraints(
                      minWidth: 36,
                      minHeight: 36,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Ajouter',
                  style: TextStyle(
                    color: colorScheme.onSurfaceVariant,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ============================
  // BUILD PRINCIPAL
  // ============================
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nos Produits'),
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return _buildProductCard(products[index], context);
        },
      ),
    );
  }
}

// ============================
// Page Détail Produit
// ============================
class ProductDetailPage extends StatefulWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final ValueNotifier<int> _quantity = ValueNotifier<int>(1);

  @override
  void dispose() {
    _quantity.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // SliverAppBar avec image
          SliverAppBar(
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(widget.product.image, fit: BoxFit.cover),
            ),
            pinned: true,
            actions: [
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: colorScheme.surface.withAlpha((0.8 * 255).round()),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.favorite_border,
                    color: colorScheme.onSurface,
                  ),
                ),
                onPressed: () {},
              ),
            ],
          ),

          // Contenu principal
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nom + Prix
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.product.name,
                        style: textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${widget.product.price.toStringAsFixed(2)}€',
                        style: textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  Text(
                    '+ 0.0 (128 m/s)',
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 24),

                  Text(
                    'Description',
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Découvrez le ${widget.product.name}, un produit haute performance conçu pour répondre à tous vos besoins. Design élégant et fonctionnalités avancées.',
                    style: textTheme.bodyLarge?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),

                  Text(
                    'Quantité',
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: colorScheme.outline),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            if (_quantity.value > 1) {
                              _quantity.value--;
                            }
                          },
                          icon: Icon(
                            Icons.remove,
                            color: colorScheme.onSurface,
                          ),
                        ),
                        ValueListenableBuilder<int>(
                          valueListenable: _quantity,
                          builder: (context, quantity, child) {
                            return SizedBox(
                              width: 40,
                              child: Text(
                                quantity.toString(),
                                textAlign: TextAlign.center,
                                style: textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          onPressed: () {
                            _quantity.value++;
                          },
                          icon: Icon(Icons.add, color: colorScheme.onSurface),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),

      // Bouton en bas
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          border: Border(
            top: BorderSide(
              color: colorScheme.outline.withAlpha((0.2 * 255).round()),
            ),
          ),
        ),
        child: Row(
          children: [
            ValueListenableBuilder<int>(
              valueListenable: _quantity,
              builder: (context, quantity, child) {
                final totalPrice = widget.product.price * quantity;
                return Text(
                  '${totalPrice.toStringAsFixed(2)}€',
                  style: textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                  ),
                );
              },
            ),
            const SizedBox(width: 12),
            Expanded(
              child: FilledButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${widget.product.name} ajouté au panier'),
                    ),
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('Ajouter au panier'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================
// MAIN (pour tester directement)
// ============================
void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductListPageM3(),
    ),
  );
}
