-- H3 Tarea 3 - Modelo relacional
-- Sistema de videovigilancia inteligente - El Alto

CREATE TABLE usuario (
    id_usuario SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    usuario VARCHAR(50) UNIQUE NOT NULL,
    contrasena VARCHAR(255) NOT NULL,
    rol VARCHAR(30) NOT NULL
);

CREATE TABLE local (
    id_local SERIAL PRIMARY KEY,
    nombre VARCHAR(120) NOT NULL,
    direccion VARCHAR(200),
    ciudad VARCHAR(80) NOT NULL DEFAULT 'El Alto'
);

CREATE TABLE camara (
    id_camara SERIAL PRIMARY KEY,
    id_local INTEGER NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    direccion_ip VARCHAR(45),
    puerto INTEGER,
    url_rtsp VARCHAR(255) NOT NULL,
    estado VARCHAR(20) NOT NULL DEFAULT 'ACTIVA',
    CONSTRAINT fk_camara_local
        FOREIGN KEY (id_local) REFERENCES local(id_local)
);

CREATE TABLE evento (
    id_evento SERIAL PRIMARY KEY,
    id_camara INTEGER NOT NULL,
    fecha_hora TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    tipo_conducta VARCHAR(50) NOT NULL,
    nivel_confianza DECIMAL(5,2),
    tiempo_permanencia DECIMAL(10,2),
    distancia_recorrida DECIMAL(10,2),
    estado VARCHAR(20) NOT NULL DEFAULT 'DETECTADO',
    CONSTRAINT fk_evento_camara
        FOREIGN KEY (id_camara) REFERENCES camara(id_camara)
);

CREATE TABLE alerta (
    id_alerta SERIAL PRIMARY KEY,
    id_evento INTEGER NOT NULL,
    id_usuario INTEGER,
    fecha_hora TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    tipo VARCHAR(30) NOT NULL DEFAULT 'VISUAL',
    estado VARCHAR(20) NOT NULL DEFAULT 'PENDIENTE',
    observacion VARCHAR(255),
    CONSTRAINT fk_alerta_evento
        FOREIGN KEY (id_evento) REFERENCES evento(id_evento),
    CONSTRAINT fk_alerta_usuario
        FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);

CREATE TABLE evidencia (
    id_evidencia SERIAL PRIMARY KEY,
    id_evento INTEGER NOT NULL,
    ruta_archivo VARCHAR(255) NOT NULL,
    tipo_archivo VARCHAR(20) NOT NULL,
    fecha_hora TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_evidencia_evento
        FOREIGN KEY (id_evento) REFERENCES evento(id_evento)
);

-- SELECT 1: consultar las conductas sospechosas detectadas
-- junto con la cámara y el local donde ocurrieron.
SELECT
    e.id_evento,
    e.fecha_hora,
    e.tipo_conducta,
    e.nivel_confianza,
    c.nombre AS camara,
    l.nombre AS local
FROM evento e
INNER JOIN camara c ON e.id_camara = c.id_camara
INNER JOIN local l ON c.id_local = l.id_local
WHERE e.tipo_conducta = 'SOSPECHOSA'
ORDER BY e.fecha_hora DESC;

-- SELECT 2: consultar las alertas pendientes que deben ser atendidas
-- por el usuario, mostrando la conducta detectada.
SELECT
    a.id_alerta,
    a.fecha_hora,
    a.estado AS estado_alerta,
    u.nombre AS usuario,
    e.tipo_conducta,
    e.nivel_confianza
FROM alerta a
INNER JOIN evento e ON a.id_evento = e.id_evento
LEFT JOIN usuario u ON a.id_usuario = u.id_usuario
WHERE a.estado = 'PENDIENTE'
ORDER BY a.fecha_hora DESC;
