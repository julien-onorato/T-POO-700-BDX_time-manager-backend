# Utiliser l'image officielle de PostgreSQL
FROM postgres:17.0

# Définir les variables d'environnement pour PostgreSQL
ENV POSTGRES_USER=postgres
ENV POSTGRES_PASSWORD=root
ENV POSTGRES_DB=time_manager_dev

# Copier le fichier de sauvegarde dans le conteneur
COPY backup.sql /docker-entrypoint-initdb.d/

VOLUME /var/lin/postgresql/data
