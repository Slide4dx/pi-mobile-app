# Application Mobile PI

Cette application mobile est développée avec Flutter et permet d'accéder aux fonctionnalités de PI dans un environnement mobile. Elle est conçue pour fonctionner à la fois en mode démonstration (avec des données fictives) et en mode normal (connectée à un backend réel).

## Prérequis

Avant de commencer, assurez-vous d'avoir installé les outils suivants sur votre ordinateur :

### 1. Git

Git est un système de contrôle de version qui vous permet de télécharger le code source de l'application.

**Pour Windows :**
- Téléchargez Git depuis [git-scm.com](https://git-scm.com/download/win)
- Exécutez le programme d'installation et suivez les instructions à l'écran
- Pour vérifier l'installation, ouvrez l'invite de commande (cmd) et tapez : `git --version`

**Pour macOS :**
- Installez Git via Homebrew : `brew install git`
- Ou téléchargez depuis [git-scm.com](https://git-scm.com/download/mac)
- Pour vérifier l'installation, ouvrez le Terminal et tapez : `git --version`

**Pour Linux :**
- Utilisez votre gestionnaire de paquets, par exemple : `sudo apt install git` (Ubuntu/Debian)
- Pour vérifier l'installation, ouvrez le Terminal et tapez : `git --version`

### 2. Flutter

Flutter est le framework utilisé pour développer cette application mobile.

**Pour tous les systèmes d'exploitation :**
1. Téléchargez Flutter SDK depuis [flutter.dev](https://flutter.dev/docs/get-started/install)
2. Extrayez le fichier téléchargé dans un emplacement de votre choix (évitez les chemins avec des espaces ou des caractères spéciaux)
3. Ajoutez Flutter à votre PATH :
   - **Windows** : Ajoutez le chemin vers le dossier `flutter\bin` dans vos variables d'environnement
   - **macOS/Linux** : Ajoutez `export PATH="$PATH:[CHEMIN_VERS_FLUTTER]/flutter/bin"` à votre fichier `.bashrc`, `.zshrc` ou équivalent

4. Vérifiez l'installation en exécutant :
   ```
   flutter doctor
   ```
   Cette commande vérifie votre environnement et affiche un rapport sur l'état de votre installation Flutter.

5. Suivez les instructions supplémentaires fournies par `flutter doctor` pour compléter la configuration (installation d'Android Studio, Xcode, etc.)

## Téléchargement du code source

Pour obtenir le code source de l'application, utilisez la commande Git suivante :

```bash
git clone https://github.com/Slide4dx/pi-mobile-app.git
```

Cette commande télécharge tous les fichiers du projet dans un dossier nommé `pi-mobile-app`.

## Configuration du fichier env.json

L'application utilise un fichier de configuration `env.json` pour gérer les variables d'environnement. Ce fichier est essentiel pour le bon fonctionnement de l'application.

### Étapes pour configurer le fichier env.json :

1. Naviguez dans le dossier du projet :
   ```bash
   cd pi-mobile-app
   ```

2. Vérifiez si le fichier `env.json` existe déjà à la racine du projet. Si ce n'est pas le cas, créez-le :
   ```bash
   touch env.json
   ```

3. Ouvrez le fichier avec votre éditeur de texte préféré et copiez-y le contenu suivant :
   ```json
   {
     "ENV": "dev",
     "MODE": "demo",
     "FIREBASE_API_KEY_ANDROID": "AIzaSyAqvGLykXlruT9Z8dBVLQsnI9FU7RVBLRs",
     "FIREBASE_APP_ID": "1:909112733465:ios:9427a3ff9fd97ae7515f88",
     "FIREBASE_MESSAGING_SENDER_ID": "909112733465",
     "FIREBASE_PROJECT_ID": "pi-mobile-app-dev",
     "FIREBASE_STORAGE_BUCKET": "pi-mobile-app-dev.appspot.com",
     "FIREBASE_API_KEY_IOS": "AIzaSyC7S3du5zm1KNDlWikPVUnnl8Z01HEekWw",
     "FIREBASE_IOS_BUNDLE_ID": "com.example.piMobileApp",
     "LOG_LEVEL": "info",
     "API_URL": "https://xyz.com",
     "VERSION": "0.0.1",
     "KEYCLOAK_AUTHORIZATION_ENDPOINT": "",
     "KEYCLOAK_TOKEN_ENDPOINT": "",
     "KEYCLOAK_REDIRECT_URI": "myapp://login",
     "KEYCLOAK_LOGOUT_ENDPOINT": "",
     "KEYCLOAK_REVOCATION_ENDPOINT": "",
     "KEYCLOAK_USER_INFO_ENDPOINT": ""
   }
   ```

4. Enregistrez le fichier.

### Explication des variables d'environnement :

- **ENV** : Environnement de l'application (`dev`, `staging`, `prod`)
- **MODE** : Mode de fonctionnement (`demo` ou `normal`)
- **FIREBASE_...** : Configurations pour Firebase (authentification, stockage, etc.)
- **LOG_LEVEL** : Niveau de détail des journaux (`info`, `debug`, `error`, etc.)
- **API_URL** : URL de l'API backend
- **VERSION** : Version de l'application
- **KEYCLOAK_...** : Configurations pour l'authentification Keycloak

## Lancement de l'application

### Installation des dépendances

Avant de lancer l'application, vous devez installer toutes les dépendances requises :

```bash
flutter pub get
```

Cette commande télécharge et installe toutes les bibliothèques nécessaires définies dans le fichier `pubspec.yaml`.

### Lancement en mode démo

Le mode démo vous permet de tester l'application sans avoir besoin d'une connexion à un backend réel. C'est le mode idéal pour découvrir l'application et ses fonctionnalités.

Pour lancer l'application en mode démo, assurez-vous que dans votre fichier `env.json`, la valeur de `MODE` est définie sur `"demo"` :

```json
"MODE": "demo"
```

Puis exécutez la commande suivante :

```bash
flutter run --dart-define-from-file=env.json
```

Cette commande :
1. Compile l'application Flutter
2. Charge les variables d'environnement depuis le fichier `env.json`
3. Lance l'application sur un émulateur ou un appareil connecté

Si vous avez plusieurs appareils connectés, Flutter vous demandera de choisir sur lequel vous souhaitez lancer l'application.

### Lancement en mode normal

Le mode normal connecte l'application à un véritable backend via API. Pour utiliser ce mode :

1. Modifiez la valeur de `MODE` dans votre fichier `env.json` :
   ```json
   "MODE": "normal"
   ```

2. Assurez-vous que l'`API_URL` pointe vers un backend valide :
   ```json
   "API_URL": "https://votre-api-backend.com"
   ```

3. Lancez l'application avec la même commande :
   ```bash
   flutter run --dart-define-from-file=env.json
   ```

## Navigation dans l'application

L'application est organisée en plusieurs écrans accessibles via une barre de navigation en bas de l'écran :

### Tableau de bord
- Premier onglet de la barre de navigation (icône de tableau de bord)
- Affiche une vue d'ensemble des données principales
- En mode démo, affiche des données fictives
- En mode normal, affiche des données réelles provenant de l'API

### Profil
- Deuxième onglet de la barre de navigation (icône de personne)
- Permet de consulter et modifier les informations de votre profil
- Gérer vos préférences personnelles

### Paramètres
- Troisième onglet de la barre de navigation (icône d'engrenage)
- Permet de configurer les options de l'application
- Gérer les notifications et autres préférences

### Informations sur l'application
- Accessible via l'icône d'information dans la barre supérieure
- Affiche la version actuelle de l'application
- Indique l'environnement et le mode de fonctionnement
- En mode démo, un avertissement est affiché pour rappeler que les données sont fictives

## Dépannage

### L'application ne se lance pas
- Vérifiez que Flutter est correctement installé : `flutter doctor`
- Assurez-vous que toutes les dépendances sont installées : `flutter pub get`
- Vérifiez que le fichier `env.json` existe et est correctement formaté

### Erreurs liées à Firebase
- En mode normal, vérifiez que les clés Firebase dans `env.json` sont correctes
- Assurez-vous que l'application est enregistrée dans votre projet Firebase

### Problèmes de connexion à l'API
- Vérifiez que l'URL de l'API dans `env.json` est correcte
- Assurez-vous que votre appareil a accès à Internet
- En cas de problème persistant, passez temporairement en mode démo pour tester les fonctionnalités

## Contribution au projet

Si vous souhaitez contribuer au développement de cette application :

1. Créez une branche pour vos modifications :
   ```bash
   git checkout -b ma-nouvelle-fonctionnalite
   ```

2. Effectuez vos modifications et testez-les

3. Validez vos changements :
   ```bash
   git commit -m "Description de mes modifications"
   ```

4. Poussez votre branche vers le dépôt :
   ```bash
   git push origin ma-nouvelle-fonctionnalite
   ```

5. Créez une Pull Request sur GitHub pour proposer vos modifications

## Besoin d'aide ?

Si vous rencontrez des difficultés ou avez des questions, n'hésitez pas à :
- Consulter la documentation de Flutter : [flutter.dev/docs](https://flutter.dev/docs)
- Ouvrir une issue sur le dépôt GitHub du projet
- Contacter l'équipe de développement
