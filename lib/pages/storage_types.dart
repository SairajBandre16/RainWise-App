import 'package:flutter/material.dart';

// Main Storage Types Page
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
        'detailDescription': 'Underground storage tanks are durable structures installed below ground level. They provide excellent protection from sunlight and temperature variations, resulting in minimal evaporation and algae growth. Ideal for large-scale residential, commercial, or industrial applications.',
        'estimatedCost': '\$2,000 - \$15,000 depending on size and materials',
        'images': [
          'https://example.com/underground_tank1.jpg',
          'https://example.com/underground_tank2.jpg',
        ],
        'pros': [
          'Saves space above ground',
          'Lower evaporation losses',
          'Protected from external elements',
          'Temperature stable water storage'
        ],
        'cons': [
          'Higher installation costs',
          'Difficult to detect leaks',
          'Requires professional installation',
          'More complex maintenance'
        ],
      },
      {
        'title': 'Overhead Storage Tank',
        'description': 'Ideal for residential and commercial use with gravity-fed water supply.',
        'icon': Icons.storage_rounded,
        'color': Colors.blue.shade400,
        'detailDescription': 'Overhead tanks are elevated water storage structures that use gravity to distribute water. Theyre commonly installed on rooftops or purpose-built platforms and are ideal for providing consistent water pressure without pumps.',
        'estimatedCost': '\$500 - \$5,000 depending on size, material, and elevation requirements',
        'images': [
          'https://example.com/overhead_tank1.jpg',
          'https://example.com/overhead_tank2.jpg',
        ],
        'pros': [
          'Gravity-fed system requires no electricity',
          'Easier installation than underground systems',
          'Easy to monitor water levels',
          'Simple maintenance'
        ],
        'cons': [
          'Occupies roof/outdoor space',
          'Subject to temperature variations',
          'Structural support requirements',
          'Can be visually obtrusive'
        ],
      },
      {
        'title': 'Rain Barrels',
        'description': 'Simple and cost-effective method for collecting rainwater from rooftops.',
        'icon': Icons.invert_colors,
        'color': Colors.blue.shade500,
        'detailDescription': 'Rain barrels are containers that collect and store rainwater from rooftops and downspouts. Theyre an environmentally friendly and economical solution for gardens and small-scale irrigation needs.',
        'estimatedCost': '\$50 - \$200 per barrel',
        'images': [
          'https://example.com/rain_barrel1.jpg',
          'https://example.com/rain_barrel2.jpg',
        ],
        'pros': [
          'Affordable and easy to install',
          'Reduces water bills',
          'Simple to maintain',
          'Environmentally friendly'
        ],
        'cons': [
          'Limited storage capacity',
          'May require multiple units',
          'Potential for mosquito breeding',
          'Not suitable for drinking water'
        ],
      },
      {
        'title': 'Percolation Pits',
        'description': 'Allows rainwater to seep into the ground, replenishing groundwater levels.',
        'icon': Icons.filter_alt,
        'color': Colors.blue.shade600,
        'detailDescription': 'Percolation pits are excavated trenches filled with porous materials that allow rainwater to gradually seep into the soil. They help recharge groundwater and prevent runoff, supporting sustainable water management.',
        'estimatedCost': '\$300 - \$1,000 depending on size and materials',
        'images': [
          'https://example.com/percolation_pit1.jpg',
          'https://example.com/percolation_pit2.jpg',
        ],
        'pros': [
          'Recharges groundwater',
          'Reduces flooding and erosion',
          'Low maintenance',
          'Space-efficient solution'
        ],
        'cons': [
          'Not for direct water usage',
          'Effectiveness varies by soil type',
          'May clog over time',
          'Requires periodic maintenance'
        ],
      },
      {
        'title': 'Modular Tanks',
        'description': 'Flexible storage solutions for rainwater harvesting with expandable capacity.',
        'icon': Icons.view_module,
        'color': Colors.blue.shade700,
        'detailDescription': 'Modular tanks consist of interconnected units that can be added or removed to adjust storage capacity. They offer flexibility in installation and are adaptable to changing water storage needs.',
        'estimatedCost': '\$800 - \$3,000 depending on capacity and configuration',
        'images': [
          'https://example.com/modular_tank1.jpg',
          'https://example.com/modular_tank2.jpg',
        ],
        'pros': [
          'Customizable capacity',
          'Can be expanded over time',
          'Adaptable to available space',
          'Relatively easy installation'
        ],
        'cons': [
          'More expensive than single tanks',
          'Requires connection planning',
          'May need professional setup',
          'Potential for leaks at connection points'
        ],
      },
      {
        'title': 'Natural Ponds/Lakes',
        'description': 'Used for large-scale rainwater harvesting and ecosystem sustainability.',
        'icon': Icons.nature,
        'color': Colors.blue.shade800,
        'detailDescription': 'Natural ponds and constructed lakes can serve as large-scale rainwater collection systems while creating habitats for local wildlife. They integrate water conservation with ecological benefits.',
        'estimatedCost': '\$5,000 - \$30,000+ depending on size, design, and landscaping',
        'images': [
          'https://example.com/natural_pond1.jpg',
          'https://example.com/natural_pond2.jpg',
        ],
        'pros': [
          'Large storage capacity',
          'Creates wildlife habitat',
          'Aesthetic landscape feature',
          'Long-term sustainability'
        ],
        'cons': [
          'Significant space requirements',
          'Higher initial investment',
          'Potential for evaporation',
          'Requires ecological management'
        ],
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
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StorageDetailPage(storageData: item),
                          ),
                        );
                      },
                      child: _buildStorageCard(
                        item['title'],
                        item['description'],
                        item['icon'],
                        item['color'],
                      ),
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
          // Add a subtle indicator that the card is clickable
          const Icon(
            Icons.arrow_forward_ios,
            color: Colors.white70,
            size: 16,
          ),
        ],
      ),
    );
  }
}

// Detail Page for each storage type
class StorageDetailPage extends StatelessWidget {
  final Map<String, dynamic> storageData;

  const StorageDetailPage({Key? key, required this.storageData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with back button and title
              Container(
                padding: const EdgeInsets.all(16),
                color: storageData['color'],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () => Navigator.pop(context),
                        ),
                        Expanded(
                          child: Text(
                            storageData['title'],
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(width: 48), // Balance for back button
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Icon(
                          storageData['icon'],
                          size: 60,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            storageData['description'],
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Main content
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Detailed description
                    const Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF023E8A),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      storageData['detailDescription'],
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Estimated cost
                    const Text(
                      'Estimated Cost',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF023E8A),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.blue.shade200),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.attach_money, color: Color(0xFF023E8A)),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              storageData['estimatedCost'],
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF023E8A),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Images
                    const Text(
                      'Images',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF023E8A),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: (storageData['images'] as List).length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(right: 12),
                            width: 250,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              // In a real app, you would use Image.network here
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.image, size: 48, color: Colors.grey.shade400),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Image ${index + 1}',
                                    style: TextStyle(color: Colors.grey.shade600),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Pros and Cons
                    Row(
                      children: [
                        Expanded(
                          child: _buildProsCons(
                            'Pros',
                            storageData['pros'] as List,
                            Colors.green.shade50,
                            Colors.green,
                            Icons.thumb_up,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildProsCons(
                            'Cons',
                            storageData['cons'] as List,
                            Colors.red.shade50,
                            Colors.red,
                            Icons.thumb_down,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProsCons(String title, List items, Color bgColor, Color textColor, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: textColor, size: 18),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...items.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.circle, size: 8, color: textColor),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        item,
                        style: TextStyle(color: Colors.grey.shade800),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}