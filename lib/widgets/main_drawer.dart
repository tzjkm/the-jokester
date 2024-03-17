import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      // Handle the case when the URL cannot be launched.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Menu'),
          ),
          ListTile(
            leading: Icon(Icons.rate_review),
            title: Text('Submit Feedback'),
            onTap: () {
              _launchURL(
                  'https://play.google.com/store/apps/details?id=com.android.chrome');
            },
          ),
          ListTile(
            leading: Icon(Icons.share),
            title: Text('Share App'),
            onTap: () {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: Text('Share App'),
                  content: Text('Are you sure you want to share this app?'),
                  actions: <Widget>[
                    TextButton(
                      child: Text('Cancel'),
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                    ),
                    TextButton(
                      child: Text('Share'),
                      onPressed: () {
                        Navigator.of(ctx).pop();
                        _launchURL(
                            'https://wa.me/?text=Check%20out%20this%20app:%20https://play.google.com/store/apps/details?id=com.android.chrome');
                      },
                    ),
                  ],
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.new_releases),
            title: Text('Request New Feature'),
            onTap: () {
              _launchURL(
                  'https://play.google.com/store/apps/details?id=com.android.chrome');
            },
          ),
        ],
      ),
    );
  }
}
