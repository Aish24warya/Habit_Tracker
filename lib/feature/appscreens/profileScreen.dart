import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:habittrackerapp/common/Constant.dart';
import 'package:habittrackerapp/common/spacing.dart';
import 'package:habittrackerapp/feature/auth/screens/LoginScreen.dart';
import 'package:habittrackerapp/feature/services/lists.dart';
import 'package:habittrackerapp/theme/Colors.dart';

class Profilescreen extends StatefulWidget {
  const Profilescreen({Key? key}) : super(key: key);

  @override
  State<Profilescreen> createState() => _ProfilescreenState();
}

class _ProfilescreenState extends State<Profilescreen> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
     final theme = Theme.of(context);
    void addToHabitList(String habitName, String habitDescription) {
      habitList.add([false, habitName, habitDescription, Icon(Icons.abc)]);
    }

    void addHabit(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          TextEditingController habitNameController =
              TextEditingController(text: "Habit Name");
          TextEditingController habitDescriptionController =
              TextEditingController(text: "Habit Description");
          return AlertDialog(
            title: Text("Add a Habit"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: habitNameController,
                ),
                TextFormField(
                  controller: habitDescriptionController,
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      WidgetStateProperty.all(Colors.green),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel",
                style: TextStyle(
                  color: Colors.white
                ),),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                    WidgetStateProperty.all(Colors.green),
                ),
                onPressed: () {
                  setState(() {
                    addToHabitList(habitNameController.text,
                        habitDescriptionController.text);
                  });
                  Navigator.pop(context);
                },
                child: Text("Save",
                style: TextStyle(
                  color: Colors.white
                ),),
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        mini: true,
        backgroundColor:theme.appBarTheme.backgroundColor,
        child: Icon(Icons.add),
        onPressed: (() {
          addHabit(context);
        }),
      ),
      backgroundColor: theme.appBarTheme.backgroundColor,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Image.asset(
                        AppConstants.Profilepage,
                        height: 180.h,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 180, 0, 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hey Ankit!",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: theme.textTheme.bodyLarge?.color,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "You have ${habitList.length - counter} habits left for today",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color:  theme.textTheme.bodyLarge?.color,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 30),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: AppColors.kFormLabelColor, // Button color
                                                  ),
                                                  onPressed: () async {
                                                    // Sign out from Firebase Auth
                                                    await FirebaseAuth.instance.signOut();
                                                  
                                                    // Navigate to the login screen and remove all previous routes
                                                    Navigator.pushAndRemoveUntil(
                                                      context,
                                                      MaterialPageRoute(builder: (context) => Loginscreen()),
                                                      (route) => false,
                                                    );
                                                  },
                                                  child: Text("Logout",
                                                  style: TextStyle(
                                                    color: Colors.white
                                                  ),),
                                                 ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: habitList.length,
                    itemBuilder: (context, int index) {
                      return ListTile(
                        title: Text(habitList[index][1]),
                        subtitle: Text(habitList[index][2]),
                        trailing: habitList[index][3],
                        leading: Checkbox(
                          value: habitList[index][0],
                          onChanged: ((value) {
                            setState(() {
                              if (value == false) {
                                counter -= 1;
                                habitList[index][0] = value;
                              } else {
                                counter += 1;
                                habitList[index][0] = value;
                              }
                            });
                          }),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),


    );
  }
}
