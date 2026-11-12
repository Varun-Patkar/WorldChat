# WorldChat — Specification v1 (Planning)

> **Status:** Planning / Design Phase
> **Author:** Varun Anand Patkar
> **Date:** 2026-11-12

---

## Vision

WorldChat is a web-based 3D world creation engine and editor. Imagine something like Unity but simpler, running in the browser. You create worlds by arranging objects, then either:
- **Play them as an interactive game** (with defined controls, agents, etc.)
- **Export them as animated video** (camera keyframes, renders)

An intelligent agent works alongside you to help create, edit, and manage everything — but in v1 the focus is building a solid manual editor first. The agent integration comes later.

---

## Core Concepts

### Project Model

- A project lives in an **external folder** (chosen by the user during creation).
- Running `start.sh` / `start.bat` launches the development server for that project.
- The app remembers the **last opened project** and offers to reopen it on launch.
- Projects can be created new or opened from existing folders.

### Three-Panel Layout

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

- **Create a new project:** User specifies the target folder path.
- **Open existing project:** Reads project files from a folder.
- **Last opened:** Remember last active project (localStorage / metadata file).
- **Project structure:** Each project folder contains:
  - `project.json` — project metadata, name, settings
  - `scene/` — scene object definitions (JSON or whatever format)
  - `assets/` — external assets downloaded from Sketchfab / URLs
  - `dist/` — compiled output for export/play mode

### 2. Scene Object Hierarchy

- Visual tree of all objects in the scene.
- Clicking an item in hierarchy selects it in the 3D view.
- Supports nested groups/parents (like Unity's parent-child).

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

#### From Sketchfab / URL
- User provides a URL (Sketchfab model or any glTF/GLB/GLTF source).
- System fetches and loads the model into the scene.
- Model appears in the hierarchy as a new object.
- Assets downloaded to `assets/` folder for persistence.

### 4. Transform Tools (Unity-like)

Clicking an object activates transform gizmos at the bottom or overlaid on the viewport:

| Tool | Hotkey | What it does |
|------|--------|-------------|
| **Move / Translate** | `W` | Move object along X, Y, Z axes |
| **Rotate** | `E` | Rotate object around axes |
| **Scale** | `R` | Scale object on axes (uniform or individual) |

Visual gizmos show axis-colored handles (Red=X, Green=Y, Blue=Z).

### 5. Properties Panel

When an object is selected, the bottom panel shows its editable properties:

#### Transform
- Position (X, Y, Z)
- Rotation (X, Y, Z or quaternion)
- Scale (X, Y, Z)

#### Visual
- Material / Color
- Opacity
- Visible/Hidden toggle

#### For 3D models from Sketchfab
- Skins/materials if available
- LOD settings

### 6. Export Options

Two export modes:

#### Game / Playable Mode
- Defines player controls (WASD, mouse, etc.)
- Generates a playable build
- Camera system with basic FPS or orbit controls
- Physics could be planned for later v1 iterations

#### Video Mode
- Camera animation via keyframes
- Define camera path, zoom, focus targets
- Export as rendered video

---

## Tech Stack (Planned)

| Component | Technology |
|-----------|-----------|
| Editor App | React + TypeScript |
| 3D Rendering | React Three Fiber (@react-three/fiber) or raw Three.js |
| Transform Gizmos | `@react-three/drei` (transforms, orbit controls, etc.) |
| State Management | Zustand (lightweight, works great with R3F) |
| Dev Server / Starter | Shell script (`start.sh`) — runs Vite dev server |
| Project Format | JSON-based scene serialization |
| UI Framework | Tailwind CSS + Radix UI primitives (or similar) |
| Linter/Formatter | ESLint + Prettier |

---

## Future Extensions (Post-v1)

- **Agent Integration:** AI agent that can create objects, modify properties, animate cameras — all via natural language.
- **Advanced Materials:** PBR materials, texture painting.
- **Physics Engine:** Basic rigid-body physics for gameplay.
- **Multi-user Collaboration:** Real-time editing with others.
- **Plugin System:** Allow community-created assets and tools.
- **Mobile Support:** Touch-based controls.

---

## Design Decisions Needed (Pending)

See the Clarifying Questions section below for items still to be resolved.
