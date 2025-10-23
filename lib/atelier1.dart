import 'package:flutter/material.dart';

class ProfilePageM3 extends StatelessWidget {
  const ProfilePageM3({super.key});

  // Fonction helper pour construire une "chip" de statistique
  Widget _buildStatChip(String value, String label, ColorScheme colorScheme) {
    return Expanded(
      // NOUVEAU: Rend la chip expansive
      child: Container(
        // Padding ajusté
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: colorScheme.onSurfaceVariant,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mon Profil'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_bag_outlined),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/products');
            },
            tooltip: 'Voir les produits',
          ),
        ],
      ),

      // SUPPRESSION DE CENTER ET CONSTRAINED BOX
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          // Centrage des éléments (Photo, Nom, Titre)
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Étape 1: Photo de profil avec badge (Identique)
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [colorScheme.primary, colorScheme.secondary],
                    ),
                  ),
                  child: const CircleAvatar(
                    radius: 56,
                    backgroundImage: AssetImage(
                      'assets/images/profile_picture.png',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: colorScheme.primary,
                    shape: BoxShape.circle,
                    border: Border.all(color: colorScheme.surface, width: 2),
                  ),
                  child: Icon(
                    Icons.check,
                    color: colorScheme.onPrimary,
                    size: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Étape 2: Nom et titre (Identique, le centrage est géré par la Column)
            Text(
              'Helmi Lajnef',
              style: textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Videographer & CGI Artist',
              style: textTheme.bodyLarge?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 32),

            // Étape 3: Statistiques (Remplacé par Row + Expanded)
            // NOUVEAU: Row force les enfants (chips) à prendre toute la largeur
            Row(
              children: [
                _buildStatChip('128', 'Abonnés', colorScheme),
                const SizedBox(width: 12), // Espacement entre les chips
                _buildStatChip('56', 'Projets', colorScheme),
                const SizedBox(width: 12),
                _buildStatChip('2 ans', 'Expérience', colorScheme),
              ],
            ),
            const SizedBox(height: 32),

            // Étape 4: Section "À propos"
            // NOUVEAU: Le Card prendra automatiquement 100% de la largeur
            // du SingleChildScrollView car il n'est pas contraint.
            Align(
              // Utiliser Align pour forcer la Card à prendre 100% de la largeur
              alignment: Alignment.center,
              child: Card(
                elevation: 0,
                color: colorScheme.surfaceContainerHighest,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.info_outline, color: colorScheme.primary),
                          const SizedBox(width: 12),
                          Text(
                            'À propos',
                            style: textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Passionné par le développement mobile et les technologies innovantes. J\'aime créer des applications qui améliorent la vie des utilisateurs.',
                        style: textTheme.bodyLarge?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      // Étape 5: Bouton flottant (Identique)
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          debugPrint('Modification du profil');
        },
        icon: const Icon(Icons.edit),
        label: const Text('Modifier le profil'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
