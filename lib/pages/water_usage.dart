import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class WaterUsagePage extends StatefulWidget {
  const WaterUsagePage({Key? key}) : super(key: key);

  @override
  State<WaterUsagePage> createState() => _WaterUsagePageState();
}

class _WaterUsagePageState extends State<WaterUsagePage> with SingleTickerProviderStateMixin {
  String selectedUsageType = "Residential"; // Default selection
  double dailyUsage = 0.0;
  double yearlyUsage = 0.0;
  double monthlyCost = 0.0;
  double yearlyCost = 0.0;
  double customQuantity = 1.0; // Default quantity (people, hectares, units)
  bool showCustomFields = false;
  
  // For comparison with average
  double averageDailyUsage = 0.0;
  double averageYearlyUsage = 0.0;
  
  // For tracking usage over time
  List<WaterUsageRecord> usageHistory = [];
  final TextEditingController _manualUsageController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  
  // For tab view
  late TabController _tabController;

  // Water prices per 1000 liters (may vary by region)
  final Map<String, double> waterPrices = {
    "Residential": 2.5, // $2.50 per 1000 liters
    "Agricultural": 1.2, // $1.20 per 1000 liters
    "Industrial": 3.0, // $3.00 per 1000 liters
  };

  final Map<String, double> usageRates = {
    "Residential": 135, // Liters per person per day (average)
    "Agricultural": 5000, // Liters per hectare per day (approx)
    "Industrial": 10000, // Liters per industrial unit per day
  };
  
  // Water conservation goal
  double waterSavingGoal = 10.0; // Default 10% reduction goal
  double projectedSavings = 0.0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _calculateYearlyUsage(); // Initial calculation
    
    // Initialize with some sample data for the past week
    final now = DateTime.now();
    for (int i = 6; i >= 0; i--) {
      final date = now.subtract(Duration(days: i));
      // Random fluctuation around the daily average for demo purposes
      final usage = dailyUsage * (0.9 + (0.2 * i / 7));
      usageHistory.add(WaterUsageRecord(date: date, usage: usage));
    }
    
    _calculateAverages();
    _calculateProjectedSavings();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _manualUsageController.dispose();
    super.dispose();
  }

  void _calculateYearlyUsage() {
    setState(() {
      dailyUsage = usageRates[selectedUsageType]! * customQuantity;
      yearlyUsage = dailyUsage * 365; // Approximate yearly usage
      monthlyCost = (dailyUsage * 30 / 1000) * waterPrices[selectedUsageType]!;
      yearlyCost = monthlyCost * 12;
      _calculateProjectedSavings();
    });
  }
  
  void _calculateAverages() {
    if (usageHistory.isEmpty) return;
    
    double totalUsage = 0;
    for (var record in usageHistory) {
      totalUsage += record.usage;
    }
    
    setState(() {
      averageDailyUsage = totalUsage / usageHistory.length;
      averageYearlyUsage = averageDailyUsage * 365;
    });
  }
  
  void _calculateProjectedSavings() {
    setState(() {
      projectedSavings = yearlyUsage * (waterSavingGoal / 100);
    });
  }
  
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
  
  void _addManualUsageEntry() {
    if (_manualUsageController.text.isEmpty) return;
    
    final usage = double.tryParse(_manualUsageController.text) ?? 0.0;
    if (usage > 0) {
      setState(() {
        usageHistory.add(WaterUsageRecord(date: selectedDate, usage: usage));
        usageHistory.sort((a, b) => a.date.compareTo(b.date));
        _manualUsageController.clear();
        _calculateAverages();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Back Button & Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    color: Color(0xFF023E8A),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'WATER USAGE TRACKER',
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
            ),
            
            // Tab Bar
            TabBar(
              controller: _tabController,
              labelColor: Color(0xFF023E8A),
              unselectedLabelColor: Colors.grey,
              tabs: const [
                Tab(text: 'Overview', icon: Icon(Icons.water_drop)),
                Tab(text: 'Tracking', icon: Icon(Icons.timeline)),
                Tab(text: 'Savings', icon: Icon(Icons.savings)),
              ],
            ),
            
            // Tab Content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildOverviewTab(),
                  _buildTrackingTab(),
                  _buildSavingsTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  // OVERVIEW TAB
  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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

          const SizedBox(height: 16),
          
          // Custom quantity input
          Row(
            children: [
              Expanded(
                child: Text(
                  "Number of ${_getQuantityLabel()}:",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                width: 100,
                child: TextFormField(
                  initialValue: customQuantity.toString(),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  onChanged: (value) {
                    final quantity = double.tryParse(value) ?? 1.0;
                    if (quantity > 0) {
                      setState(() {
                        customQuantity = quantity;
                        _calculateYearlyUsage();
                      });
                    }
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Usage Info Cards
          _buildUsageInfoCard('Daily Water Usage', '${dailyUsage.toStringAsFixed(0)} liters'),
          _buildUsageInfoCard('Yearly Water Usage', '${yearlyUsage.toStringAsFixed(0)} liters'),
          _buildUsageInfoCard('Monthly Cost', '\$${monthlyCost.toStringAsFixed(2)}'),
          _buildUsageInfoCard('Yearly Cost', '\$${yearlyCost.toStringAsFixed(2)}'),

          const SizedBox(height: 20),

          // Suggested Water Conservation Tips
          _buildTipsCard(),
        ],
      ),
    );
  }
  
  // TRACKING TAB
  Widget _buildTrackingTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Chart showing usage over time
          Container(
            height: 250,
            padding: const EdgeInsets.all(16),
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
            child: usageHistory.isEmpty
                ? const Center(child: Text("No data available"))
                : _buildUsageChart(),
          ),
          
          const SizedBox(height: 20),
          
          // Form to add manual usage entry
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.blue, width: 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Add Manual Usage Entry",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _selectDate(context),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Text(
                            DateFormat('yyyy-MM-dd').format(selectedDate),
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextFormField(
                        controller: _manualUsageController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Liters",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF023E8A),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: _addManualUsageEntry,
                    child: const Text("Add Entry"),
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Usage history list
          Container(
            padding: const EdgeInsets.all(16),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Usage History",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                usageHistory.isEmpty
                    ? const Center(child: Text("No usage records yet"))
                    : Column(
                        children: usageHistory.map((record) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  DateFormat('MM/dd/yyyy').format(record.date),
                                  style: const TextStyle(fontSize: 14),
                                ),
                                Text(
                                  "${record.usage.toStringAsFixed(0)} liters",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF023E8A),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  // SAVINGS TAB
  Widget _buildSavingsTab() {
    final currencyFormat = NumberFormat.currency(symbol: '\$', decimalDigits: 2);
    final literFormat = NumberFormat.decimalPattern();
    
    // Calculate savings stats
    final yearlyLitersSaved = projectedSavings;
    final yearlyCostSaved = (yearlyLitersSaved / 1000) * waterPrices[selectedUsageType]!;
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Savings goal slider
          Container(
            padding: const EdgeInsets.all(16),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Set Water Saving Goal",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "Reduction target: ${waterSavingGoal.toStringAsFixed(0)}%",
                  style: const TextStyle(fontSize: 14),
                ),
                Slider(
                  value: waterSavingGoal,
                  min: 5,
                  max: 50,
                  divisions: 9,
                  activeColor: Color(0xFF023E8A),
                  inactiveColor: Colors.blue.shade200,
                  label: waterSavingGoal.toStringAsFixed(0),
                  onChanged: (value) {
                    setState(() {
                      waterSavingGoal = value;
                      _calculateProjectedSavings();
                    });
                  },
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Projected savings
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.green, width: 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Projected Annual Savings",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 16),
                _buildSavingsRow(
                  "Water Saved:",
                  "${literFormat.format(yearlyLitersSaved.round())} liters",
                ),
                const SizedBox(height: 8),
                _buildSavingsRow(
                  "Money Saved:",
                  currencyFormat.format(yearlyCostSaved),
                ),
                const SizedBox(height: 8),
                _buildSavingsRow(
                  "CO₂ Reduction:",
                  "${(yearlyLitersSaved * 0.0003).toStringAsFixed(2)} kg",
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Savings tips specific to the category
          Container(
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
                  "How to Achieve Your Goal",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  _getSavingTipsForType(),
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Take Action button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.eco),
              label: const Text("Take Action Now"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                // Show dialog with immediate actions
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Take Action"),
                    content: const Text(
                      "Here are some immediate actions you can take:\n\n"
                      "1. Conduct a water audit to find leaks\n"
                      "2. Install water-efficient fixtures\n"
                      "3. Set up a monitoring schedule\n"
                      "4. Share your savings goal with others\n"
                      "5. Create water usage alerts",
                    ),
                    actions: [
                      TextButton(
                        child: const Text("Close"),
                        onPressed: () => Navigator.pop(context),
                      ),
                      TextButton(
                        child: const Text("Learn More"),
                        onPressed: () {
                          Navigator.pop(context);
                          // This would navigate to a detailed guide
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
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
            _getConservationTipsForType(),
            style: const TextStyle(fontSize: 14, color: Colors.black),
          ),
        ],
      ),
    );
  }
  
  Widget _buildUsageChart() {
    // Convert data for the chart
    final data = usageHistory.map((record) {
      return WaterUsageData(
        date: DateFormat('MM/dd').format(record.date),
        usage: record.usage,
      );
    }).toList();
    
    final series = [
      charts.Series<WaterUsageData, String>(
        id: 'WaterUsage',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (WaterUsageData data, _) => data.date,
        measureFn: (WaterUsageData data, _) => data.usage,
        data: data,
      )
    ];
    
    return charts.BarChart(
      series,
      animate: true,
      vertical: true,
      domainAxis: const charts.OrdinalAxisSpec(
        renderSpec: charts.SmallTickRendererSpec(
          labelRotation: 45,
          labelStyle: charts.TextStyleSpec(
            fontSize: 10,
          ),
        ),
      ),
      primaryMeasureAxis: const charts.NumericAxisSpec(
        tickProviderSpec: charts.BasicNumericTickProviderSpec(
          desiredTickCount: 5,
        ),
        renderSpec: charts.GridlineRendererSpec(
          labelStyle: charts.TextStyleSpec(
            fontSize: 12,
          ),
        ),
      ),
    );
  }
  
  Widget _buildSavingsRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
      ],
    );
  }
  
  String _getQuantityLabel() {
    switch (selectedUsageType) {
      case "Residential":
        return "Persons";
      case "Agricultural":
        return "Hectares";
      case "Industrial":
        return "Units";
      default:
        return "Units";
    }
  }
  
  String _getConservationTipsForType() {
    switch (selectedUsageType) {
      case "Residential":
        return "• Install low-flow faucets and showerheads\n"
               "• Fix leaks and dripping faucets promptly\n"
               "• Take shorter showers (under 5 minutes)\n"
               "• Only run full loads in washing machines\n"
               "• Use water-efficient toilets\n"
               "• Collect and reuse rainwater for plants";
      case "Agricultural":
        return "• Implement drip irrigation systems\n"
               "• Schedule irrigation based on weather\n"
               "• Use soil moisture sensors\n"
               "• Employ rainwater harvesting\n"
               "• Consider drought-resistant crops\n"
               "• Maintain irrigation systems regularly";
      case "Industrial":
        return "• Conduct regular water audits\n"
               "• Recycle process water when possible\n"
               "• Upgrade to water-efficient equipment\n"
               "• Implement closed-loop cooling systems\n"
               "• Train staff on water conservation\n"
               "• Install water meters to track usage";
      default:
        return "• Use water-efficient appliances\n"
               "• Fix leaks and dripping faucets\n"
               "• Implement rainwater harvesting\n"
               "• Water plants during cooler hours\n"
               "• Reuse greywater when possible";
    }
  }
  
  String _getSavingTipsForType() {
    switch (selectedUsageType) {
      case "Residential":
        return "• Replace old fixtures with WaterSense labeled products\n"
               "• Install aerators on all faucets (save up to 700 liters/month)\n"
               "• Reduce shower time by 2 minutes (save ~150 liters/day)\n"
               "• Fix leaking toilets (save up to 750 liters/day)\n"
               "• Use dishwashers instead of handwashing (save ~100 liters/load)";
      case "Agricultural":
        return "• Switch to drip irrigation (save up to 60% water)\n"
               "• Implement precision irrigation scheduling (save 15-30%)\n"
               "• Install soil moisture sensors (save up to 25%)\n"
               "• Use mulch to reduce evaporation (save 10-15%)\n"
               "• Plant cover crops to improve soil water retention";
      case "Industrial":
        return "• Retrofit cooling towers (save up to 40% of cooling water)\n"
               "• Implement water recycling systems (save 30-90%)\n"
               "• Install flow restrictors on all equipment (save 15-50%)\n"
               "• Optimize cleaning processes (save 20-40%)\n"
               "• Harvest rainwater for non-process uses";
      default:
        return "• Conduct a comprehensive water audit\n"
               "• Focus on high-use areas first\n"
               "• Set measurable targets for reduction\n"
               "• Implement regular monitoring\n"
               "• Consider water-efficient technology investments";
    }
  }
}

// Data classes
class WaterUsageRecord {
  final DateTime date;
  final double usage;
  
  WaterUsageRecord({required this.date, required this.usage});
}

class WaterUsageData {
  final String date;
  final double usage;
  
  WaterUsageData({required this.date, required this.usage});
}