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
- `fotoCarrusel` álbum de fotos de un evento — `{items:[{src, title, caption}]}`
- `quote`     frase destacada — `{text, by}`
- `info`      título + texto libre — `{eyebrow, title, body}`

`secs` = segundos que dura cada slide (por defecto 10).

### Para agregar fotos del equipo
1. Copiá las imágenes a la carpeta `assets/` (ej. `assets/equipo-1.jpg`).
2. En `SLIDES` agregá: `{ type:"foto", src:"assets/equipo-1.jpg", title:"...", caption:"...", secs:9 }`.

Desde el Back Office también podés abrir `Fotos`, completar opcionalmente el título del
evento y usar `Seleccionar hasta 10` para cargar un carrusel. Las fotos seleccionadas
quedan agrupadas y pasan automáticamente dentro de una misma slide.

### Videos de eventos
En el Back Office, abrí **Fotos y videos**, elegí **+ Agregar** y **Subir**.
Seleccioná un MP4 H.264 de hasta **15 MB y 10 minutos**, completá opcionalmente el
título y guardá con **Guardar y publicar**. Los videos no pasan por el recortador.
Se muestran completos, sin sonido y sin deformarse; al terminar siguen las otras
slides. El tiempo por foto no acorta los videos. La barra espaciadora también pausa
y reanuda el video; las flechas permiten saltearlo.

Para una pieza que ya contiene sus propios textos, dejá el título y el epígrafe
vacíos. Formato recomendado: **1918 × 643 (3:1)**; H.264 4:2:0 con una fila de borde
(1918 × 644) ofrece mayor compatibilidad con TVs.

Los MP4 subidos se guardan en la misma carpeta de Drive de las fotos. Se descargan
al reproductor mediante el Back Office o la descarga directa de Drive, según el
navegador. Se necesita internet para cargarlos. También se acepta una URL directa
a un MP4, seleccionando **Video** (no enlaces de YouTube ni páginas de Drive).
Si un archivo no carga en 45 segundos o no se puede reproducir, se informa en pantalla
y se continúa con la siguiente slide. Los videos no se agrupan en el carrusel de fotos.

Cada video tiene la opción **Repetir en loop**, desactivada por defecto. Al activarla,
se repite durante el **Tiempo en pantalla** indicado (30 segundos por defecto,
hasta 600 segundos) y después continúa la cartelera. Con **0 segundos** se repite
sin límite: se avanza manualmente con las flechas. La barra espaciadora pausa y
reanuda tanto el video como su tiempo en pantalla. Sin loop se reproduce una vez
completa, igual que antes. Las columnas `loop` y `loop_seconds` se guardan al final
de Fotos; las filas existentes siguen sin repetición.

El próximo video se precarga en segundo plano mientras se muestra el contenido
anterior. Si todavía no está listo al llegar su turno, ese contenido permanece
visible hasta que el video pueda reproducirse; ya no aparece “Cargando video”.
Los videos preparados se reutilizan durante el ciclo. En el arranque inicial,
si el primer contenido es un video, todavía se necesita la primera descarga.

Para LG/webOS y NetCast, los videos de Drive se cargan primero desde la URL
de descarga directa del MP4, con precarga del reproductor nativo. Si esa fuente
se rechaza, se prueba el MP4 en base64, evitando las URL `blob:`. Los demás navegadores
mantienen Blob y prueban la alternativa una sola vez si la fuente se rechaza.
La precarga, el loop y los límites de duración se mantienen. Es necesario validar
la reproducción en el modelo real de TV; esta adaptación no cambia el códec.

Para activar esta función hay que publicar juntos `index.html` y `version.txt`
en ambos repositorios y actualizar la implementación de Apps Script con
`backoffice/Admin.html` y `backoffice/Codigo.js`. Las columnas `type` y `duration`
se agregan al final de Fotos en el siguiente guardado; las fotos existentes se conservan.

### Cumpleaños
Cargá todos los del año en la slide `cumples`; la cartelera muestra automáticamente
solo los del mes en curso. Formato de fecha: `"MM-DD"` (mes-día), ej. `"08-15"` = 15 de agosto.
