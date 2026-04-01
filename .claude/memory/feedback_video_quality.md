---
name: Video Quality Feedback
description: User wants fully AI-generated videos at zero cost. Previous text-only pipeline was too basic — new pipeline adds avatar + better graphics.
type: feedback
---

The old video pipeline (edge-tts + plain Pillow text + MoviePy) was not good enough quality. User wants Ali Abdaal-level production but fully AI-generated with zero paid APIs.

**Solution built:** New pipeline adds SadTalker (AI avatar talking head), branded graphics (title cards, step indicators, stat callouts), PIP overlay, and caption burn-in. Quality is "good for 2-3 min YouTube videos" not "indistinguishable from human."

**Why:** User explicitly said they don't want to pay for anything except Claude Code. No HeyGen ($), no ElevenLabs ($), no human editors ($500/vid). The entire video must be generated from code.

**How to apply:** Always use the new video-engine pipeline with avatar support. Keep videos to 2-3 minutes. Focus on good scripts and visual variety (mix avatar scenes with graphic scenes for pattern interrupts).
