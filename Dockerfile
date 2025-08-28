# Utilise l'image officielle n8n comme base
FROM n8nio/n8n:latest

# Passe en utilisateur root pour installer les packages
USER root

# Met à jour les packages et installe ffmpeg et les dépendances nécessaires
RUN apk update && apk add --no-cache \
    ffmpeg \
    python3 \
    py3-pip \
    build-base \
    nodejs \
    npm

# Installe Kokoro TTS et autres outils no-code
RUN npm install -g @kokoro/tts || echo "Kokoro TTS package not found, will be installed via workflow"

# Crée le répertoire pour les outils personnalisés
RUN mkdir -p /usr/local/bin/no-code-tools

# Copie et exécute le script de build du toolkit
COPY build-toolkit.sh /tmp/build-toolkit.sh
RUN chmod +x /tmp/build-toolkit.sh && /tmp/build-toolkit.sh

# Configure les variables d'environnement pour le toolkit
ENV TOOLKIT_PATH=/usr/local/bin/no-code-tools
ENV TOOLKIT_PORT=3001

# Remet l'utilisateur node pour la sécurité
USER node

# Expose le port standard de n8n
EXPOSE 5678

# Point d'entrée par défaut (hérite de l'image parent)
CMD ["n8n", "start"]
