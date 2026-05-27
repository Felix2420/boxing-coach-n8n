-- BoxCoach AI — Schema PostgreSQL
-- Ejecutar en: docker exec -it postgres psql -U db_user -d db_n8n

CREATE TABLE IF NOT EXISTS boxing_sessions (
  id SERIAL PRIMARY KEY,
  activity_id BIGINT UNIQUE,
  fecha TIMESTAMP,
  nombre TEXT,
  distancia_km NUMERIC(6,2),
  duracion_min NUMERIC(6,1),
  pace TEXT,
  pace_sec_km INTEGER,
  fc_media INTEGER,
  fc_max INTEGER,
  trimp INTEGER,
  intensidad_pct INTEGER,
  zona TEXT,
  variabilidad INTEGER,
  round_like BOOLEAN,
  session_type TEXT,
  fatiga_state TEXT,
  carga_semanal INTEGER,
  progresion_pct INTEGER,
  alertas TEXT,
  elevacion NUMERIC(6,1),
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS boxing_plan (
  id SERIAL PRIMARY KEY,
  generado_el TIMESTAMP,
  semana TEXT,
  sesion_actual INTEGER DEFAULT 0,
  completado BOOLEAN DEFAULT FALSE,
  sesiones JSONB,
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS boxing_records (
  id INTEGER PRIMARY KEY DEFAULT 1,
  best_pace_sec INTEGER,
  max_trimp INTEGER,
  max_intensidad INTEGER,
  updated_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS boxing_achievements (
  id SERIAL PRIMARY KEY,
  achievement TEXT UNIQUE,
  fecha TIMESTAMP DEFAULT NOW()
);

INSERT INTO boxing_records (id) VALUES (1) ON CONFLICT DO NOTHING;
