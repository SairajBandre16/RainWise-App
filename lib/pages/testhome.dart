import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EnhancedHomePage extends StatefulWidget {
  const EnhancedHomePage({Key? key}) : super(key: key);

  @override
  State<EnhancedHomePage> createState() => _EnhancedHomePageState();
}

class _EnhancedHomePageState extends State<EnhancedHomePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _showWeatherInfo = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      endDrawer: _buildDrawer(),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  if (_showWeatherInfo) _buildWeatherInfo(),
                  const SizedBox(height: 60),
                  _buildMainGrid(),
                  const SizedBox(height: 20),
                  _buildQuickStats(),
                  const SizedBox(height: 20),
                  _buildInsightsCard(),
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      '"Harvest water today, sustain life tomorrow."',
                      style: TextStyle(
                        color: Colors.blue.shade800,
                        fontStyle: FontStyle.italic,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: _buildFloatingButtons(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'RainWise',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E3A8A),
                letterSpacing: 1.2,
                shadows: [
                    Shadow(
                      blurRadius: 2.0,
                      color: Colors.grey,
                      offset: Offset(0, 2),
                    ),
                  ], 
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.notifications_outlined,
                color: Colors.blue.shade800,
                size: 28,
              ),
              onPressed: () {
                // Show notifications
              },
            ),
          ],
        ),
        const Text(
          'Rainwater Harvesting Made Easy',
          style: TextStyle(
            fontSize: 18,
            color: Color(0xFF1E3A8A),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildWeatherInfo() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, -1),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: _controller,
            curve: Curves.easeOutBack,
          )),
          child: Container(
            margin: const EdgeInsets.only(top: 20),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade300, Colors.blue.shade500],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.shade200.withOpacity(0.5),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Icon(Icons.water_drop, color: Colors.white, size: 30),
                    SizedBox(height: 5),
                    Text(
                      '75%\nHumidity',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.cloud, color: Colors.white, size: 30),
                    SizedBox(height: 5),
                    Text(
                      '80%\nRain Chance',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.speed, color: Colors.white, size: 30),
                    SizedBox(height: 5),
                    Text(
                      '12 km/h\nWind',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMainGrid() {
    final List<Map<String, dynamic>> items = [
      {
        'icon': Icons.map_outlined,
        'label': 'PLOT AREA',
        'color': Colors.blue.shade300,
      },
      {
        'icon': Icons.storage,
        'label': 'STORAGE TYPES',
        'color': Colors.blue.shade400,
      },
      {
        'icon': Icons.calculate_outlined,
        'label': 'CALC ROI',
        'color': Colors.blue.shade500,
      },
      {
        'icon': Icons.water_drop_outlined,
        'label': 'WATER USAGE',
        'color': Colors.blue.shade600,
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        childAspectRatio: 1.2,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return _buildGridItem(items[index]);
      },
    );
  }

  Widget _buildGridItem(Map<String, dynamic> item) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: item['color'].withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // Navigate to respective screens
          },
          borderRadius: BorderRadius.circular(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                item['icon'],
                size: 40,
                color: item['color'],
              ),
              const SizedBox(height: 10),
              Text(
                item['label'],
                style: TextStyle(
                  color: Colors.blue.shade800,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickStats() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.shade100.withOpacity(0.5),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Stats',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade800,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem('7,647', 'Liters\nSaved', Icons.savings_outlined),
              _buildStatItem('₹5,400', 'Money\nSaved', Icons.currency_rupee),
              _buildStatItem('85%', 'System\nEfficiency', Icons.trending_up),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.blue.shade400, size: 24),
        const SizedBox(height: 5),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade800,
          ),
        ),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            color: Colors.blue.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildInsightsCard() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.shade100.withOpacity(0.5),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Insights',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade800,
            ),
          ),
          const SizedBox(height: 10),
          _buildInsightItem(
            'Best time to harvest: Next 3 days',
            Icons.access_time,
          ),
          _buildInsightItem(
            'Tank maintenance recommended',
            Icons.warning_amber,
          ),
          _buildInsightItem(
            'Water quality: Excellent',
            Icons.check_circle,
          ),
        ],
      ),
    );
  }

  Widget _buildInsightItem(String text, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue.shade400, size: 20),
          const SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(
              color: Colors.blue.shade600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingButtons() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton(
          heroTag: 'weather',
          mini: true,
          backgroundColor: Colors.white,
          onPressed: () {
            setState(() {
              _showWeatherInfo = !_showWeatherInfo;
              if (_showWeatherInfo) {
                _controller.forward(from: 0);
              }
            });
          },
          child: Icon(
            Icons.cloud,
            color: Colors.blue.shade800,
          ),
        ),
        const SizedBox(height: 10),
        FloatingActionButton(
          heroTag: 'support',
          backgroundColor: Colors.blue.shade400,
          onPressed: () {
            _scaffoldKey.currentState?.openEndDrawer();
          },
          child: const Icon(Icons.support_agent),
        ),
      ],
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade300, Colors.blue.shade500],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.support_agent, size: 30, color: Colors.blue),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Support Center',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            _buildDrawerItem('FAQs', Icons.question_answer),
            _buildDrawerItem('Maintenance Guide', Icons.build),
            _buildDrawerItem('Contact Support', Icons.headset_mic),
            _buildDrawerItem('Report Issue', Icons.bug_report),
            _buildDrawerItem('Video Tutorials', Icons.play_circle),
            const Divider(),
            _buildDrawerItem('Help Center', Icons.help),
            _buildDrawerItem('About', Icons.info),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(String title, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue.shade600),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.blue.shade800,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: () {
        // Handle drawer item taps
      },
    );
  }
}