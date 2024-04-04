// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class SettingsTile extends StatefulWidget {
  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final dynamic icon;
  final String title;
  final String subtitle;

  @override
  State<SettingsTile> createState() => _SettingsTileState();
}

class _SettingsTileState extends State<SettingsTile> {
  List<bool> selectedTheme = [true, false, false];

  List<Widget> themeSelections = <Widget>[
    const Text('Auto'),
    const Text('Dark'),
    const Text('Light'),
  ];

  // @override
  // void initState() {
  //   super.initState();
  //   _selectedTheme =
  //       List<bool>.generate(themeSelections.length, (index) => false);
  // }

  @override
  Widget build(BuildContext context) {
    List<List<dynamic>> colorThemes = [
      [Colors.blue, false],
      [Colors.black, false],
      [Colors.deepPurple, true],
      [Colors.deepOrange, false],
      [Colors.white, false],
    ];

    return ListTile(
      leading: widget.icon is IconData ? Icon(widget.icon) : widget.icon,
      title: Text(
        widget.title,
        style: const TextStyle(
          color: Colors.black,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.subtitle),
          if (widget.title == "App color theme")
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: SizedBox(
                height: 50,
                child: ListView.builder(
                  itemCount: colorThemes.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 50,
                      width: 50,
                      padding: const EdgeInsets.all(6),
                      margin: const EdgeInsets.only(right: 5),
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: ClipOval(
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            color: colorThemes[index][0], // color theme
                            border: Border.all(
                              color: Colors.grey[600]!,
                              width: 1.4,
                            ),
                            borderRadius: BorderRadius.circular(90),
                          ),
                          child: colorThemes[index][1] == true
                              ? Icon(
                                  Icons.check,
                                  color: colorThemes[index][0] == Colors.white
                                      ? Colors.black
                                      : Colors.white,
                                )
                              : null,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          if (widget.title == "App color theme")
            ToggleButtons(
              // direction: vertical ? Axis.vertical : Axis.horizontal,
              onPressed: (int index) {
                setState(() {
                  // The button that is tapped is set to true, and the others to false.
                  for (int i = 0; i < selectedTheme.length; i++) {
                    selectedTheme[i] = false;
                  }
                  selectedTheme[index] = true;
                });
              },
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              // selectedBorderColor: Color.fromARGB(255, 0, 51, 71),
              selectedColor: Colors.white,
              fillColor: const Color(0xFF004864),
              color: Colors.grey[700],
              constraints: const BoxConstraints(
                minHeight: 40.0,
                minWidth: 80.0,
              ),
              isSelected: selectedTheme,
              children: themeSelections,
            ),
        ],
      ),
    );
  }
}
