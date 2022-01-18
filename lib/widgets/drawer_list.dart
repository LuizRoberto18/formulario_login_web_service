import 'package:flutter/material.dart';
import 'package:projeto_carros/pages/login/login_page.dart';
import 'package:projeto_carros/pages/login/usuario.dart';
import 'package:projeto_carros/utls/nav.dart';

class DrawerList extends StatelessWidget {
  Usuario user = Usuario();

  _header(Usuario user) {
    return UserAccountsDrawerHeader(
      accountName: Text("${user.nome}"),
      accountEmail: Text("${user.email}"),
      currentAccountPicture: CircleAvatar(
        backgroundImage: NetworkImage("${user.urlFoto}"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Future<Usuario?> future = Usuario.get();

    return SafeArea(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            FutureBuilder<Usuario?>(
              future: future,
              builder: (context, snapshot) {
                //Usuario user = snapshot.hasData;
                return user != null ? _header(user) : Container();

              },
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
    Usuario.clear();
    Navigator.pop(context);
    push(context, LoginPage(), replace: true);
  }
}
