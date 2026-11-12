# WorldChat

A web-based 3D world creation engine and editor — like Unity, but in the browser. Create worlds by arranging objects, then play them as interactive games or export them as animated videos. An intelligent agent works alongside you to help create, edit, and manage everything.

> **v1 Status:** Planning phase. This project is being scaffolded now with manual editor focus first, agent integration to follow.

---

## Quick Start

```bash
# Clone the repo
git clone https://github.com/Varun-Patkar/WorldChat.git
cd WorldChat

# Create a new project and start the editor
./start.sh
```

See the [full specification](docs/Spec1.md) for planned features and architecture.

---

## Features (v1 Planned)

### Project Management
- Create projects in any local folder
- Auto-save last opened project
- Simple `start.sh` / `start.bat` to launch dev server

### 3D Editor
- **Left panel:** Hierarchy tree of all scene objects
- **Center panel:** Interactive 3D viewport with orbit/pan/zoom
- **Right panel:** Agent panel (reserved for future)
- **Bottom panel:** Contextual properties editor

### Object Creation
- Right-click to add primitives: Box, Sphere, Cylinder, Cone, Plane, Torus, Capsule
- Import 3D models from Sketchfab or any glTF/GLB URL

### Transform Tools (Unity-like)
- **Move** (`W`) — translate on X/Y/Z axes
- **Rotate** (`E`) — rotate around axes  
- **Scale** (`R`) — scale uniformly or per-axis

### Export Modes
- **Game/Playable:** Define player controls, generate playable build
- **Video:** Keyframe camera animations, export as rendered video

---

## Tech Stack

| Layer | Technology |
|-------|-----------|
| Frontend | React + TypeScript |
| 3D Engine | React Three Fiber + drei |
| State | Zustand |
| Styling | Tailwind CSS |
| Dev Server | Vite |
| Project Format | JSON |

---

## Project Structure (Planned)

```
WorldChat/
├── docs/                 # Specifications, design docs
│   └── Spec1.md          # v1 specification
├── packages/             # Monorepo-style workspaces
│   ├── editor/           # Main 3D editor application
│   │   ├── src/
│   │   │   ├── components/
│   │   │   ├── hooks/
│   │   │   ├── stores/       # Zustand stores
│   │   │   └── utils/        # Scene serialization, imports
│   │   └── ...
│   └── core/             # Shared types, constants
├── .gitignore
├── LICENSE
├── README.md
└── start.sh              # Starter script to run editor dev server
```

---

## Roadmap

### Phase 1 — Foundation (Now)
- [x] Project scaffold and git setup
- [x] Specification document
- [ ] Editor with basic scene rendering
- [ ] Hierarchy panel + object selection
- [ ] Primitive shape creation (right-click menu)
- [ ] Transform gizmos (move, rotate, scale)

### Phase 2 — Assets & Persistence
- [ ] Properties panel with transform editing
- [ ] Project save/load (JSON scene serialization)
- [ ] Last-opened project tracking
- [ ] Sketchfab / URL model import
- [ ] Asset management system

### Phase 3 — Export
- [ ] Game/playable mode export
- [ ] Video mode with camera keyframes
- [ ] Build pipeline for exports

### Phase 4 — Agent Integration (Post-v1)
- [ ] Natural language object creation
- [ ] AI-assisted scene editing
- [ ] Agent control panel UI
- [ ] Workflow automation

---

## License

MIT License — see [LICENSE](./LICENSE) file.  
© 2026 Varun Anand Patkar. All rights reserved.
