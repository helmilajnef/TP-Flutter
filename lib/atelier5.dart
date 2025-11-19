import 'package:flutter/material.dart';

// ============================
// Modèle Produit
// ============================
class Product {
  final String name;
  final double price;
  final String image;
  final bool isNew;
  final double rating;
  final Map<String, String> specifications;

  const Product(
    this.name,
    this.price,
    this.image, {
    this.isNew = false,
    this.rating = 0.0,
    this.specifications = const {},
  });
}

// ============================
// Modèle Panier
// ============================
class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

class CartManager extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  int get totalItems => _items.fold(0, (sum, item) => sum + item.quantity);

  double get totalPrice =>
      _items.fold(0, (sum, item) => sum + (item.product.price * item.quantity));

  void addToCart(Product product, int quantity) {
    final index = _items.indexWhere(
      (item) => item.product.name == product.name,
    );
    if (index >= 0) {
      _items[index].quantity += quantity;
    } else {
      _items.add(CartItem(product: product, quantity: quantity));
    }
    notifyListeners();
  }

  void removeFromCart(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  void updateQuantity(int index, int quantity) {
    if (quantity > 0) {
      _items[index].quantity = quantity;
    } else {
      _items.removeAt(index);
    }
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}

// ============================
// Liste Produits
// ============================
final List<Product> demoProducts = const [
  Product(
    'iPhone 15',
    999,
    'assets/images/iphone-15.jpg',
    isNew: true,
    rating: 4.5,
    specifications: {
      'Écran': '6.1 pouces Super Retina XDR',
      'Processeur': 'A16 Bionic',
      'Mémoire': '128 GB',
      'Batterie': "Jusqu'à 20h de vidéo",
    },
  ),
  Product(
    'Samsung Galaxy',
    799,
    'assets/images/samsung.jpg',
    isNew: false,
    rating: 4.2,
    specifications: {
      'Écran': '6.4 pouces Dynamic AMOLED',
      'Processeur': 'Snapdragon 8 Gen 2',
      'Mémoire': '256 GB',
      'Batterie': "Jusqu'à 18h de vidéo",
    },
  ),
  Product(
    'Google Pixel',
    699,
    'assets/images/google.jpg',
    isNew: true,
    rating: 4.7,
    specifications: {
      'Écran': '6.2 pouces OLED',
      'Processeur': 'Google Tensor G3',
      'Mémoire': '128 GB',
      'Batterie': "Jusqu'à 24h d'autonomie",
    },
  ),
];

// ============================
// Page Liste Produits
// ============================
class ProductListPageM3 extends StatelessWidget {
  final CartManager cartManager;

  const ProductListPageM3({super.key, required this.cartManager});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nos Produits'),
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.person),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () => _showCartBottomSheet(context),
              ),
              if (cartManager.totalItems > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '${cartManager.totalItems}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(top: 8, bottom: 16),
        itemCount: demoProducts.length,
        itemBuilder:
            (context, index) => ProductCard(
              product: demoProducts[index],
              cartManager: cartManager,
            ),
      ),
    );
  }

  void _showCartBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CartBottomSheet(cartManager: cartManager),
    );
  }
}

// ============================
// Carte Produit
// ============================
class ProductCard extends StatefulWidget {
  final Product product;
  final CartManager cartManager;

  const ProductCard({
    required this.product,
    required this.cartManager,
    super.key,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Material(
        elevation: 3,
        borderRadius: BorderRadius.circular(16),
        color: colorScheme.surface,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => setState(() => _isExpanded = !_isExpanded),
          child: AnimatedSize(
            duration: const Duration(milliseconds: 300),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image + Infos
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: colorScheme.surfaceVariant,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                widget.product.image,
                                fit: BoxFit.cover,
                                errorBuilder:
                                    (_, __, ___) => Icon(
                                      Icons.phone_android,
                                      size: 40,
                                      color: colorScheme.primary,
                                    ),
                              ),
                            ),
                          ),
                          if (widget.product.isNew)
                            Positioned(
                              top: 0,
                              right: -30,
                              child: Transform.rotate(
                                angle: 0.4,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 4,
                                  ),
                                  color: colorScheme.primary,
                                  child: Text(
                                    'NOUVEAU',
                                    style: TextStyle(
                                      color: colorScheme.onPrimary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.product.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Text(widget.product.rating.toString()),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${widget.product.price.toStringAsFixed(0)} €',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          IconButton(
                            onPressed: () {
                              widget.cartManager.addToCart(widget.product, 1);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    '${widget.product.name} ajouté au panier',
                                  ),
                                  backgroundColor: colorScheme.primary,
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.add_shopping_cart,
                              color: colorScheme.primary,
                            ),
                          ),
                          Icon(
                            _isExpanded
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (_isExpanded)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children:
                          widget.product.specifications.entries
                              .map(
                                (e) => Chip(
                                  label: Text('${e.key}: ${e.value}'),
                                  backgroundColor: colorScheme.surfaceVariant
                                      .withAlpha(50),
                                ),
                              )
                              .toList(),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ============================
// Panier Bottom Sheet
// ============================
class CartBottomSheet extends StatelessWidget {
  final CartManager cartManager;
  const CartBottomSheet({super.key, required this.cartManager});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.5,
      maxChildSize: 0.9,
      builder:
          (context, scrollController) => Container(
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 12),
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: colorScheme.onSurfaceVariant.withAlpha(77),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child:
                      cartManager.items.isEmpty
                          ? Center(
                            child: Text(
                              'Votre panier est vide',
                              style: TextStyle(
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          )
                          : ListView.builder(
                            controller: scrollController,
                            itemCount: cartManager.items.length,
                            itemBuilder: (context, index) {
                              final item = cartManager.items[index];
                              return Card(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                child: ListTile(
                                  leading: Image.asset(
                                    item.product.image,
                                    width: 50,
                                    height: 50,
                                    errorBuilder:
                                        (_, __, ___) =>
                                            Icon(Icons.phone_android),
                                  ),
                                  title: Text(item.product.name),
                                  subtitle: Text(
                                    '${item.quantity} x ${item.product.price} € = ${(item.quantity * item.product.price).toStringAsFixed(2)} €',
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.remove),
                                        onPressed:
                                            () => cartManager.updateQuantity(
                                              index,
                                              item.quantity - 1,
                                            ),
                                      ),
                                      Text('${item.quantity}'),
                                      IconButton(
                                        icon: const Icon(Icons.add),
                                        onPressed:
                                            () => cartManager.updateQuantity(
                                              index,
                                              item.quantity + 1,
                                            ),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed:
                                            () => cartManager.removeFromCart(
                                              index,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                ),
                if (cartManager.items.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: colorScheme.outline.withAlpha(50),
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total: ${cartManager.totalPrice.toStringAsFixed(2)} €',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: colorScheme.primary,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Commande validée !'),
                              ),
                            );
                            cartManager.clearCart();
                            Navigator.pop(context);
                          },
                          child: const Text('Passer la commande'),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
    );
  }
}
