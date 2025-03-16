import 'package:flutter/material.dart';

class StorageTypesPage extends StatelessWidget {
  const StorageTypesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> storageTypes = [
      {
        'title': 'Underground Storage Tank',
        'description': 'Best for large-scale water storage, minimizing evaporation losses.',
        'icon': Icons.storage,
        'color': Colors.blue.shade300,
      },
      {
        'title': 'Overhead Storage Tank',
        'description': 'Ideal for residential and commercial use with gravity-fed water supply.',
        'icon': Icons.storage_rounded,
        'color': Colors.blue.shade400,
      },
      {
        'title': 'Rain Barrels',
        'description': 'Simple and cost-effective method for collecting rainwater from rooftops.',
        'icon': Icons.invert_colors,
        'color': Colors.blue.shade500,
      },
      {
        'title': 'Percolation Pits',
        'description': 'Allows rainwater to seep into the ground, replenishing groundwater levels.',
        'icon': Icons.filter_alt,
        'color': Colors.blue.shade600,
      },
      {
        'title': 'Modular Tanks',
        'description': 'Flexible storage solutions for rainwater harvesting with expandable capacity.',
        'icon': Icons.view_module,
        'color': Colors.blue.shade700,
      },
      {
        'title': 'Natural Ponds/Lakes',
        'description': 'Used for large-scale rainwater harvesting and ecosystem sustainability.',
        'icon': Icons.nature,
        'color': Colors.blue.shade800,
      },
    ];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Back Button & Title
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      color: Color(0xFF023E8A),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Expanded(
                      child: Center(
                        child: Text(
                          'STORAGE TYPES',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF023E8A),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Storage Cards
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: storageTypes.length,
                  itemBuilder: (context, index) {
                    final item = storageTypes[index];
                    return _buildStorageCard(
                      item['title'],
                      item['description'],
                      item['icon'],
                      item['color'],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStorageCard(String title, String description, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 40, color: Colors.white),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
