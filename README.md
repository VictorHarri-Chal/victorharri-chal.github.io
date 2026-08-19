# Portfolio - Victor Harri-Chal

<div align="center">

![Ruby](https://img.shields.io/badge/Ruby-CC342D?style=for-the-badge&logo=ruby&logoColor=white)
![Rails](https://img.shields.io/badge/Rails-CC0000?style=for-the-badge&logo=ruby-on-rails&logoColor=white)
![Tailwind CSS](https://img.shields.io/badge/Tailwind_CSS-38B2AC?style=for-the-badge&logo=tailwind-css&logoColor=white)
![Stimulus](https://img.shields.io/badge/Stimulus-00D4FF?style=for-the-badge&logo=stimulus&logoColor=white)

**Mon portfolio personnel, développé avec Ruby on Rails 8**

[Voir le site](https://victorharri-chal.github.io) · [Me contacter](mailto:victorharrichal@yahoo.com)

</div>

---

## À propos

Portfolio présentant mon parcours, mes compétences et mes projets. C'est une
application Rails classique en développement, exportée en site statique et
publiée sur GitHub Pages à chaque push sur `main`.

## Contenu

- **Accueil** : présentation et navigation
- **Projets** : quatre projets principaux avec leur fiche détaillée, plus une
  sélection de projets d'études
- **À propos** : parcours, évolution technique et technologies
- **Contact** : LinkedIn, e-mail, GitHub et CV

Les projets principaux sont NutriFlow, Vigie, NestioBnb et Scandela.

## Stack

- **Ruby on Rails 8** avec Propshaft et Importmap
- **Hotwire** (Turbo + Stimulus) pour les interactions
- **Tailwind CSS v4**
- Aucune base de données : le site n'en a pas besoin

## Développement

```bash
bin/setup          # installe les dépendances
bin/dev            # lance le serveur et le watcher Tailwind
```

Le site est alors disponible sur `http://localhost:3000`.

## Ajouter ou modifier un projet

Tout le contenu des projets vit dans [`config/projects.yml`](config/projects.yml).
Une entrée dans `featured` génère à la fois la carte sur la page projets et sa
fiche détaillée, et le script de build y lit la liste des pages à produire. Il
n'y a rien d'autre à toucher.

## Déploiement

Chaque push sur `main` déclenche [le workflow](.github/workflows/deploy.yml), qui :

1. précompile les assets ;
2. démarre le serveur Rails en mode production ;
3. exécute [`script/build_static.rb`](script/build_static.rb), qui récupère
   chaque page et l'écrit dans `_site/` ;
4. publie le résultat sur GitHub Pages.

Le script vérifie chaque page avant de l'écrire. Une réponse en erreur, une page
vide ou une exception Rails interrompt le build au lieu d'être mise en ligne.

Le dépôt étant un site utilisateur servi à la racine du domaine, les chemins
absolus produits par Rails fonctionnent tels quels : aucune réécriture de liens
n'est nécessaire. Chaque page est écrite en `<chemin>/index.html`, avec une copie
en `<chemin>.html` pour les adresses publiées auparavant.

Pour reproduire le build en local :

```bash
export RAILS_ENV=production SECRET_KEY_BASE=peu-importe
bin/rails assets:precompile
bin/rails server -e production -p 3000 -b 127.0.0.1 &
bundle exec ruby script/build_static.rb
cd _site && python3 -m http.server 4000
```

---

<div align="center">

[LinkedIn](https://www.linkedin.com/in/victor-harri-chal/) · [GitHub](https://github.com/VictorHarri-Chal) · [Portfolio](https://victorharri-chal.github.io)

</div>
