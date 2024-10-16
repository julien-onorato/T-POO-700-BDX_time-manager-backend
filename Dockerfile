# Utiliser une image de base pour Elixir
FROM elixir:1.14.0 AS build
 
# Installer les dépendances nécessaires
RUN apt-get update && \
    apt-get install -y inotify-tools postgresql-client nodejs npm
 
# Installer Hex sans confirmation interactive
RUN mix local.hex --force
 
# Installer rebar sans confirmation interactive
RUN mix local.rebar --force
 
# Configurer le répertoire de travail pour Elixir
WORKDIR /app
 
# Copier les fichiers de configuration Elixir
COPY mix.exs mix.lock ./
 
# Installer les dépendances du projet backend
RUN mix deps.get
 
# Copier le reste des fichiers de l'application backend
COPY . .
 
# Compiler le projet backend
RUN mix compile
 
# Exposer le port pour le backend
EXPOSE 4000
 
# Lancer l'application Elixir
ENTRYPOINT ["sh", "-c", "mix ecto.create && mix ecto.migrate && mix phx.server"]
