# Étape de build (construction) de l'application
FROM elixir:1.14.0 AS build

# Installer les dépendances système nécessaires
RUN apt-get update && \
    apt-get install -y inotify-tools postgresql-client nodejs npm

# Installer Hex et Rebar sans confirmation interactive
RUN mix local.hex --force && \
    mix local.rebar --force

# Configurer le répertoire de travail
WORKDIR /app

# Copier les fichiers de configuration (mix.exs et mix.lock)
COPY mix.exs mix.lock ./

# Installer les dépendances de l'application
RUN mix deps.get --only prod

# Copier le reste des fichiers de l'application backend
COPY . .

# Compiler les assets (si tu utilises des assets comme JS/CSS)
RUN npm install --prefix ./assets && \
    npm run deploy --prefix ./assets && \
    mix phx.digest

# Compiler l'application pour l'environnement de production
RUN MIX_ENV=prod mix compile

# Générer une release pour l'environnement de production
RUN MIX_ENV=prod mix release

# Étape d'exécution (runtime)
FROM debian:bullseye-slim AS app

# Installer les dépendances système nécessaires pour l'exécution de l'application
RUN apt-get update && apt-get install -y libssl-dev openssl && apt-get clean

WORKDIR /app

# Copier les fichiers générés par la release depuis l'étape de build
COPY --from=build /app/_build/prod/rel/your_app_name ./

# Exposer le port 4000 pour Phoenix
EXPOSE 4000

# Démarrer l'application Elixir Phoenix via la release
CMD ["bin/your_app_name", "start"]

