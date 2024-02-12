# Activiteam

#### Alexandre VIALE

## US#1 Interface de login

Tous les points sont respectés.

### Fonctionnalités supplémentaires :

- Possibilité de créer un compte en cliquant sur le bouton "Pas encore de compte ?"
- Utilisation de FirebaseAuth pour l'authentification.

## US#2 Liste des activités

Tous les points sont respectés.

### Fonctionnalités supplémentaires

- Un Skeleton est affiché pendant le chargement de la liste des activités.

## US#3 Détail d'une activité

Tous les points sont respectés.

### Fonctionnalités supplémentaires

- Animation à l'aide du widget Hero pour la fluidité dans la navigation et l'esthétique.

## US#4 Le panier

Tous les points son respectés.

### Fonctionnalités supplémentaires

- Ajout de la possibilité d'incrémenter ou décrémenter afin de prendre des places pour plusieurs personnes, lorsque l'on retombe à 0, l'article est supprimé du panier.
- Un scroll horizontal sur l'adresse car la plupart des adresses sont trop longues à afficher dans une ListTile.

## US#5 Profil utilisateur

Tous les points sont respectés.
Le bouton de déconnexion se trouve dans le drawer pour des raisons conventionnelles.

## US#6 Et si on rajoutait un peu d’IA ?

J'ai choisi d'utiliser teachable machine pour prédire le titre de l'activité en fonction de l'image.
J'ai donc créé un classifieur que j'ai intégré à mon application flutter, celui-ci fonctionne grâce à tensorflow lite.
La librairie qui s'occupe de ça s'appelle `tflite_flutter`.
Il suffit d'appuyer sur le bouton "Prédire le titre de l'activité" sur la page d'ajout d'activité après avoir collé le lien de l'image.

### Difficultés rencontrées

Mon modèle n'arrivait pas à prédire car je ne faisais pas de prétraitement sur mon image.
Le code concernant mon classifieur se trouve dans `model/classifier.dart`.

## US#7 Ajouter une nouvelle activité

Tous les points sont respectés

## Global

### Fonctionnalités supplémentaires

- Un drawer
- La navigation entre les pages peut se faire par geste en glissant pour la fluidité

### Points forts

- La gestion du panier et des activités est effectuée à l'aide de providers afin de garantir la cohérence entre les différentes pages (voir le dossier providers).
- La structure de fichiers du projet bien organisée pour des projets de grande envergure.
- Le design
