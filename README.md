# 🥊 BoxCoach AI — Entrenador Digital de Boxeo

Sistema completo de automatización para atletas de boxeo que usa n8n, Strava, Claude AI y Telegram para analizar entrenamientos y generar planes personalizados.

## ¿Qué hace?

- Captura actividades de running desde Strava automáticamente
- Calcula métricas fisiológicas (TRIMP, zonas FC, pace, variabilidad)
- Genera planes de entrenamiento semanales con Claude AI basados en ciencia del deporte
- Envía análisis y feedback por Telegram después de cada sesión
- Mantiene memoria permanente del historial en PostgreSQL
- Detecta fatiga, progresión y récords personales

## Base científica

Los planes se generan basándose en:
- **Eric Banister** — modelo TRIMP para cuantificar carga
- **Tudor Bompa** — periodización ondulante
- **Martin Buchheit** — HIIT 3:1 para sistema glucolítico
- **Joel Jamieson** — energía específica para deportes de combate
- **Ross Enamait** — acondicionamiento de boxeo
- **Yuri Verkhoshansky** — sprints y potencia fosfágena
- **Arthur Lydiard** — base aeróbica
- **Jack Daniels** — zonas de FC

## Requisitos

- VPS con Docker (recomendado: 2GB RAM mínimo)
- Cuenta de Strava con app de desarrollador
- API Key de Anthropic (Claude)
- Bot de Telegram
- Google Sheets (opcional, para respaldo)

## Instalación

### 1. Clonar el repositorio
```bash
git clone https://github.com/tuusuario/boxing-coach-n8n.git
cd boxing-coach-n8n
```

### 2. Configurar variables de entorno
```bash
cp .env.example .env
nano .env  # Llena con tus datos reales
```

### 3. Levantar n8n con Docker
```bash
cp docker-compose.example.yml docker-compose.yml
nano docker-compose.yml  # Ajusta según tu servidor
docker compose up -d
```

### 4. Crear las tablas en PostgreSQL
```bash
docker exec -it postgres psql -U db_user -d db_n8n < database/schema.sql
```

### 5. Importar el workflow en n8n
1. Abre n8n en tu dominio
2. Workflows → Import from file
3. Sube `workflows/BoxCoach_AI_v8_clean.json`
4. Configura las credenciales (Strava, Telegram, Anthropic, Postgres)
5. Activa el workflow

### 6. Importar historial de Strava
1. Importa `workflows/BoxCoach_Import_Strava_clean.json`
2. Ejecuta manualmente para cargar tus actividades anteriores

## Estructura del proyecto

```
boxing-coach-n8n/
├── README.md
├── .gitignore
├── .env.example
├── docker-compose.example.yml
├── workflows/
│   ├── BoxCoach_AI_v8_clean.json
│   └── BoxCoach_Import_Strava_clean.json
└── database/
    └── schema.sql
```

## Flujos incluidos

| Flujo | Trigger | Descripción |
|-------|---------|-------------|
| Principal | Strava webhook | Analiza actividad y envía feedback |
| Chat | Telegram mensaje | Coach conversacional con contexto |
| Resumen | Domingo 10pm | Plan semanal generado por IA |
| Importar | Manual | Carga historial de Strava |

## Créditos

Desarrollado con n8n, Claude AI (Anthropic), Strava API y Telegram Bot API.
