import 'package:flutter/material.dart';

class WaterUsagePage extends StatefulWidget {
  const WaterUsagePage({Key? key}) : super(key: key);

  @override
  State<WaterUsagePage> createState() => _WaterUsagePageState();
}

class _WaterUsagePageState extends State<WaterUsagePage> {
  String selectedUsageType = "Residential"; // Default selection
  double dailyUsage = 0.0;
  double yearlyUsage = 0.0;

  final Map<String, double> usageRates = {
    "Residential": 135, // Liters per person per day (average)
    "Agricultural": 5000, // Liters per hectare per day (approx)
    "Industrial": 10000, // Liters per industrial unit per day
  };

  void _calculateYearlyUsage() {
    setState(() {
      dailyUsage = usageRates[selectedUsageType]!;
      yearlyUsage = dailyUsage * 365; // Approximate yearly usage
    });
  }

  @override
  void initState() {
    super.initState();
    _calculateYearlyUsage(); // Initial calculation
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                        'WATER USAGE',
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

              // Dropdown for Selecting Usage Type
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.blue, width: 1),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedUsageType,
                    isExpanded: true,
                    onChanged: (value) {
                      setState(() {
                        selectedUsageType = value!;
                        _calculateYearlyUsage();
                      });
                    },
                    items: usageRates.keys.map((type) {
                      return DropdownMenuItem(
                        value: type,
                        child: Text(
                          type,
                          style: const TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Usage Info Cards
              _buildUsageInfoCard('Daily Water Usage', '${dailyUsage.toStringAsFixed(0)} liters'),
              _buildUsageInfoCard('Yearly Water Usage', '${yearlyUsage.toStringAsFixed(0)} liters'),

              const SizedBox(height: 20),

              // Suggested Water Conservation Tips
              _buildTipsCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUsageInfoCard(String title, String value) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF023E8A),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTipsCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.blue, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Water Conservation Tips",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const SizedBox(height: 8),
          Text(
            "• Use water-efficient appliances\n"
            "• Fix leaks and dripping faucets\n"
            "• Implement rainwater harvesting\n"
            "• Water plants during cooler hours\n"
            "• Reuse greywater when possible",
            style: const TextStyle(fontSize: 14, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
