import 'package:flutter/material.dart';
import 'atelier5.dart';

class CartSummaryPage extends StatefulWidget {
  final CartManager cartManager;
  const CartSummaryPage({super.key, required this.cartManager});

  @override
  State<CartSummaryPage> createState() => _CartSummaryPageState();
}

class _CartSummaryPageState extends State<CartSummaryPage> {
  final _emailController = TextEditingController();
  final _cardController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _cardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double subtotal = widget.cartManager.totalPrice;
    double livraison = widget.cartManager.items.isEmpty ? 0.0 : 8.0;
    double taxes = subtotal * 0.19;
    double total = subtotal + livraison + taxes;

    return Scaffold(
      backgroundColor: const Color(0xfffaf7fd),

      // ----------------------------------------------------------------
      // APPBAR AVEC CORBEILLE POUR SUPPRIMER TOUT LE PANIER
      // ----------------------------------------------------------------
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.3,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Récapitulatif du Panier",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever, color: Colors.red, size: 28),
            onPressed: () {
              if (widget.cartManager.items.isEmpty) return;

              showDialog(
                context: context,
                builder:
                    (_) => AlertDialog(
                      title: const Text("Vider le panier"),
                      content: const Text(
                        "Voulez-vous vraiment supprimer tous les articles ?",
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Annuler"),
                        ),
                        TextButton(
                          onPressed: () {
                            widget.cartManager.clearCart();
                            Navigator.pop(context);
                            setState(() {});
                          },
                          child: const Text(
                            "Supprimer",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
              );
            },
          ),
        ],
      ),

      // ----------------------------------------------------------------
      // SI PANIER VIDE
      // ----------------------------------------------------------------
      body:
          widget.cartManager.items.isEmpty
              ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.shopping_cart_outlined,
                      size: 80,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Votre panier est vide',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Retour aux produits'),
                    ),
                  ],
                ),
              )
              // ----------------------------------------------------------------
              // SI PANIER CONTIENT DES PRODUITS
              // ----------------------------------------------------------------
              : SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 12),

                    // 🔥 Tous les produits du panier
                    ...List.generate(widget.cartManager.items.length, (index) {
                      final item = widget.cartManager.items[index];
                      return _buildCartItemCard(item, index);
                    }),

                    const SizedBox(height: 12),

                    // ----------------------------------------------------------
                    // RÉSUMÉ DU PANIER
                    // ----------------------------------------------------------
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Column(
                        children: [
                          _buildSummaryRow("Sous-total", subtotal),
                          _buildSummaryRow("Frais de livraison", livraison),
                          _buildSummaryRow("Taxes", taxes),

                          const Divider(thickness: 1),

                          _buildSummaryRow(
                            "Total",
                            total,
                            isTotal: true,
                            color: Colors.deepPurple,
                          ),

                          const SizedBox(height: 20),

                          // ------------------------------------------------------
                          // EMAIL
                          // ------------------------------------------------------
                          _buildInputField(
                            controller: _emailController,
                            icon: Icons.email_outlined,
                            hint: "Email",
                          ),

                          const SizedBox(height: 10),

                          // ------------------------------------------------------
                          // NUMÉRO DE CARTE
                          // ------------------------------------------------------
                          _buildInputField(
                            controller: _cardController,
                            icon: Icons.credit_card,
                            hint: "Numéro de carte (simulation)",
                          ),

                          const SizedBox(height: 20),

                          // ------------------------------------------------------
                          // BOUTON PAYER
                          // ------------------------------------------------------
                          SizedBox(
                            width: double.infinity,
                            height: 55,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepPurple,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder:
                                      (_) => AlertDialog(
                                        title: const Text('Paiement'),
                                        content: Text(
                                          'Total payé : ${total.toStringAsFixed(2)} DT',
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              widget.cartManager.clearCart();
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                            },
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      ),
                                );
                              },
                              child: Text(
                                "Payer ${total.toStringAsFixed(2)} DT",
                                style: const TextStyle(
                                  fontSize: 17,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
    );
  }

  // ----------------------------------------------------------------------
  // WIDGET : CARD PRODUIT
  // ----------------------------------------------------------------------
  Widget _buildCartItemCard(CartItem item, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // IMAGE
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey.shade100,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                item.product.image,
                fit: BoxFit.cover,
                errorBuilder:
                    (_, __, ___) => const Icon(Icons.phone_android, size: 40),
              ),
            ),
          ),

          const SizedBox(width: 12),

          // INFOS PRODUIT
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.product.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '${item.product.price.toStringAsFixed(0)} DT',
                  style: const TextStyle(fontSize: 14, color: Colors.purple),
                ),
              ],
            ),
          ),

          // QUANTITÉ
          Row(
            children: [
              _qtyBtn(
                () => setState(() {
                  widget.cartManager.updateQuantity(index, item.quantity - 1);
                }),
                Icons.remove,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  '${item.quantity}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              _qtyBtn(
                () => setState(() {
                  widget.cartManager.updateQuantity(index, item.quantity + 1);
                }),
                Icons.add,
              ),
            ],
          ),

          const SizedBox(width: 8),

          // SUPPRIMER L’ITEM
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.red),
            onPressed: () {
              widget.cartManager.removeFromCart(index);
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _qtyBtn(VoidCallback action, IconData icon) {
    return InkWell(
      onTap: action,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xfff1eafe),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(6),
        child: Icon(icon, size: 18, color: Colors.purple),
      ),
    );
  }

  // ----------------------------------------------------------------------
  // RÉSUMÉ LIGNE
  // ----------------------------------------------------------------------
  Widget _buildSummaryRow(
    String label,
    double amount, {
    bool isTotal = false,
    Color? color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 15, color: Colors.black87),
          ),
          Text(
            '${amount.toStringAsFixed(2)} DT',
            style: TextStyle(
              fontSize: isTotal ? 18 : 15,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: color ?? Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  // ----------------------------------------------------------------------
  // INPUT FIELD
  // ----------------------------------------------------------------------
  Widget _buildInputField({
    required TextEditingController controller,
    required IconData icon,
    required String hint,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.black54),
          hintText: hint,
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
