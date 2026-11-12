# WorldChat

A web-based 3D world creation engine and editor — like Unity, but in the browser. Create worlds by arranging objects, then play them as interactive games or record animations as videos. All runs locally in your browser.

> **v1 Status:** Design complete ✅ — Ready to start building tomorrow.  
> An intelligent agent will work alongside you (Ollama-compatible API default, OpenAI Chat Completions swappable). Agent integration is post-v1; v1 focuses on the manual editor.

---

## Quick Start

```bash
# Clone the repo
git clone https://github.com/Varun-Patkar/WorldChat.git
cd WorldChat

# Create a new project and start the editor
./start.sh
```

See [docs/Spec1.md](docs/Spec1.md) for the full specification and roadmap.

---

## Features (v1 Planned)

### Project Management
- **Single monolithic app** — Vite + React + TypeScript, no monorepo
- Create projects in any local folder (like VSCode workspaces)
- Auto-save last opened project
- Simple `start.sh` / `start.bat` to launch dev server

### 3D Editor (Three Panels + Properties)
| Panel | Location | Purpose |
|-------|----------|---------|
| Hierarchy | Left | Tree of all scene objects, parent-child relationships |
| Scene View | Center | 3D viewport with orbit/pan/zoom |
| Agent Panel | Right (collapsible) | Reserved for future agent integration |
| Properties | Bottom | Contextual — editable properties when object selected |

### Object Creation
- **Right-click primitives:** Box, Sphere, Cylinder, Cone, Plane, Torus, Capsule
- **Drag-and-drop import:** `.glb`, `.gltf` files with pre-processing pipeline (normalizes materials, scales, metadata)

### Transform Tools (Unity-like via drei)
| Tool | Hotkey | What it does |
|------|--------|-------------|
| **Move** | `W` | Translate on X/Y/Z axes |
| **Rotate** | `E` | Rotate around axes |
| **Scale** | `R` | Scale uniformly or per-axis |

### In-App Modes (No File Export)

#### Game / Play Mode
- Press **"Play"** to walk around your created world in FPS-style controls
- Configurable WASD + mouse look before play
- Press **Esc** to return to edit mode

#### Video / Animation Mode
- Define camera keyframes (position, target, duration)
- Play back animations in real time
- Frame capture for video export — all browser-based, no server

---

## Tech Stack

| Layer | Technology |
|-------|-----------|
| Frontend | React + TypeScript (Vite) |
| 3D Engine | React Three Fiber + drei |
| State | Zustand |
| Styling | Tailwind CSS |
| Dev Server | Vite |
| Project Format | JSON + code files |

### Agent (Post-v1)
- **Default:** Ollama-compatible `http://127.0.0.1:47831`
- **Swappable:** OpenAI Chat Completions API
- Tools → Declarative R3F calls with raw Three.js code fallback

---

## Project Structure (v1)

```
WorldChat/
├── docs/
│   └── Spec1.md              # Full specification + roadmap
├── src/
│   ├── components/
│   │   ├── editor/           # Hierarchy, SceneViewport, Properties panels
│   │   ├── scene/            # Primitives, TransformGizmo, CameraControls
│   │   └── ui/               # Shared UI components
│   ├── hooks/                # useProject, useSelection, useTransform
│   ├── stores/               # Zustand stores (scene, selection, project)
│   ├── utils/                # Serializer, model importer, file drop handler
│   ├── types/                # TypeScript type definitions
│   └── App.tsx               # Main layout
├── LICENSE
├── README.md
├── start.sh                  # Dev server starter script
├── package.json
├── vite.config.ts
└── tsconfig.json
```

---

## Roadmap

### Phase 1 — Foundation (Now) 🚧
- [x] Project scaffold and git setup
- [x] Specification document (this design)
- [ ] Editor with basic R3F scene rendering
- [ ] Hierarchy panel + object selection
- [ ] Primitive shape creation via right-click
- [ ] Transform gizmos (W/E/R) using drei

### Phase 2 — Assets & Persistence
- [ ] Scene serialization (JSON + code files)
- [ ] Last-opened project tracking
- [ ] Drag-and-drop glb/gltf import pipeline
- [ ] Asset management in `assets/` folder

### Phase 3 — Play & Video Modes
- [ ] Game mode (WASD FPS controls, Esc to return)
- [ ] Camera keyframe editor
- [ ] Animation playback and frame capture

### Phase 4 — Agent Integration (Post-v1) 🤖
- [ ] Ollama/OpenAI Chat Completions API integration
- [ ] Tool system for scene manipulation
- [ ] Raw Three.js code hot-loading fallback
- [ ] Agent UI panel

---

## License

MIT License — see [LICENSE](./LICENSE) file.  
© 2026 Varun Anand Patkar. All rights reserved.
