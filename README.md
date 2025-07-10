# 🏦 Bankati – Application Web de Gestion Bancaire

## 📌 Description

**Bankati** est une application web Java simulant les opérations bancaires de base à travers une architecture MVC (Spring Boot). L'application permet la gestion des clients, des comptes, des opérations bancaires, et offre deux profils utilisateurs : **Client** et **Administrateur**.

---

## 🧱 Technologies utilisées

- ☕ Java 17+
- 🌐 Spring Boot
- 🧩 Maven
- 🗃️ MySQL
- 🌍 HTML / JSP
- 🔐 Spring Security (optionnel)
- 🧠 IntelliJ IDEA (développement)

---

## 🛠 Fonctionnalités principales

- 🔐 Authentification client et administrateur
- 👥 Gestion des clients (CRUD)
- 💳 Création et gestion des comptes
- 💰 Dépôts, retraits et virements
- 📊 Visualisation des opérations par compte
- 🧾 Historique des opérations

---

## 🗂 Structure du projet

```

Bankati/
│
├── src/
│   ├── main/
│   │   ├── java/com/bankati/           → Logique métier (services, contrôleurs, entités)
│   │   └── resources/                  → Fichiers de configuration (application.properties, templates)
│   └── test/                           → Tests unitaires (optionnel)
│
├── pom.xml                             → Fichier de configuration Maven
├── .idea/                              → Fichiers IntelliJ (à ignorer)
├── .smarttomcat/                       → Configuration du serveur local
└── README.md                           → Fichier descriptif du projet

````

---

## ▶️ Lancement du projet

### ✅ Prérequis

- Java JDK 17+
- Maven
- MySQL Server
- IDE (IntelliJ IDEA recommandé)

### ⚙️ Étapes

1. Cloner le dépôt :
   ```bash
   git clone https://github.com/votre-utilisateur/Bankati.git
````

2. Créer une base de données `bankati_db` dans MySQL.

3. Modifier `src/main/resources/application.properties` :

   ```properties
   spring.datasource.url=jdbc:mysql://localhost:3306/bankati_db
   spring.datasource.username=your_mysql_user
   spring.datasource.password=your_mysql_password
   ```

4. Compiler et exécuter :

   ```bash
   mvn clean install
   mvn spring-boot:run
   ```

5. Accéder à l’application :

   ```
   http://localhost:8080/
   ```

---

## 🔐 Sécurité & Suggestions

* Ajouter une gestion des rôles avec **Spring Security**
* Intégrer un système de validation et d’erreurs utilisateur
* Possibilité d'ajouter une interface front-end avec Angular ou React

---

## 👨‍💻 Auteur

Projet développé par :
**Riad Hanane**
Élève ingénieur à l’EMSI – Filière IIR

---

## 🎯 Objectif

Ce projet académique a été réalisé pour appliquer les connaissances en :

* Développement Web Java EE / Spring Boot
* Modèle MVC
* Manipulation de base de données relationnelle
* Déploiement d’application web locale
