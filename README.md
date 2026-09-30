# MappAzzone — videomapping essenziale

Un solo file (`index.html` + cartella `fonts/`), nessuna installazione, **100% offline** —
font inclusi in locale, nessun server, nessun CDN, nessun browser esterno:
l'app nativa in `/Applicazioni/MappAzzone.app` (sorgente in `src-macos/`,
ricompila con `src-macos/build.sh`) incorpora tutto e funziona da sola.
Ispirato a Resolume Arena (Advanced Output) + GLMixer / Veejay (open source).

## Uso in 4 passi
1. **Carica** — trascina video/immagini nel pannello Media, click per assegnarli alla slice.
2. **Mappa** — una slice per ogni superficie reale. Trascina i 4 angoli sui bordi veri,
   il centro per spostare, frecce per la precisione, `Alt`+trascina per lo snap.
3. **Tempi** — timeline `004./`: trascina i blocchi per i tempi di apparizione,
   regola inizio/durata/dissolvenze dal pannello slice, `Spazio` per provare.
4. **Proietta** — PROIETTA → fullscreen sul proiettore. `ESC` esce, `B` blackout.

## Scorciatoie (stile Premiere — legenda completa con `?` o ⌨)
Navigazione: `Spazio`/`K` play, `J`/`L` navetta 1×2×4×8×, `,`/`.` e `←→` un
fotogramma, `↑↓` punti di montaggio, `Home`/`End`, `M` marker.
Editing: `C` lama + click, `B` lama alla testina, `Q`/`W` trim alla testina,
`S` magnete, `+`/`-`/`\` zoom, `Tab` slice.
Clip: `⌘Z` annulla, `⌘X`/`⌘C`/`⌘V` taglia/copia/incolla, `⌘D` duplica,
`Canc` elimina, `E`/`⌘S` salva, `⌘O` apri.
Mapping: `Alt`+frecce sposta slice, `G` griglia, `I` immagine, `F` proietta. Ogni slice ha inizio, durata, dissolvenza in/out. Trascina
i blocchi (bordi = inizio/durata). I video partono solo mentre la slice è
visibile. Click su un media per modificarlo: nome, velocità, loop ⟳/1× —
le regolazioni si salvano e si riapplicano ricaricando gli stessi file.

## Contenuti avanzati
Ogni slice accetta **più clip sovrapposte** (livelli con opacità e fusioni:
screen, multiply, overlay…), trasformazioni **X/Y/Z/rotazione**, adattamento
**riempi/adatta/stira** e file **SVG**. `Canc` elimina la slice selezionata.

## Controllo effetti + keyframe (stile Premiere)
Pannello a sinistra: Posizione X/Y, Scala, Rotazione, Opacità con cronometro ◷,
diamanti ◆ sulla timeline, navigazione ‹ ›, interpolazione lineare. Con ◷
attivo, ogni modifica scrive un keyframe alla testina. Alt+click sui diamanti
li toglie. Tutto undoabile e salvato nel `.json`.

## Cos'è rimasto (solo essenziale)
Media library · slice quad con corner-pinning · preset tutto-schermo/2×2/2-affiancate ·
pattern test per fuoco e allineamento · opacità e on/off per slice ·
salva/carica mapping `.json` (i video si riassociano per nome file) ·
blackout · tasti 1-9 per selezionare le slice.

## Griglia di controllo
Pulsante **griglia** o tasto `G`: mostra il riferimento globale (terzi + centro
evidenziati) e, su ogni slice, la **maglia deformata** che segue la prospettiva —
così vedi subito se un angolo è fuori posto. Tenendo `Alt` mentre trascini un
angolo, lo **snap** lo aggancia alle linee della griglia (ora più contrastata
anche sul fondo nero). Con l'opzione **immagine** (checkbox nel pannello slice
o tasto `I`) nascondi il contenuto e lavori sul solo bordo — utile per
allineare al buio.

## Annulla / ripeti
`⌘Z` annulla, `⇧⌘Z` ripete (su Windows `Ctrl+Z` / `Ctrl+Shift+Z`).
Vale per: trascinamenti, frecce, aggiunta/eliminazione slice, preset, opacità,
media assegnati, interruttori e rinomini.

Niente mixer, niente effetti, niente BPM/MIDI: solo mapping.
