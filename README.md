# Cartelera · Work & Fun '26 · HP Argentina

Cartelera electrónica (digital signage) con la marca HP. Corre en loop en una pantalla/TV
desde un pendrive, sin instalar nada.

## Cómo ponerla en la pantalla

### Opción A — Modo kiosko (recomendado, arranca solo a pantalla completa)
1. Copiá **toda esta carpeta** (`cartelera-work-fun`) al pendrive.
2. Enchufá el pendrive en la PC de la pantalla.
3. Doble clic en **`Iniciar-cartelera.bat`**.
   - Abre la cartelera a pantalla completa, sin barras del navegador, en loop.
   - Para **salir**: `Alt + F4`.

### Opción B — Manual
1. Doble clic en `index.html` (abre en el navegador).
2. Pantalla completa: tecla **F** o **F11**.

## ¿El clima necesita internet?
El pendrive NO da internet: lo que importa es si **la PC/TV donde lo enchufás tiene internet**.
- **Con internet** → el clima de Buenos Aires se actualiza solo, en vivo, cada 15 min
  (usa Open-Meteo, gratis y sin clave). No hay que configurar nada.
- **Sin internet** → la slide del clima se **saltea sola** y la cartelera sigue funcionando
  con el resto. No muestra error ni datos viejos.

## Controles (opcionales)
- **← / →** : slide anterior / siguiente
- **barra espaciadora** : pausar / reanudar
- **F** : pantalla completa
- El mouse se oculta solo; se ve al moverlo.

## Cómo cambiar el contenido
Abrí `index.html` con el Bloc de notas y editá **solo** el bloque `const SLIDES = [ ... ]`
(arriba del `<script>`). Cada slide es un objeto. Tipos disponibles:

- `cover`     portada del equipo
- `agenda`    horarios — items `{when, what, where}`
- `anuncios`  avisos con ícono — items `{icon, title, desc}`
- `clima`     clima de Buenos Aires en vivo (solo aparece si hay internet)
- `cumples`   cumpleaños del mes — items `{date:"MM-DD", name}` (muestra solo los del mes actual)
- `countdown` cuenta regresiva — `target: "2026-12-19T19:00:00"`
- `foto`      foto a pantalla completa — `{src, title, caption}`
- `quote`     frase destacada — `{text, by}`
- `info`      título + texto libre — `{eyebrow, title, body}`

`secs` = segundos que dura cada slide (por defecto 10).

### Para agregar fotos del equipo
1. Copiá las imágenes a la carpeta `assets/` (ej. `assets/equipo-1.jpg`).
2. En `SLIDES` agregá: `{ type:"foto", src:"assets/equipo-1.jpg", title:"...", caption:"...", secs:9 }`.

### Cumpleaños
Cargá todos los del año en la slide `cumples`; la cartelera muestra automáticamente
solo los del mes en curso. Formato de fecha: `"MM-DD"` (mes-día), ej. `"08-15"` = 15 de agosto.
