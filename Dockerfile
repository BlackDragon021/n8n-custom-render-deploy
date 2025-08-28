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
    npm \
    curl \
    git

# Crée le répertoire pour les outils personnalisés et installe directement
RUN mkdir -p /usr/local/bin/no-code-tools && \
    cd /usr/local/bin/no-code-tools && \
    echo '{"name": "no-code-architects-toolkit", "version": "1.0.0", "description": "Toolkit pour architectes no-code", "main": "index.js", "dependencies": {"express": "^4.18.0", "multer": "^1.4.5-lts.1", "axios": "^1.0.0"}}' > package.json && \
    npm install && \
    echo 'const express = require("express"); const app = express(); console.log("🚀 No-code Architects Toolkit initialized"); app.get("/health", (req, res) => { res.json({ status: "OK", toolkit: "no-code-architects-toolkit" }); }); app.get("/tools", (req, res) => { res.json({ tools: ["ffmpeg-processor", "audio-converter", "file-manager"], version: "1.0.0" }); }); const PORT = process.env.TOOLKIT_PORT || 3001; app.listen(PORT, () => { console.log(`Toolkit API running on port ${PORT}`); });' > index.js

# Configure les variables d'environnement pour le toolkit
ENV TOOLKIT_PATH=/usr/local/bin/no-code-tools
ENV TOOLKIT_PORT=3001
ENV FFMPEG_PATH=/usr/bin/ffmpeg

# Remet l'utilisateur node pour la sécurité
USER node

# Expose le port standard de n8n
EXPOSE 5678

# Point d'entrée par défaut - utilise le chemin complet
CMD ["node", "/usr/local/lib/node_modules/n8n/bin/n8n", "start"]
