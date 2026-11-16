import 'package:flutter/material.dart';
import 'shrink.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Assignment App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.deepPurple,
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

// -----------------------------------------------------------------------------
// 1. SPLASH SCREEN WITH ANIMATION
// -----------------------------------------------------------------------------
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _scale = 0.5;
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    // Trigger animation frame after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _scale = 1.0;
        _opacity = 1.0;
      });
    });

    // Automatically navigate to Home Screen after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Center(
        child: AnimatedOpacity(
          opacity: _opacity,
          duration: const Duration(seconds: 2),
          child: AnimatedScale(
            scale: _scale,
            duration: const Duration(seconds: 2),
            curve: Curves.easeOutBack,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/pic.png',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.flutter_dash,
                        size: 80,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'My Flutter App',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Riphah International University',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// SHARED NAVIGATION DRAWER
// -----------------------------------------------------------------------------
class AppDrawer extends StatelessWidget {
  final int currentScreenIndex;

  const AppDrawer({super.key, required this.currentScreenIndex});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.deepPurple,
            ),
            currentAccountPicture: CircleAvatar(
              radius: 36,
              backgroundColor: Colors.white,
              child: ClipOval(
                child: Image.asset(
                  'assets/pic.png',
                  width: 72,
                  height: 72,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.person, size: 40, color: Colors.deepPurple),
                ),
              ),
            ),
            accountName: const Text(
              'Muhammad Hammad Qayyum',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            accountEmail: const Text(
              'BS Software Engineering Student',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white70,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home Screen'),
            selected: currentScreenIndex == 0,
            onTap: () {
              Navigator.pop(context);
              if (currentScreenIndex != 0) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.format_list_bulleted),
            title: const Text('List Screen'),
            selected: currentScreenIndex == 1,
            onTap: () {
              Navigator.pop(context);
              if (currentScreenIndex != 1) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const ListScreen()),
                );
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About Screen'),
            selected: currentScreenIndex == 2,
            onTap: () {
              Navigator.pop(context);
              if (currentScreenIndex != 2) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutScreen()),
                );
              }
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Settings'),
                  content: const Text('Flutter Assignment v1.0\nRiphah International University'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 2. HOME SCREEN (Includes Bonus CustomScrollView + SliverAppBar)
// -----------------------------------------------------------------------------
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _bottomNavIndex = 0;

  void _onBottomNavTapped(int index) {
    if (index == _bottomNavIndex) return;
    setState(() => _bottomNavIndex = index);
    if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ListScreen()),
      );
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AboutScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6E6E6E),
      drawer: const AppDrawer(currentScreenIndex: 0),
      body: CustomScrollView(
        slivers: [
          // BONUS: CustomScrollView + SliverAppBar
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Home Screen'),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.deepPurple, Colors.teal],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.dashboard_customize, size: 60, color: Colors.white70),
                      SizedBox(height: 8),
                      Text(
                        'Riphah International University',
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Welcome, Muhammad Hammad Qayyum!',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Explore the List Screen for scrollable lists and the About Screen for grid gallery views.',
                    style: TextStyle(fontSize: 14, color: Colors.white70),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: Shrink(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const ListScreen()),
                            );
                          },
                          child: Card(
                            color: Colors.deepPurple.shade700,
                            child: const Padding(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  Icon(Icons.format_list_bulleted, size: 40, color: Colors.white),
                                  SizedBox(height: 12),
                                  Text(
                                    'View 10 Cities List',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Shrink(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const AboutScreen()),
                            );
                          },
                          child: Card(
                            color: Colors.teal.shade700,
                            child: const Padding(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  Icon(Icons.grid_view, size: 40, color: Colors.white),
                                  SizedBox(height: 12),
                                  Text(
                                    'View 6 Grid Items',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomNavIndex,
        backgroundColor: const Color(0xFF5E5E5E),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white60,
        onTap: _onBottomNavTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.format_list_bulleted),
            label: 'List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'About',
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 3. LIST SCREEN (Scrollable ListView showing 10 items)
// -----------------------------------------------------------------------------
class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final List<Map<String, String>> cityItems = const [
    {'name': 'Islamabad', 'country': 'Pakistan', 'desc': 'Capital city known for greenery and Faisal Mosque.'},
    {'name': 'Lahore', 'country': 'Pakistan', 'desc': 'Cultural hub famous for food and Badshahi Mosque.'},
    {'name': 'Karachi', 'country': 'Pakistan', 'desc': 'City of Lights and major financial center.'},
    {'name': 'Peshawar', 'country': 'Pakistan', 'desc': 'Historic city famous for Qissa Khwani Bazaar.'},
    {'name': 'Quetta', 'country': 'Pakistan', 'desc': 'Fruit garden of Pakistan surrounded by mountains.'},
    {'name': 'Tokyo', 'country': 'Japan', 'desc': 'Bustling metropolis blending ultramodern and tradition.'},
    {'name': 'Paris', 'country': 'France', 'desc': 'City of light, art, fashion and Eiffel Tower.'},
    {'name': 'London', 'country': 'United Kingdom', 'desc': 'Global capital rich in history and landmarks.'},
    {'name': 'New York', 'country': 'United States', 'desc': 'The Big Apple with iconic skyline and Broadway.'},
    {'name': 'Istanbul', 'country': 'Turkey', 'desc': 'Historic bridge bridging Europe and Asia.'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6E6E6E),
      appBar: AppBar(
        title: const Text('List Screen (10 Items)'),
        backgroundColor: const Color(0xFF5E5E5E),
        foregroundColor: Colors.white,
      ),
      drawer: const AppDrawer(currentScreenIndex: 1),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: cityItems.length,
        itemBuilder: (context, index) {
          final item = cityItems[index];
          return Shrink(
            child: Card(
              color: const Color(0xFF535353),
              margin: const EdgeInsets.symmetric(vertical: 6),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.deepPurple,
                  child: Text(
                    '${index + 1}',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                title: Text(
                  item['name']!,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  '${item['country']} - ${item['desc']}',
                  style: const TextStyle(color: Colors.white70),
                ),
                trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white54, size: 16),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text(item['name']!),
                      content: Text('${item['country']}\n\n${item['desc']}'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(ctx),
                          child: const Text('Close'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        backgroundColor: const Color(0xFF5E5E5E),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white60,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          } else if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const AboutScreen()),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.format_list_bulleted),
            label: 'List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'About',
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 4. ABOUT SCREEN (GridView showing 6 items with Captions & Hero Detail)
// -----------------------------------------------------------------------------
class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  final List<Map<String, String>> gridItems = const [
    {'title': 'Eiffel Tower', 'image': 'assets/pic.png', 'caption': 'Paris, France'},
    {'title': 'Riphah Campus', 'image': 'assets/Screenshot 2026-11-02 111130.png', 'caption': 'Islamabad, PK'},
    {'title': 'Hammad Profile', 'image': 'assets/profile.png', 'caption': 'Software Engineer'},
    {'title': 'Paris Night', 'image': 'assets/Screenshot 2026-11-02 110112.png', 'caption': 'Landmarks'},
    {'title': 'Eiffel View', 'image': 'assets/pic.png', 'caption': 'Architecture'},
    {'title': 'Student Profile', 'image': 'assets/profile.png', 'caption': 'Riphah Student'},
  ];

  Widget _buildGridImage(String path) {
    return Image.asset(
      path,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => Container(
        color: Colors.deepPurple.shade200,
        child: const Icon(Icons.image, size: 48, color: Colors.deepPurple),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6E6E6E),
      appBar: AppBar(
        title: const Text('About Screen (6 Grid Items)'),
        backgroundColor: const Color(0xFF5E5E5E),
        foregroundColor: Colors.white,
      ),
      drawer: const AppDrawer(currentScreenIndex: 2),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                color: const Color(0xFF535353),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 36,
                        backgroundColor: Colors.deepPurple,
                        child: Icon(Icons.school, size: 40, color: Colors.white),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Muhammad Hammad Qayyum',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'BS Software Engineering',
                              style: TextStyle(color: Colors.white70),
                            ),
                            Text(
                              'Riphah International University',
                              style: TextStyle(color: Colors.white54, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                '6 Grid Showcase Items:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: gridItems.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.85,
                ),
                itemBuilder: (context, index) {
                  final item = gridItems[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GridDetailPage(
                            title: item['title']!,
                            imagePath: item['image']!,
                            caption: item['caption']!,
                            tag: 'about-grid-$index',
                          ),
                        ),
                      );
                    },
                    child: Shrink(
                      child: Card(
                        color: const Color(0xFF535353),
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: Hero(
                                tag: 'about-grid-$index',
                                child: _buildGridImage(item['image']!),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['title']!,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    item['caption']!,
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 12,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        backgroundColor: const Color(0xFF5E5E5E),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white60,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          } else if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const ListScreen()),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.format_list_bulleted),
            label: 'List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'About',
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// DETAIL PAGE FOR GRID ITEMS
// -----------------------------------------------------------------------------
class GridDetailPage extends StatelessWidget {
  final String title;
  final String imagePath;
  final String caption;
  final String tag;

  const GridDetailPage({
    super.key,
    required this.title,
    required this.imagePath,
    required this.caption,
    required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Hero(
                tag: tag,
                child: InteractiveViewer(
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.black,
                      child: const Icon(Icons.image, size: 100, color: Colors.white54),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(
              caption,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
