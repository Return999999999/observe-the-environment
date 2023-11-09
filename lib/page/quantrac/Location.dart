// ignore_for_file: file_names, unnecessary_new
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:luanvan/data/Location_item.dart';

class Location extends StatefulWidget {
  const Location({super.key});

  @override
  State<Location> createState() => _SearchState();
}

class _SearchState extends State<Location> {
  DateTime now = new DateTime.now();
  final TextEditingController colorController = TextEditingController();
  final TextEditingController iconController = TextEditingController();
  ColorLabel? selectedColor;
  IconLabel? selectedIcon;
  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuEntry<ColorLabel>> colorEntries =
        <DropdownMenuEntry<ColorLabel>>[];
    for (final ColorLabel color in ColorLabel.values) {
      colorEntries.add(
        DropdownMenuEntry<ColorLabel>(
          value: color,
          label: color.label,
        ),
      );
    }

    final List<DropdownMenuEntry<IconLabel>> iconEntries =
        <DropdownMenuEntry<IconLabel>>[];
    for (final IconLabel icon in IconLabel.values) {
      iconEntries.add(DropdownMenuEntry<IconLabel>(
        value: icon,
        label: icon.label,
      ));
    }
    return Scaffold(
      body: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  '${now.hour}:${now.minute}   ${DateFormat('dd/MM/yyyy').format(now)}')
            ],
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                DropdownMenu<ColorLabel>(
                  //initialSelection: ColorLabel.blue,
                  controller: colorController,
                  label: const Text('Tỉnh Thành'),
                  dropdownMenuEntries: colorEntries,
                  onSelected: (ColorLabel? color) {
                    setState(() {
                      selectedColor = color;
                    });
                  },
                ),
                const SizedBox(width: 20),
                // if (selectedColor?.id == selectedIcon?.id) ý tưởng duyệt qua mảng IconLabel để so sánh với seletedColor?.id
                DropdownMenu<IconLabel>(
                  //initialSelection: IconLabel.smile,
                  controller: iconController,
                  label: const Text('Trạm'),
                  dropdownMenuEntries: iconEntries,
                  onSelected: (IconLabel? icon) {
                    setState(() {
                      selectedIcon = icon;
                    });
                  },
                ),
              ],
            ),
          ),
          if (selectedColor != null &&
              selectedIcon != null &&
              selectedColor?.id == selectedIcon?.id)
            Container(
              margin: const EdgeInsets.all(5.0),
              child: Card(
                margin: const EdgeInsets.all(5.0),
                child: ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    title: Text(
                      '${selectedIcon?.label}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(5.0),
                          child: Text(
                            'Nhiệt độ: ${selectedIcon?.temperature}',
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(5.0),
                          child: Text(
                            'Độ ẩm: ${selectedIcon?.humidity}',
                          ),
                        )
                      ],
                    )),
              ),
            )
          else if (selectedIcon?.label != null)
            Text('${selectedIcon?.label} trống')
        ],
      ),
    );
  }
}
