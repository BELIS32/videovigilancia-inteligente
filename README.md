# Sistema de Videovigilancia Inteligente

## H3 Tarea 3 — Uso de Git para herramientas de gestión

**Proyecto:** Sistema de Videovigilancia con Visión por Computadora y Aprendizaje Automático para detectar en tiempo real conductas sospechosas en comercios de El Alto.

**Estudiante:** Isabel Condori Caballero  
**Asignatura:** Proyecto Integrador II  
**Docente:** Ing. Juan Gabriel Lazcano Balanza  
**Lugar:** El Alto, Bolivia  
**Gestión:** 2026

## Objetivo del repositorio

Este repositorio contiene la estructura y los primeros artefactos de la Tarea 3. Se utiliza Git para gestionar versiones y organizar el modelo relacional y las sentencias SQL del sistema de videovigilancia.

## Flujo de ramas

```text
main
  └── develop
        └── feature/modelo-relacional
```

La rama `feature/modelo-relacional` contiene el trabajo específico de esta tarea y parte de `develop`.

## Estructura

```text
videovigilancia-inteligente/
├── README.md
├── database/
│   └── schema_videovigilancia.sql
├── docs/
│   └── CONDORICABALLEROISABEL-H3-T3.pdf
├── backend/
├── frontend/
└── .gitignore
```

## Modelo relacional

El modelo representa las entidades principales relacionadas con usuarios, locales, cámaras, eventos, alertas y evidencias. Las relaciones permiten registrar dónde se produjo un evento, qué cámara lo detectó, qué alerta se generó y qué usuario puede atenderla.

## Consultas SQL

El archivo `database/schema_videovigilancia.sql` contiene las sentencias `CREATE TABLE` y las consultas `SELECT` utilizadas en la actividad.
