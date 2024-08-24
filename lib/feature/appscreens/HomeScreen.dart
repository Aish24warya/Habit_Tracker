import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habittrackerapp/common/Constant.dart';
import 'package:habittrackerapp/feature/services/lists.dart';
import 'package:habittrackerapp/theme/Colors.dart';


class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
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
                        surfaceTintColor:
                            WidgetStateProperty.all(Colors.lightGreenAccent)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel")),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all(Colors.green),
                        surfaceTintColor:
                           WidgetStateProperty.all(Colors.lightGreenAccent)),
                    onPressed: () {
                      setState(() {
                        addToHabitList(habitNameController.text,
                            habitDescriptionController.text);
                      });
                      Navigator.pop(context);
                    },
                    child: Text("Save"))
              ],
            );
          });
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
      body: ListView(padding: EdgeInsets.zero, children: [
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Stack(children: [
              Center(
                child: Image.asset(
                  AppConstants.HomePage,
                   height: 250.h,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 140, 0, 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(children: [
                    Text(
                      "Hey Ankit!",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color:theme.textTheme.bodyLarge?.color),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "You have ${habitList.length - counter} habits left for today",
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: theme.textTheme.bodyLarge?.color),
                    ),
                  ]),
                ),
              )
            ]),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Keep Going!",
                        style: TextStyle(color: Colors.green[600], fontSize: 16),
                      ),
                      Text("${((counter / habitList.length) * 100).round()}%",
                          style:
                              TextStyle(color: Colors.green[600], fontSize: 16))
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: LinearProgressIndicator(
                        minHeight: 12,
                        color: Colors.lightGreenAccent,
                        backgroundColor: Color.fromARGB(255, 36, 167, 36),
                        value: (counter / habitList.length)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Divider(),
                ),
                SizedBox(
                  child: ListView.builder(
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
                                  print(counter.toString());
                                  habitList[index][0] = value;
                                } else
                                  counter += 1;
                                print(counter.toString());
                                habitList[index][0] = value;
                              });
                            }),
                          ));
                    },
                  ),
                )
              ],
            ),
          ),
        )
      ]),
    );
  }
}