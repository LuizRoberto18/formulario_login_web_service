import 'package:flutter/material.dart';
import 'package:projeto_carros/pages/login/login_page.dart';
import 'package:projeto_carros/utls/nav.dart';

class DrawerList extends StatelessWidget {
final urlFoto = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR80YgNEdwXWpCSt7jgkwKqenTmZ-eubf642A&usqp=CAU";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Luiz Roberto"),
              accountEmail: Text("passageiro1829@gmai.com"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(urlFoto),
              ),
            ),
            _listTile(Icons.star, Icons.arrow_forward, "Favoritos",
                "Mais informações", () {
              Navigator.pop(context);
              print("favoritos");
            }),
            _listTile(
                Icons.help, Icons.arrow_forward, "Ajuda", "Mais informações..",
                () {
              print("item 2");
              Navigator.pop(context);
            }),
            _listTile(Icons.exit_to_app, Icons.arrow_forward, "Logout",
                "Mais informações", () {
              print("item 3");
              _onClickLogout(context);
            }),
          ],
        ),
      ),
    );
  }

  _listTile(IconData leading, IconData trailling, String title, String subtitle,
      Function onTap) {
    return ListTile(
      leading: Icon(leading),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Icon(trailling),
      onTap: () => onTap(),
    );
  }

  void _onClickLogout(BuildContext context) {
    Navigator.pop(context);
    push(context, LoginPage(), replace: true);
  }
}
