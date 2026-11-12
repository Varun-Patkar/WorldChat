# WorldChat — Specification v1 (Final Design)

> **Status:** Design Complete ✅ — Ready for implementation
> **Author:** Varun Anand Patkar
> **Date:** 2026-11-12
> **Last Updated:** 2026-11-12

---

## Vision

WorldChat is a web-based 3D world creation engine and editor. Imagine something like Unity but simpler, running in the browser. You create worlds by arranging objects, then either:
- **Play them as an interactive game** (with defined controls, agents, etc.) — all within the app itself, no file export needed
- **Animate cameras and render** for video mode

An intelligent agent works alongside you to help create, edit, and manage everything — but in v1 the focus is building a solid manual editor first. The agent integration comes later.

---

## Core Concepts

### Project Model

- A project lives in an **external folder on the user's machine** (chosen by the user during creation).
- Behaves much like VSCode workspaces — projects can be located **anywhere**, including outside the app directory.
- Running `start.sh` / `start.bat` launches the development server for that project.
- The app remembers the **last opened project** and offers to reopen it on launch.
- Projects can be created new or opened from existing folders.

### Architecture Principles

| Principle | Description |
|-----------|-------------|
| **Single project** | No monorepo. One monolithic Vite + React app. |
| **Local-first** | No server-side rendering. Everything runs in the browser. Users clone and run locally. |
| **Code over JSON** | Scene/game logic is stored as actual code files, not just JSON serialization. This enables the agent's "raw-dog" fallback (see below). |
| **R3F first, raw Three.js fallback** | Primary rendering via React Three Fiber + drei. When R3F declarative approach can't express something, the agent or developer writes raw Three.js code directly and hot-loads it. |

---

## Three-Panel Layout

```
┌──────────────┬──────────────────────┬─────────────────┐
│              │                      │                 │
│  Hierarchy   │     Scene View       │    Agent Panel  │
│  (Left)      │     (Center)         │   (Right,       │
│              │                      │    collapsible) │
├──────────────┴──────────────────────┴─────────────────┤
│                 Properties Panel                       │
│                     (Bottom, contextual)               │
└───────────────────────────────────────────────────────┘
```

| Panel | Purpose |
|-------|---------|
| **Hierarchy (Left)** | Tree of all scene objects (like Unity's Hierarchy). Shows the parent-child relationships. |
| **Scene View (Center)** | 3D viewport — the main canvas where you see and manipulate everything in real time. |
| **Agent Panel (Right)** | Reserved for future agent integration. Collapsible/expandable. |
| **Properties (Bottom)** | Contextual — opens when an object is selected. Shows editable properties (size, rotation, position, materials, etc.). |

---

## Features — v1 Manual Editor

### 1. Project Management

- **Create a new project:** User specifies the target folder path on their machine.
- **Open existing project:** Reads project files from a folder.
- **Last opened:** Remember last active project (localStorage / metadata file).
- **Project structure:** Each project folder contains:
  - `project.json` — project metadata, name, settings
  - `scene/` — scene object definitions (code files + JSON)
  - `assets/` — external assets (glb, gltf, textures)
  - `src/` — game logic / Three.js code files (for agent raw-dog mode)

### 2. Scene Object Hierarchy

- Visual tree of all objects in the scene.
- Clicking an item in hierarchy selects it in the 3D view.
- Supports nested groups/parents (like Unity's parent-child).
- Rename, delete, group, and re-parent objects.

### 3. Adding Objects to Scene

#### Primitive Shapes (Right-click context menu)
When you right-click anywhere in the hierarchy or scene, you can add:
- Cube / Box
- Sphere
- Cylinder / Cone
- Plane / Quad
- Torus
- Capsule

These are basic geometric primitives with default materials.

#### From File Import (Drag-and-Drop)
- **Drag-and-drop** `.glb`, `.gltf`, or any Three.js-compatible 3D file into the editor.
- System processes the file, parses the scene graph, and imports it into the hierarchy.
- A **pre-processing pipeline** normalizes materials, scales, and metadata before the object enters the scene (and before handing off to the agent).
- Assets stored in project's `assets/` folder for persistence.

### 4. Transform Tools (Unity-like)

Clicking an object activates Unity-style transform gizmos overlaid on the viewport:

| Tool | Hotkey | What it does |
|------|--------|-------------|
| **Move / Translate** | `W` | Move object along X, Y, Z axes |
| **Rotate** | `E` | Rotate object around axes |
| **Scale** | `R` | Scale object on axes (uniform or individual) |

Visual gizmos show axis-colored handles (Red=X, Green=Y, Blue=Z).
Uses `@react-three/drei` `TransformControls` for a Unity-identical experience with good performance.

### 5. Properties Panel

When an object is selected, the bottom panel shows its editable properties:

#### Transform
- Position (X, Y, Z) — numeric input + slider
- Rotation (X, Y, Z in degrees) — numeric input + slider
- Scale (X, Y, Z) — numeric input + slider

#### Visual
- Material / Color picker
- Opacity / Transparency
- Visible/Hidden toggle
- Wireframe toggle

#### For 3D models from file import
- Skins/materials if available
- Model name and source info
- LOD settings (planned)

### 6. In-App Modes (Not File Export)

The "export" concept in v1 is **not file export** — it's switching the editor into different modes that run inside the app itself:

#### Game / Play Mode
- User presses a **"Play"** button in the editor toolbar.
- Editor transitions to a **playable mode** where they can walk around their created world.
- Defines player controls (WASD, mouse look, etc.) — configurable before play.
- Camera switches from free orbit to FPS-style or configurable control scheme.
- Everything rendered in-browser — no build step needed.
- Press **"Esc"** or a dedicated stop button to return to edit mode.

#### Video / Animation Mode
- User defines **camera keyframes** (position, target/lookAt, duration).
- Editor plays back the animation sequence in real time.
- Renders frames locally using Three.js `WebGLRenderer` → frame capture for video export.
- No server-side processing — everything is browser-based.

---

## Tech Stack (Confirmed)

| Component | Technology |
|-----------|------------|
| Editor App | React + TypeScript — single project, monolithic Vite app |
| 3D Rendering | **React Three Fiber** + **@react-three/drei** |
| Transform Gizmos | `@react-three/drei` `TransformControls` (Unity-like) |
| State Management | **Zustand** |
| Dev Server / Starter | Shell script (`start.sh`) — runs Vite dev server |
| Project Format | JSON + code files for scene/game logic |
| UI Framework | Tailwind CSS + Radix UI primitives |
| Linter/Formatter | ESLint + Prettier |
| 3D Loader | `@react-three/drei` GLTFLoader for drag-and-drop import |

### Agent (Future — Post-v1)

- **Default API:** Ollama-compatible endpoint at `http://127.0.0.1:47831`
- **Swappable:** OpenAI Chat Completions API compatible endpoint
- **Tool system:** Agent creates/modifies objects via declarative R3F tool calls
- **Raw-dog fallback:** When declarative tools can't express something, agent writes raw Three.js code directly — engine hot-loads it into the running scene
- **Configurable:** User selects their preferred API endpoint in settings

---

## Project Structure (v1)

```
WorldChat/
├── docs/                       # Specifications, design docs
│   ├── Spec1.md                # This file — v1 specification
│   └── ...                     # Future design documents
├── src/                        # Editor source code
│   ├── components/
│   │   ├── editor/             # Core editor panels
│   │   │   ├── HierarchyPanel.tsx
│   │   │   ├── SceneViewport.tsx
│   │   │   ├── AgentPanel.tsx        (stub, future)
│   │   │   └── PropertiesPanel.tsx
│   │   ├── scene/              # 3D scene components
│   │   │   ├── primitives/     # Box, Sphere, Cylinder, etc.
│   │   │   ├── TransformGizmo.tsx
│   │   │   └── CameraControls.tsx
│   │   └── ui/                 # Shared UI components
│   ├── hooks/
│   │   ├── useProject.ts       # Project open/save lifecycle
│   │   ├── useSelection.ts     # Object selection tracking
│   │   └── useTransform.ts     # Move/rotate/scale logic
│   ├── stores/
│   │   ├── sceneStore.ts       # Zustand: scene objects, hierarchy tree
│   │   ├── selectionStore.ts   # Zustand: currently selected object
│   │   ├── projectStore.ts     # Zustand: current project state
│   │   └── transformStore.ts   # Zustand: active tool, gizmo state
│   ├── utils/
│   │   ├── sceneSerializer.ts  # Save/load scene as JSON + code
│   │   ├── modelImporter.ts    # Pre-process glb/gltf before import
│   │   └── fileDropHandler.ts  # Drag-and-drop file processing
│   ├── types/
│   │   ├── scene.types.ts      # Core type definitions
│   │   └── project.types.ts    # Project structure types
│   └── App.tsx                 # Main app layout
├── public/                     # Static assets
├── .gitignore
├── LICENSE
├── README.md
├── start.sh                    # Starter script to run editor dev server
├── package.json
├── vite.config.ts
├── tsconfig.json
└── index.html
```

---

## Roadmap

### Phase 1 — Foundation (Now)
- [x] Project scaffold and git setup
- [x] Specification document
- [ ] Editor with basic scene rendering (R3F + drei)
- [ ] Hierarchy panel + object selection
- [ ] Primitive shape creation (right-click menu)
- [ ] Transform gizmos (move, rotate, scale via drei)
- [ ] Properties panel with transform editing

### Phase 2 — Assets & Persistence
- [ ] Project save/load (scene serialization to JSON + code)
- [ ] Last-opened project tracking
- [ ] Drag-and-drop glb/gltf import with pre-processing pipeline
- [ ] Asset management in `assets/` folder
- [ ] Model metadata normalization

### Phase 3 — Play & Video Modes
- [ ] Game/play mode (WASD FPS, return to edit via Esc)
- [ ] Configurable player controls
- [ ] Camera keyframe editor for video mode
- [ ] In-app animation playback
- [ ] Frame capture for video export

### Phase 4 — Agent Integration (Post-v1)
- [ ] Ollama-compatible API integration (`http://127.0.0.1:47831` default)
- [ ] OpenAI Chat Completions API support (swappable config)
- [ ] Tool system for agent-driven scene creation
- [ ] Raw Three.js code hot-loading fallback
- [ ] Agent UI panel in right sidebar
- [ ] Natural language object manipulation

### Phase 5 — Polish & Advanced Features
- [ ] Advanced Materials: PBR materials, texture painting
- [ ] Physics Engine: Basic rigid-body physics for gameplay
- [ ] Multi-user Collaboration: Real-time editing
- [ ] Plugin System: Community assets and tools
- [ ] Mobile Support: Touch-based controls

---

## Design Decisions (Resolved)

All decisions documented in commit history. Key choices:
1. **Single project monolithic app** — not a monorepo
2. **R3F + drei** for all 3D, with raw Three.js fallback capability
3. **Zustand** for state management
4. **drei TransformControls** for Unity-identical gizmo experience
5. **Drag-and-drop file import** instead of Sketchfab URL fetch
6. **In-app play/video modes** — no file export, everything runs in-browser
7. **Local-first, no server** — clone and run locally
8. **Projects anywhere** on the filesystem — like VSCode workspaces
9. **Ollama at `127.0.0.1:47831`** as default agent API, swappable for OpenAI
