# 🍳 Flutter Recettes

> Projet Flutter multi-écrans — App de recettes de cuisine avec navigation, recherche, formulaires et thème clair/sombre.

## 🎯 Description

Application Flutter complète de gestion de recettes de cuisine. Elle démontre les widgets Flutter, la navigation avancée avec **GoRouter**, la gestion d'état avec **Provider**, le responsive design (mobile & tablette) et la séparation stricte UI/données.



## 🚀 Instructions de lancement

### Prérequis

- [Flutter SDK](https://docs.flutter.dev/get-started/install) ≥ 3.24
- Un émulateur/device (iOS, Android) ou le support Web activé

### Installation

```bash
# 1. Cloner le dépôt
git clone https://github.com/supr3m/flutter-recettes.git
cd flutter-recettes

# 2. Récupérer les dépendances
flutter pub get

# 3. Lancer sur un appareil
flutter run
```

### Lancer sur une plateforme spécifique

```bash
flutter run -d chrome          # Web
flutter run -d ios             # iOS
flutter run -d android         # Android
```

## 🧪 Tests

```bash
flutter test
```

Les tests couvrent : le widget d'étoiles, le filtrage par recherche, le filtrage par catégorie, la bascule favoris et le rendu de l'écran de liste.

## ✅ Critères techniques couverts

Au moins 4 écrans distincts
Navigation avec GoRouter ou Navigator 2.0 (routes nommées)
Un écran de liste avec recherche/filtrage
Un écran de détail avec passage de paramètres
Un formulaire avec validation (au moins 3 champs)
Gestion du thème clair/sombre
ListView,Gridview, stack
Responsive tablet, iphone,web


## 🛠️ Stack technique

- **Flutter** avec Material 3
- **go_router** (18.x) — navigation déclarative
- **provider** (6.x) — gestion d'état
- Images : [Unsplash](https://unsplash.com) (source data)