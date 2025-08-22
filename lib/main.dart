import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CourseDashboardHome(),
    );
  }
}

class CourseDashboardHome extends StatefulWidget {
  @override
  _CourseDashboardHomeState createState() => _CourseDashboardHomeState();
}
~~
class _CourseDashboardHomeState extends State<CourseDashboardHome> {
  int _selectedIndex = 0;
  String selectedCategory = "None";

  final List<Map<String, String>> courses = [
    {"name": "Mobile App Dev", "instructor": "Dr. Smith", "icon": "📱"},
    {"name": "Data Structures", "instructor": "Prof. James", "icon": "💻"},
    {"name": "Networking", "instructor": "Mr. Adams", "icon": "🌐"},
    {"name": "Database Systems", "instructor": "Dr. Brown", "icon": "🗄️"},
    {"name": "Web Development", "instructor": "Ms. Clark", "icon": "🌍"},
  ];

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Course Dashboard")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // (a) Course List View
            Expanded(
              child: ListView.builder(
                itemCount: courses.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Text(courses[index]["icon"]!, style: TextStyle(fontSize: 24)),
                    title: Text(courses[index]["name"]!),
                    subtitle: Text("Instructor: ${courses[index]["instructor"]}"),
                  );
                },
              ),
            ),

            // (d) Animated Action Button
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              height: 50,
              width: _selectedIndex == 1 ? 200 : 150,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _selectedIndex = 1;
                  });
                },
                child: Text("Enroll in Course"),
              ),
            ),
            SizedBox(height: 20),

            // (e) Course Selection Dropdown
            DropdownButton<String>(
              value: selectedCategory == "None" ? null : selectedCategory,
              hint: Text("Select Category"),
              items: ["Science", "Arts", "Technology"]
                  .map((category) => DropdownMenuItem(
                value: category,
                child: Text(category),
              ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedCategory = value!;
                });
              },
            ),
            Text("Selected Category: $selectedCategory"),
          ],
        ),
      ),

      // (b) Bottom Navigation Tabs
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onTabSelected,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: "Courses"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),

      // (c) Exit Confirmation Dialog
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("Logout"),
              content: Text("Are you sure you want to exit the app?"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("No"),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Yes"),
                ),
              ],
            ),
          );
        },
        child: Icon(Icons.logout),
      ),
    );
  }
}
