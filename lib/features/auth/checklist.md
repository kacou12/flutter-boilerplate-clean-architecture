Voici une version organisée de votre liste de bugs, pour un format README structuré :

---

## Problèmes Globaux
- Afficher une page "Not Found" si `getUserProfile` ne renvoie pas de données.
- Message « Aucune ville pour ce pays » si aucune ville n’est trouvée pour un pays donné.

## API
- **{EVENT}** : Ajouter un `populate` pour le club associé.
- **EVENT NEAR** : Ne pas renvoyer les événements passés.
- **FILTRE** : Le filtre de localisation ne fonctionne pas correctement.

## Feed
- **Vue** : Mettre à jour le nombre de vues via l'API.
- **Like** : Mettre à jour l'état du like localement avant de faire l'appel à l'API.
- **Commentaire** :
  - Afficher l'icône de like pour l'utilisateur qui a commenté.
  - Ajouter un scroll lorsque la liste des commentaires est longue.
- **Feed Card** :
  - Corriger le double clic nécessaire pour reposter.
  - Rendre cliquable toute la ligne du profil du posteur originel.

## Account (Page de blocage d’utilisateur)
- **Page Grise** : Afficher la page en gris pour les utilisateurs bloqués.
- **Modification de Profil** : La date d’anniversaire ne passe pas.

## Réglages (Settings)
- **Inviter par SMS** : Ne fonctionne pas sur Android.
- **Help and Support** : Désactiver cette option.
- **Déconnexion** : Ne fonctionne pas.

## Profil
- **Voir Tout** : Désactiver le bouton "See All" s'il n’y a pas d’événement.

## Événements (Events)
- **Filtre** :
  - **Event Club** : Ne fonctionne pas.
  - **Global** : Réinitialiser et corriger le filtre global.
  - Retirer le filtre par catégorie et la date dans le titre de la page.
- **Actualisation** : Rafraîchir les événements après création (event normal, club, coach).
- **Recherche (Search)** : Désactiver ou corriger.
- **Détails d’un Événement** :
  - Vérifier la condition de participation.
  - Afficher les informations du club pour les événements de club.
  - Désactiver la barre inférieure.
  - Corriger la fermeture du menu.
  - Retirer les boutons de "Report" et "Cancel" dans le menu.
- **Édition d’un Événement** :
  - Les heures ne s’affichent pas.
  - Afficher le message de succès et fermer le modal après mise à jour.
- **Page d’Invitation d’Événement** : Ajouter un bouton flottant après création.
- **Page d’Événement** : Le filtre par défaut ne fonctionne pas.

## Club
- **Liste de Clubs** : Le bouton de création n’est pas visible.
- **Recherche** : Limiter l’affichage à 10 éléments.
- **Création de Club** :
  - Les champs "adresse", "site web", et "contact" ne devraient pas être obligatoires.
  - La recherche de catégorie ne fonctionne pas.
- **Création de Post** : Le média vidéo devrait occuper tout l’espace disponible.
- **Abonnement (Subscription)** :
  - Mettre à jour les détails après action CRUD sur les options de paiement.
  - Ajouter un espace sous le bouton pour ajouter un moyen de paiement.
  - Impossible de passer au paiement.
- **Tickets** :
  - Afficher les tickets pour les clients.
  - Afficher un pop-up après suppression d’un ticket.
- **Suppression de Souscription**