import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habittrackerapp/common/Constant.dart';
import 'package:habittrackerapp/feature/auth/screens/LoginScreen.dart';
import 'package:habittrackerapp/feature/services/chartsbuilder.dart';
import 'package:habittrackerapp/theme/Colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:table_calendar/table_calendar.dart';

class HabitsScreen extends StatefulWidget {
  const HabitsScreen({Key? key}) : super(key: key);

  @override
  State<HabitsScreen> createState() => _HabitsScreenState();
}

class _HabitsScreenState extends State<HabitsScreen> {
  User? currentUser; // Holds the authenticated user
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  DateTime _focusedDay = DateTime.now();
  DateTime?_selectedDay;
  
  @override
  void initState() {
    super.initState();
    _checkAuthentication(); // Check if the user is authenticated
  }

  // Check if the user is authenticated
  void _checkAuthentication() {
    currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Loginscreen()), // Redirect to LoginScreen if not authenticated
      );
    } else {
      setState(() {}); // Update the state to show the user's habits if authenticated
    }
  }

  // Fetch habits for the logged-in user
  Stream<QuerySnapshot> _getHabitsStream() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid) // Get habits for the current authenticated user
        .collection('habits')
        .snapshots();
  }

  // Function to add or update a habit
  void _saveHabit({String? habitId}) async {
    String title = titleController.text.trim();
    String description = descriptionController.text.trim();

    if (title.isEmpty || description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Title and description cannot be empty")),
      );
      return;
    }

    final habitData = {
      'title': title,
      'description': description,
      'createdAt': FieldValue.serverTimestamp(),
      'dueDate':_selectedDay??_focusedDay
    };

    if (habitId == null) {
      // Add new habit
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser!.uid)
          .collection('habits')
          .add(habitData);
    } else {
      // Update existing habit
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser!.uid)
          .collection('habits')
          .doc(habitId)
          .update(habitData);
    }

    titleController.clear();
    descriptionController.clear();
    Navigator.pop(context); // Close the dialog
  }

  // Function to delete a habit
  void _deleteHabit(String habitId) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .collection('habits')
        .doc(habitId)
        .delete();
  }

  // Function to show Add/Edit Habit Dialog
  void _showHabitDialog({String? habitId, String? initialTitle, String? initialDescription}) {
    titleController.text = initialTitle ?? '';
    descriptionController.text = initialDescription ?? '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(habitId == null ? 'Add Habit' : 'Update Habit'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: "Habit Title"),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: "Habit Description"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                _saveHabit(habitId: habitId); // Save or update habit
              },
              child: Text(habitId == null ? "Add" : "Update"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
     final theme = Theme.of(context);
    if (currentUser == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      backgroundColor: theme.appBarTheme.backgroundColor,
      appBar: AppBar(
        title: const Text("Habit Tracker"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _showHabitDialog(); // Show add habit dialog
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header section with the page title and image
            Padding(
              padding: const EdgeInsets.all(20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        AppConstants.habitPage,
                        height: 240.h,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 80, 0, 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Your Habits",
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color:theme.textTheme.bodyLarge?.color,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Use this to be inspired",
                            style: TextStyle(
                              fontSize: 27,
                              fontWeight: FontWeight.w400,
                              color:theme.textTheme.bodyLarge?.color,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Habit List
            Container(
              height: 513,
              child: StreamBuilder<QuerySnapshot>(
                stream: _getHabitsStream(), // Fetch habits from Firestore
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text("No habits found"));
                  }

                  var habits = snapshot.data!.docs;

                  return ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: habits.length,
                    itemBuilder: (context, index) {
                      var habit = habits[index];

                      return Card(
                        child: ListTile(
                          title: Text(habit['title']),
                          subtitle: Text(habit['description']),
                          onTap: () {
                            // Show update habit dialog
                            _showHabitDialog(
                              habitId: habit.id,
                              initialTitle: habit['title'],
                              initialDescription: habit['description'],
                            );
                          },
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              _deleteHabit(habit.id); // Function to delete the habit
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              
            ),
             TableCalendar(
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay; // update `_focusedDay` here as well
                });
              },
              calendarStyle: const CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            // Line Charts for habit progress visualization
            const SizedBox(height: 10),
            SizedBox(
              height: 200,
              child: LineChartSample1(),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 200,
              child: LineChartSample2(),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 200,
              child: LineChartSample3(),
            ),
          ],
        ),
      ),
    );
  }
}