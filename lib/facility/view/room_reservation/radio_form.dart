import 'package:flutter/material.dart';
import 'package:senior_project/facility/model/facility_model.dart';

class RadioForm extends StatefulWidget {
  final List<RoomModel> rooms;
  final Function(RoomModel) onPressed;
  const RadioForm({super.key, required this.rooms, required this.onPressed});

  @override
  State<RadioForm> createState() => _RadioFormState();
}

class _RadioFormState extends State<RadioForm> {
  RoomModel? selectedRoom;
  @override
  Widget build(BuildContext context) {
    if (widget.rooms.isEmpty) {
      return Container();
    }
    return Column(
      children: widget.rooms.map((room) {
        return RadioListTile<RoomModel>(
          title: Text(room.name),
          subtitle: Text('${room.type} - ${room.capacity} pax'),
          value: room,
          groupValue: selectedRoom,
          onChanged: (value) {
            setState(() {
              selectedRoom = value;
            });
          },
        );
      }).toList(),
    );
  }
}
