---
name: Video Content Pipeline
description: Rebuilt video-engine pipeline — edge-tts + SadTalker + Pillow + MoviePy. Generates 2-3 min .mp4 from script.json. Zero cost.
type: project
---

## Video Engine Pipeline v2 (Rebuilt 2026-03-28)

The `video-engine/` directory has a fully free Python pipeline for generating YouTube videos.

**Stack:** edge-tts (voice) + SadTalker (avatar) + Pillow (graphics) + MoviePy (composition)
**Zero API costs** — everything runs locally.

**Structure:**
```
video-engine/
  generate.py          — Main pipeline orchestrator
  config.py            — All settings (resolution, colors, fonts, PIP)
  requirements.txt     — Python dependencies
  core/
    voice.py           — edge-tts voice generation
    avatar.py          — SadTalker talking head generation
    graphics.py        — Pillow scene graphics (titles, steps, stats, lists)
    compositor.py      — MoviePy video assembly with PIP, transitions, captions
  assets/avatar/       — Source face image for SadTalker
  templates/           — Sample script.json files
  output/              — Generated videos
```

**Usage:** `python generate.py --script script.json [--no-avatar] [--no-captions]`

**Target duration:** 2-3 minutes per video.

**Why:** Content marketing for AI Skills. Zero cost per video — only Claude Code subscription needed.

**How to apply:** Write script.json (or generate with video-producer agent), run pipeline, then `/social-repurpose` for social content.
