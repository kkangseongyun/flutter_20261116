import 'package:material_ui/material_ui.dart';

import '../dto/EventDto.dart';

class EventCard extends StatelessWidget {
  EventDto vo;

  EventCard(this.vo);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: Color(0xFF3899DD)),
        Align(
          alignment: Alignment(0.0, 0.0), //center
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
