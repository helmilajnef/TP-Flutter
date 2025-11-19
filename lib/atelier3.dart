/*import 'package:flutter/material.dart';
import 'package:flutter_application_1/atelier2.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final ValueNotifier<int> _quantity = ValueNotifier<int>(1);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Étape 1: SliverAppBar
          SliverAppBar(
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                widget.product.image,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: colorScheme.surfaceContainerHighest,
                    child: Icon(
                      Icons.shopping_bag,
                      color: colorScheme.onSurfaceVariant,
                      size: 60,
                    ),
                  );
                },
              ),
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

          // Étape 2: Contenu détaillé
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nom et prix
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

                  // Indicateur de vitesse (exemple)
                  Text(
                    '+ 0.0 (128 m/s)',
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Section Description
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

                  // Étape 3: Sélecteur de quantité
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
                        // Bouton -
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

                        // Quantité
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

                        // Bouton +
                        IconButton(
                          onPressed: () {
                            _quantity.value++;
                          },
                          icon: Icon(Icons.add, color: colorScheme.onSurface),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 100), // Espace pour le bouton fixe
                ],
              ),
            ),
          ),
        ],
      ),

      // Étape 4: Bouton fixe en bas
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
            // Prix total
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
                  // Action d'ajout au panier
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
}*/
