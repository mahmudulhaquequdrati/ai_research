---
name: Video Production Workflow
description: 100% AI video pipeline — edge-tts + SadTalker + Pillow/MoviePy. Zero cost except Claude Code. 2-3 min videos.
type: project
---

Video production is fully automated with zero external costs. No paid APIs, no human editors.

**Target**: 2-3 minute YouTube videos, Ali Abdaal-inspired style (adapted for AI-generated).
**Cost**: $0 per video (only Claude Code subscription).

**Stack (all free/open-source)**:
- Voice: edge-tts (free Microsoft TTS)
- Avatar: SadTalker (open-source talking head from image + audio)
- Graphics: Pillow (title cards, step indicators, stat callouts, bullet lists)
- Composition: MoviePy + FFmpeg (PIP overlay, transitions, captions)
- Script: Claude Code (video-producer agent)

**Pipeline**: `video-engine/generate.py --script script.json`
1. Load script.json (scenes with type, narration, visual data)
2. Generate voice for all scenes (edge-tts)
3. Generate graphics for visual scenes (Pillow)
4. Generate avatar talking head for face scenes (SadTalker, optional)
5. Compose into final .mp4 with PIP, transitions, captions

**Scene types**: intro, outro, avatar, transition (face on camera), title, step, stat, list, content (graphics with voice)

**Why:** User wants zero cost besides Claude Code. No HeyGen, no ElevenLabs, no human editors. Fully autonomous pipeline.

**How to apply:** When user says "create a video," write the script.json, then run the pipeline. Use `/social-repurpose` after for social content.
