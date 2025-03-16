import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ROICalculatorPage extends StatefulWidget {
  const ROICalculatorPage({Key? key}) : super(key: key);

  @override
  State<ROICalculatorPage> createState() => _ROICalculatorPageState();
}

class _ROICalculatorPageState extends State<ROICalculatorPage> {
  final _heightController = TextEditingController();
  final _widthController = TextEditingController();
  final _storageTypeController = TextEditingController();

  // Fixed values
  final double initialInvestment = 800000;
  final int estimatedLifespan = 25;
  final int paybackPeriod = 7;

  // Dynamic values
  int annualWaterSavings = 3000;
  int roi = 150;

  @override
  void dispose() {
    _heightController.dispose();
    _widthController.dispose();
    _storageTypeController.dispose();
    super.dispose();
  }

  void _calculateROI() {
    double height = double.tryParse(_heightController.text) ?? 0;
    double width = double.tryParse(_widthController.text) ?? 0;

    if (height > 0 && width > 0) {
      setState(() {
        double area = height * width;
        annualWaterSavings = (area * 10).toInt();
        roi = (annualWaterSavings * estimatedLifespan) ~/ initialInvestment * 100;
      });
    } else {
      // Show error message if inputs are invalid
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter valid height and width values."),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Color(0xFF023E8A)),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Expanded(
                      child: Center(
                        child: Text(
                          'ROI CALCULATOR',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF023E8A),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Type of Storage Input
                const Text(
                  'Type Of Storage',
                  style: TextStyle(
                    color: Color(0xFF023E8A),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _storageTypeController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.blue.shade50,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue.shade200),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Area Section
                const Text(
                  'AREA',
                  style: TextStyle(
                    color: Color(0xFF023E8A),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),

                // Height and Width Inputs
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Height (m)', style: TextStyle(color: Color(0xFF023E8A))),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: _heightController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.blue.shade50,
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue.shade200),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Width (m)', style: TextStyle(color: Color(0xFF023E8A))),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: _widthController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.blue.shade50,
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue.shade200),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Calculate Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _calculateROI,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade700,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Calculate',
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Results Card
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _buildResultRow('Initial Investment', '${initialInvestment.toStringAsFixed(0)}\$'),
                      _buildResultRow('Annual Water Savings', '$annualWaterSavings Ltr.'),
                      _buildResultRow('Estimated Lifespan', '$estimatedLifespan Years'),
                      _buildResultRow('Payback Period', '$paybackPeriod Years'),
                      _buildResultRow('ROI', '$roi%'),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Explore Subsidies Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Add navigation to subsidies page
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade600,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Explore Subsidies',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResultRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Color(0xFF023E8A), fontWeight: FontWeight.w500)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
