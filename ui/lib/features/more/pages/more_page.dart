import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const ListTile(
            leading: CircleAvatar(
              child: FaIcon(FontAwesomeIcons.userCircle),
            ),
            title: Text('Nom prenom'),
            subtitle: Text('email'),
            trailing: FlatButton(
              child: const Text('login'),
              onPressed: null,
            ),
          ),
          Divider(),
          FlatButton(
            child: Text('Test'),
          )
        ],
      ),
    );
  }
}
