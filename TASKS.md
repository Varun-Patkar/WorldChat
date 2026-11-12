# WorldChat — Task Tracker

> **Last Updated:** 2026-11-12  
> **Current Phase:** Phase 1 — Foundation 🚧  
> **Done thinking today, implementation starts tomorrow**

---

## ✅ Completed

- [x] Git init and remote setup (Varun-Patkar/WorldChat)
- [x] MIT License (Varun Anand Patkar 2026)
- [x] README.md with overview and roadmap
- [x] docs/Spec1.md — full specification v1 (final design locked)
- [x] .gitignore, package.json, start.sh boilerplate
- [x] All clarifying questions answered and committed

---

## 🚧 Phase 1: Foundation (Do Tomorrow)

### S1.0 Project Setup (Vite + R3F + drei + Zustand)
- [ ] `npm create vite@latest . -- --template react-ts` (in existing project)
- [ ] Install dependencies: `react-three/fiber`, `three`, `@react-three/drei`, `zustand`, `tailwindcss`, `postcss`, `autoprefixer`
- [ ] Initialize Tailwind CSS config
- [ ] Verify Vite dev server starts and renders a blank R3F canvas

### S1.1 App Layout Shell (Three Panels + Properties)
- [ ] Create the 4-panel layout: left hierarchy, center scene, right agent (stub), bottom properties
- [ ] Tailwind CSS grid/flex layout for responsive panels
- [ ] Draggable panel resizers (at minimum, fixed widths for day 1)
- [ ] Collapsible right Agent panel

### S1.2 Zustand Stores
- [ ] `sceneStore.ts` — object tree (id, parentId, type, position, rotation, scale, name, ...), hierarchy methods
- [ ] `selectionStore.ts` — currently selected objectId, multi-select support
- [ ] `transformStore.ts` — active tool (move/rotate/scale/null), gizmo state
- [ ] `projectStore.ts` — current project folder path, dirty flag, last-opened tracking

### S1.3 Scene Viewport (Center)
- [ ] R3F Canvas with `OrbitControls` from drei
- [ ] Grid helper + ambient light setup
- [ ] Raycasting for object click-to-select
- [ ] Visual highlight on selected object (e.g., emissive tint or outline effect)

### S1.4 Hierarchy Panel (Left)
- [ ] Tree view component rendering the scene store hierarchy
- [ ] Click to select object in 3D view
- [ ] Show object names, expand/collapse children
- [ ] Right-click context menu on tree items and viewport → "Add Primitive" submenu

### S1.5 Primitives
- [ ] Context menu right-click: Box, Sphere, Cylinder, Cone, Plane, Torus, Capsule
- [ ] Each primitive renders in the 3D scene with default material
- [ ] New objects appear at a default position (cursor or center of viewport)
- [ ] New objects added to hierarchy tree and auto-selected

### S1.6 Transform Gizmos + Properties
- [ ] drei `TransformControls` appears when object is selected
- [ ] Hotkeys: W=Move, E=Rotate, R=Scale — switches gizmo mode in transformStore
- [ ] Properties panel (bottom) shows editable fields for selected object:
  - Position X/Y/Z
  - Rotation X/Y/Z (degrees)
  - Scale X/Y/Z
  - Material color picker
  - Visible toggle
- [ ] Property edits update the scene store → reflected in 3D view immediately

---

## 📋 Phase 2: Assets & Persistence

### S2.0 Scene Serialization
- [ ] Export scene state to `scene/` folder as JSON + generated code files
- [ ] Import scene from project folder on open
- [ ] Dirty detection (unsaved changes indicator)

### S2.1 Project Lifecycle
- [ ] "New Project" dialog → user picks folder path
- [ ] "Open Project" → reads existing project.json
- [ ] Last-opened project remembered in localStorage, offered on app start

### S2.2 File Import Pipeline
- [ ] Drag-and-drop zone for .glb/.gltf files
- [ ] Load via drei useGLTF or GLTFLoader
- [ ] Pre-processing: normalize scale, center bounding box, extract materials
- [ ] Import into scene store as new object(s)

---

## 📋 Phase 3: Play & Video Modes

### S3.0 Play Mode
- [ ] "Play" button in toolbar → enters play mode
- [ ] Camera switches to FPS-style with WASD + mouse look
- [ ] Configurable controls before play (WASD, arrow keys, etc.)
- [ ] "Esc" or Stop button → returns to edit mode

### S3.1 Video / Animation Mode
- [ ] Camera keyframe editor UI (timeline-like)
- [ ] Record camera position + target at timestamps
- [ ] Playback animation with smooth interpolation
- [ ] Frame capture for video export

---

## 🤖 Phase 4: Agent Integration (Post-v1)

### S4.0 API Layer
- [ ] Default Ollama endpoint (`http://127.0.0.1:47831`)
- [ ] Swappable OpenAI Chat Completions API config
- [ ] Settings panel for agent configuration

### S4.1 Tool System
- [ ] Agent tool calls for create object, move, rotate, scale, change material
- [ ] Tool definitions based on scene store actions
- [ ] Response parsing and execution

### S4.2 Raw Three.js Fallback
- [ ] Code file hot-loading system in `src/` directory
- [ ] Agent generates raw Three.js code when declarative tools insufficient
- [ ] Runtime eval or module import for injected code

---

## ❓ Open / To Discuss Later

- Exact UI framework for panel chrome (shadcn/ui? custom?)
- Camera orbit speed and controls configuration
- Whether to support multiple cameras in edit mode
- File format versioning for scene JSON/code
- Agent prompt system design
- Performance profiling targets (object count, draw calls)
