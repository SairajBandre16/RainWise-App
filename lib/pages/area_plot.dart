import 'package:flutter/material.dart';

class RainwaterCalculatorPage extends StatefulWidget {
  const RainwaterCalculatorPage({Key? key}) : super(key: key);

  @override
  State<RainwaterCalculatorPage> createState() => _RainwaterCalculatorPageState();
}

class _RainwaterCalculatorPageState extends State<RainwaterCalculatorPage> {
  double calculatedArea = 0.0;
  double predictedRainfall = 536.45;
  double waterCapacity = 0.0;

  void _calculateWaterCapacity() {
    setState(() {
      waterCapacity = calculatedArea * (predictedRainfall / 1000) * 1000; 
    });
  }

  void _resetValues() {
    setState(() {
      calculatedArea = 0.0;
      waterCapacity = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(  // FIX: Enables scrolling
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Back button and title
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
                          'PLOT AREA',
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

                // Map area
                Container(
                  width: double.infinity,
                  height: 300, // FIX: Reduce height for better fit
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.blue, width: 2),
                  ),
                  child: Center(
                    child: Text(
                      'Map View Placeholder',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Buttons Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildButton('Submit', Colors.blue, _calculateWaterCapacity),
                    _buildButton('Reset', Colors.red, _resetValues),
                  ],
                ),

                const SizedBox(height: 20),

                // Info cards
                _buildInfoCard('Calculated Area', '${calculatedArea.toStringAsFixed(0)} m²'),
                _buildInfoCard('Predicted Rainfall', '${predictedRainfall.toStringAsFixed(2)}mm'),
                _buildInfoCard('Water Capacity', '${waterCapacity.toStringAsFixed(0)} ltr'),

                const SizedBox(height: 16),

                // Suggested Storage Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {}, 
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'View Suggested Storage',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_forward, color: Colors.white),
                      ],
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

  Widget _buildButton(String text, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(text, style: const TextStyle(color: Colors.white)),
    );
  }

   Widget _buildInfoCard(String title, String value) {
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
}

