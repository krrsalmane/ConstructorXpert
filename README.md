# 🏗️ ConstructionXpert Services
### Application de Gestion de Projets de Construction

---

## 📋 Description de l'application
**ConstructionXpert Services** est une application web destinée à la gestion de projets de construction. Elle permet à l'équipe de construction de :
- **Créer, suivre et gérer** des projets de construction.
- **Assigner et gérer** des tâches pour chaque projet.
- **Gérer les ressources nécessaires** (matériaux, équipements, etc.).
- **Gérer les fournisseurs**.

L’application offre une interface **conviviale et responsive**, avec des fonctionnalités d'**authentification** et de **sécurité** pour l’administrateur.

---

## 🚀 Fonctionnalités principales

### 🔐 Authentification
- Connexion / Déconnexion de l'administrateur.
- Protection des pages après connexion.

### 📁 Gestion des Projets
- Ajouter, afficher, modifier et supprimer un projet.
- Suivre le budget, les dates de début/fin.

### 📋 Gestion des Tâches
- Créer, afficher, mettre à jour et supprimer des tâches liées à un projet.
- Assigner des ressources aux tâches.

### ⚙️ Gestion des Ressources
- Ajouter, afficher, modifier et supprimer les ressources.
- Mettre à jour les quantités après l'assignation aux tâches.

### 🏢 Gestion des Fournisseurs
- Ajouter, afficher, modifier et supprimer les fournisseurs.

---

## 🛠️ Technologies utilisées
- **Back-end** : Java EE (Servlets, JSP)
- **Base de données** : MySQL
- **Communication DB** : JDBC
- **Serveur** : Apache Tomcat
- **Front-end** : HTML, CSS (Bootstrap/Tailwind), JavaScript
- **Design Maquette** : Figma / Adobe XD
- **Versioning** : Git / GitHub

---

## 📊 Diagrammes

Voici les diagrammes illustrant les aspects clés de **ConstructionXpert Services** :

1. **Diagram de classe**
    - [![![Capture d'écran 2025-03-22 220948.png](UML%20Diagrams/Capture%20d%27%C3%A9cran%202025-03-22%20220948.png)]]


2. **Diagram de sequence**
    - [![!![Capture d'écran 2025-03-22 221044.png](UML%20Diagrams/Capture%20d%27%C3%A9cran%202025-03-22%20221044.png)]]


3. **Diagram use case**
    - [![![Capture d'écran 2025-03-22 220919.png](UML%20Diagrams/Capture%20d%27%C3%A9cran%202025-03-22%20220919.png)]]  


## ⚠️ Problèmes connus

Voici les aspects de l'application qui ne fonctionnent pas encore de manière optimale :

### 🧠 Logique des ressources
- **Problème** : La logique d'allocation des ressources présente des incohérences, notamment dans la vérification des quantités disponibles avant assignation.
- **Impact** : Peut entraîner des erreurs dans la gestion des stocks.

### 🔄 Mise à jour des ressources
- **Problème** : Les quantités de ressources ne se mettent pas à jour correctement après leur assignation ou modification dans les tâches.
- **Impact** : Les données affichées peuvent être obsolètes ou incorrectes.

### 🔐 Authentification
- **Problème** : Le système d'authentification rencontre des bogues intermittents, comme des déconnexions inattendues ou des échecs de validation des identifiants.
- **Impact** : Réduit la fiabilité de la sécurité et l’expérience utilisateur.