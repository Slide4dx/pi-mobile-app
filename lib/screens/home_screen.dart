import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/environment_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  
  // Pages de l'application
  static List<Widget> _pages = <Widget>[
    DashboardPage(),
    ProfilePage(),
    SettingsPage(),
  ];
  
  @override
  Widget build(BuildContext context) {
    final envService = Provider.of<EnvironmentService>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text('PI Mobile App'),
        actions: [
          if (envService.isDemo)
            Chip(
              label: Text('DEMO', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              backgroundColor: Colors.red,
            ),
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              _showAppInfo(context, envService);
            },
          ),
        ],
      ),
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Tableau de bord',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Paramètres',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
  
  void _showAppInfo(BuildContext context, EnvironmentService envService) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Informations sur l\'application'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Version: ${envService.env['VERSION']}'),
              Text('Environnement: ${envService.env['ENV']}'),
              Text('Mode: ${envService.env['MODE']}'),
              if (envService.isDemo)
                Text(
                  'ATTENTION: Vous utilisez l\'application en mode démo. Les données affichées sont fictives.',
                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Fermer'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

// Pages simples pour la démonstration
class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final envService = Provider.of<EnvironmentService>(context);
    
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.dashboard, size: 80, color: Colors.blue),
          SizedBox(height: 20),
          Text(
            'Tableau de bord',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text(
            envService.isDemo 
              ? 'Données de démonstration' 
              : 'Données réelles depuis l\'API',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person, size: 80, color: Colors.blue),
          SizedBox(height: 20),
          Text(
            'Profil Utilisateur',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.settings, size: 80, color: Colors.blue),
          SizedBox(height: 20),
          Text(
            'Paramètres',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
