---
name: video-pipeline
description: End-to-end video content production workflow. From idea to published video + social clips + companion content. Use when producing any video content.
argument-hint: "[video-topic-or-idea]"
user-invocable: true
allowed-tools: Read, Grep, Glob, Write, Edit, Bash, Agent, WebSearch, WebFetch
model: sonnet
effort: high
---

# Video Pipeline Skill

Produce video content for: `$ARGUMENTS`

## Pipeline Overview

```
IDEA → RESEARCH → SCRIPT → SHOOT → EDIT → PUBLISH → REPURPOSE
  │        │         │        │       │        │          │
  ▼        ▼         ▼        ▼       ▼        ▼          ▼
 Hook   Trending   Full    Shot    FFmpeg   YouTube    Shorts
 Angle  Analysis  Script   List   Pipeline  Upload    LinkedIn
         + SEO   + Story  + Setup  + Caps   + SEO      Twitter
                  board              + GFX   + Thumb    Blog
```

## Phase 1: Research & Concept (researcher agent)

1. **Topic Validation**
   - Search YouTube for similar videos — what exists? What's missing?
   - Check Google Trends for search volume
   - Analyze top 3 competing videos: views, engagement, comments
   - Identify the unique angle AI Skills can own

2. **SEO Research**
   - Target keyword + 3-5 related keywords
   - Suggested title options (< 60 chars, keyword-front-loaded)
   - Description template with timestamps
   - Tag list (15-20 relevant tags)

3. **Output**: `research-brief.md`

## Phase 2: Script & Storyboard (video-producer agent)

1. **Script Structure**
   ```
   HOOK (0-15s): Bold claim or surprising result
   PROBLEM (15s-1m): Relatable pain point
   SOLUTION PREVIEW (1-2m): Show end result first
   WALKTHROUGH (2-12m): Step-by-step with pattern interrupts
   RESULTS (12-14m): Proof and data
   CTA (14-15m): Subscribe + next video tease
   ```

2. **Shot List** — Every shot planned with type, duration, overlays

3. **Output**: `script.md` + `shot-list.yaml` + `storyboard-brief.md`

## Phase 3: Production (manual — human films)

Provide the creator with:
- [ ] Camera setup instructions (angle, lighting, background)
- [ ] Screen recording list (which screens to capture, in order)
- [ ] Talking points per section (if not reading script)
- [ ] B-roll shot list
- [ ] Audio checklist (mic check, room tone, music selection)

**Output**: `production-checklist.md`

## Phase 4: Post-Production (video-editor agent)

1. **Raw Processing**
   ```bash
   # Normalize all footage to 1080p, consistent color
   video-edit-pipeline.sh ./project-dir educational
   ```

2. **Assembly** — Follow the EDL (Editing Decision List)
   - Arrange clips per shot list
   - Add transitions (cuts, zooms, slides)
   - Layer picture-in-picture for screen + webcam
   - Insert pattern interrupts (graphics, stat callouts)

3. **Polish**
   - Color grade all clips consistently
   - Add lower thirds and text overlays
   - Normalize audio levels (-14 LUFS speech, -18 LUFS music)
   - Generate and burn-in captions (Whisper → SRT → styled burn-in)

4. **Export**
   - Main video: H.264, 1080p, 30fps
   - Thumbnail: 1280x720 PNG
   - Caption file: .srt

5. **Output**: `output/final.mp4` + `output/thumbnail.png` + `output/captions.srt`

## Phase 5: Publishing (social-media-manager agent)

1. **YouTube Upload Prep**
   - Title (SEO-optimized)
   - Description (with timestamps, links, keywords)
   - Tags (15-20)
   - Thumbnail
   - End screen configuration
   - Cards/info cards at key moments
   - Playlist assignment

2. **Output**: `youtube-metadata.yaml`

## Phase 6: Repurpose (content-creator + social-media-manager)

1. **Short-Form Clips** (3-5 per video)
   - Extract best 30-60s moments
   - Reformat to 9:16 vertical
   - Add captions (large, centered)
   - Platform-specific: YouTube Shorts, Instagram Reels, TikTok, LinkedIn

2. **Written Content**
   - LinkedIn post (text summary of key insight)
   - Twitter/X thread (key takeaways)
   - Blog post (tutorial version with screenshots)
   - Email newsletter snippet
   - Instagram carousel (key steps as slides)

3. **Output**: `repurpose/` directory with all assets

## Automation Opportunities

### What Can Be Fully Automated
- Raw footage normalization (FFmpeg pipeline)
- Caption generation (Whisper AI)
- Caption burn-in and styling
- Color grading (preset-based)
- Short-form clip extraction (with timestamp input)
- Vertical reformatting (9:16 crop)
- YouTube metadata generation
- Social post drafting from script
- Thumbnail template application

### What Needs Human Input
- Filming (camera + screen recording)
- Creative direction decisions
- Final cut approval
- Thumbnail face photo selection
- Music selection and licensing
- Platform upload (until API access configured)

### What AI Can Assist With
- Script writing (90% automated, human review)
- Shot list generation (automated from script)
- Editing decisions (AI suggests, human approves)
- Trend research and topic selection
- SEO optimization

## Quick Start

To produce a video, run:
```
/video-pipeline "How to Build an AI Agent That Posts to LinkedIn"
```

This will:
1. Generate research brief
2. Write full script with shot list
3. Create production checklist
4. Generate editing decision list
5. Prepare FFmpeg automation scripts
6. Draft all social repurposing content
7. Create YouTube metadata

## Rules
- Always check `.claude/memory/video_reference_style.md` before starting
- Never skip the research phase — validate before scripting
- Every video must have pattern interrupts planned
- Always generate companion social content (not just the video)
- Track all phases in TodoWrite
