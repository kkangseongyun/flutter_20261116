import 'package:flutter_lab/screen/myinfo/MyInfoScreen.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(//scroller...
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 40, color: Colors.blue),
                ),
                SizedBox(height: 10),
                Text(
                  'kim@example.com',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('MyInfo'),
            onTap: (){
              // Navigator.push(context, MaterialPageRoute(builder: (context) => MyInfoScreen()));
              context.push('/myinfo/20?q=flutter', extra: {
                'item': 'hello',
                'no': 10
              });
            },
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('dio'),
            onTap: (){
              context.push('/dio');
            },
          )
        ],
      ),
    );
  }
}
