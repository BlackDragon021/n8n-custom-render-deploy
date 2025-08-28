# n8n Custom Deploy - FFmpeg + MinIO + Kokoro TTS

[![Deploy to Render](https://render.com/images/deploy-to-render-button.svg)](https://render.com/deploy)

## 🚀 Déploiement n8n personnalisé sur Render

Cette configuration déploie n8n avec des fonctionnalités étendues :
- ✅ **FFmpeg** intégré pour traitement audio/vidéo
- ✅ **MinIO** pour stockage S3-compatible
- ✅ **No-code Architects Toolkit** pour outils personnalisés
- ✅ **Kokoro TTS** pour synthèse vocale
- ✅ **PostgreSQL** pour base de données
- ✅ **Stockage persistant** pour les données

## 📋 Instructions de déploiement

### Étape 1 : Déploiement automatique
1. **Cliquez sur le bouton "Deploy to Render" ci-dessus**
2. Connectez votre compte GitHub si nécessaire
3. Choisissez un nom de blueprint (ex: "n8n-custom")
4. Cliquez sur "Create New Resources"
5. Attendez que tous les services se déploient (~5-10 minutes)

### Étape 2 : Configuration des webhooks
1. Allez dans **Render Dashboard** > **n8n-custom** (votre service)
2. Copiez l'URL du service (lien violet dans l'en-tête)
3. Allez dans **Environment** et ajoutez :
   - `WEBHOOK_URL` = votre URL copiée
   - `N8N_HOST` = votre URL sans https://
4. Attendez que le service redémarre

### Étape 3 : Accès aux services

#### n8n Interface
- **URL** : Votre service principal n8n-custom
- **Login** : Première visite = création du compte admin

#### MinIO Console (Stockage S3)
- **URL** : Votre service minio:9001
- **Login** : `n8n-minio-key` / mot de passe généré automatiquement

## 🛠 Fonctionnalités disponibles

### Processing Audio/Vidéo avec FFmpeg
- Conversion de formats (MP4, MP3, WAV, etc.)
- Redimensionnement vidéo
- Extraction audio depuis vidéo
- Compression et optimisation

### Stockage MinIO (S3-Compatible)
- Upload/download de fichiers
- Buckets pour organisation
- Compatible avec APIs S3
- Interface web de gestion

### Synthèse Vocale Kokoro TTS
- Génération de voix synthétique
- Personnalisation des voix
- Intégration dans les workflows n8n

## 💰 Coûts

- **Gratuit pendant 90 jours**
- Après : **7$/mois** pour la base de données PostgreSQL
- Services web restent gratuits (avec limitations)

## 🔧 Variables d'environnement

| Variable | Description | Valeur par défaut |
|----------|-------------|-------------------|
| `FFMPEG_PATH` | Chemin vers FFmpeg | `/usr/bin/ffmpeg` |
| `MINIO_ENDPOINT` | Point d'accès MinIO | Auto-configuré |
| `KOKORO_TTS_ENABLED` | Active Kokoro TTS | `true` |
| `GENERIC_TIMEZONE` | Fuseau horaire | `Europe/Paris` |
| `N8N_DEFAULT_LOCALE` | Langue interface | `fr` |

## 🏗 Architecture

```
n8n-custom (Web Service)
├── FFmpeg intégré
├── Kokoro TTS installé
├── Stockage persistant (1GB)
└── Connexion PostgreSQL

MinIO (Private Service)
├── API S3-compatible
├── Console web
└── Stockage persistant (1GB)

PostgreSQL Database
└── Données n8n persistantes
```

## 🔍 Dépannage

### Service ne démarre pas
- Vérifiez les logs dans Render Dashboard
- Assurez-vous que tous les services sont "Live"

### MinIO non accessible
- Vérifiez que le service MinIO est démarré
- URL console : `https://votre-minio-service.onrender.com:9001`

### FFmpeg non trouvé
- Variable `FFMPEG_PATH` correcte ?
- Redémarrez le service après modification

## 📚 Documentation

- [n8n Documentation](https://docs.n8n.io/)
- [MinIO Documentation](https://docs.min.io/)
- [Render Documentation](https://render.com/docs)

---

**Créé pour le déploiement facile de n8n avec fonctionnalités étendues**  
🔧 Basé sur le travail d'Antoine Deschamps - La Machine
