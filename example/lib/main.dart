import 'package:flutter/material.dart';
import 'package:responsive_display/responsiveDisplay.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ResponsiveDisplay Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      // Optional: Wrap with ResponsiveConfig to override breakpoints
      builder: (context, child) => ResponsiveConfig(
        child: child!,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _navIndex = 0;

  @override
  Widget build(BuildContext context) {
    // 9. Responsive Scaffold Example
    return ResponsiveScaffold(
      title: const Text('Responsive Display'),
      currentIndex: _navIndex,
      onNavigationIndexChange: (index) => setState(() => _navIndex = index),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Builder'),
        BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: 'Grid'),
        BottomNavigationBarItem(icon: Icon(Icons.text_fields), label: 'Scaling'),
      ],
      body: _getBody(_navIndex),
    );
  }

  Widget _getBody(int index) {
    switch (index) {
      case 0:
        return const BuilderExample();
      case 1:
        return const GridExample();
      case 2:
        return const ScalingExample();
      default:
        return const Center(child: Text('Unknown'));
    }
  }
}

class BuilderExample extends StatelessWidget {
  const BuilderExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Current Device: ${responsiveDisplay.deviceType(context)}'),
          const SizedBox(height: 20),
          const Text('Resize the window to see changes:'),
          const SizedBox(height: 10),
          Expanded(
            // 3. Responsive Builder Example
            child: ResponsiveBuilder(
              xsmall: _buildBox(Colors.red, 'Mobile Portrait (xsmall)'),
              small: _buildBox(Colors.orange, 'Mobile Landscape / Large Phone (small)'),
              medium: _buildBox(Colors.yellow, 'Tablet (medium)'),
              large: _buildBox(Colors.green, 'Desktop / Laptop (large)'),
              xlarge: _buildBox(Colors.blue, 'Large Desktop (xlarge)'),
              fallback: (type) => _buildBox(Colors.grey, 'Fallback for $type'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBox(Color color, String label) {
    return Container(
      color: color,
      alignment: Alignment.center,
      child: Text(
        label,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class GridExample extends StatelessWidget {
  const GridExample({super.key});

  @override
  Widget build(BuildContext context) {
    // 6. Responsive Grid Example
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
             padding: const EdgeInsets.all(8.0),
             child: Text('Grid Columns: ${responsiveDisplay.gridColumns(context)}'),
          ),
          Expanded(
            child: ResponsiveGrid(
              children: List.generate(20, (index) {
                return Card(
                  color: Colors.teal[(index % 9 + 1) * 100],
                  child: Center(child: Text('Item $index')),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class ScalingExample extends StatelessWidget {
  const ScalingExample({super.key});

  @override
  Widget build(BuildContext context) {
    // 4. & 5. Responsive Value and Proportional Scaling Example
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Using ResponsiveValue logic
          Text(
            'This text changes specific size at breakpoints',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: ResponsiveValue<double>(
                context,
                xsmall: 12,
                small: 14,
                medium: 18,
                large: 24,
                xlarge: 32,
              ).value,
            ),
          ),
          const SizedBox(height: 20),
          // Using Proportional Scaling
          Text(
            'This text scales proportionally',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: responsiveDisplay.scaleFont(context, 20),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: responsiveDisplay.scaleSpacing(context, 100),
            height: responsiveDisplay.scaleSpacing(context, 100),
            color: Colors.purple,
            alignment: Alignment.center,
            child: const Text('Scaled Box', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
