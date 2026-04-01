---
name: video-editing
description: Video editing automation with FFmpeg commands, caption generation, effects, transitions, and post-production workflows. Use for any video editing or processing task.
argument-hint: "[editing-task-or-video-path]"
user-invocable: true
allowed-tools: Read, Grep, Glob, Write, Edit, Bash
model: sonnet
effort: high
---

# Video Editing Skill

Edit video for: `$ARGUMENTS`

## Editing Philosophy (Diandra Escobar Style)

1. **Editing serves the story** — Every cut has a narrative purpose
2. **Pattern interrupts** — Break monotony every 60-90 seconds with:
   - Camera angle changes
   - Sound effects (whoosh, impact, pop)
   - Graphic overlays (stats, diagrams, text)
   - Music changes (energy shift)
   - B-roll inserts
   - Zoom in/out on key moments
3. **Peaks and valleys** — Dynamic pacing, not constant energy
4. **Restrict and reveal** — Guide viewers through complexity in chunks
5. **Emotionally-driven cuts** — Cut for feeling, not just logic
6. **Professional but human** — Clean production, genuine personality

## FFmpeg Quick Reference

### Trim & Join
```bash
# Trim
ffmpeg -i input.mp4 -ss HH:MM:SS -to HH:MM:SS -c copy output.mp4

# Join from list (filelist.txt: file 'clip1.mp4'\nfile 'clip2.mp4')
ffmpeg -f concat -safe 0 -i filelist.txt -c copy output.mp4
```

### Picture-in-Picture
```bash
# Webcam overlay on screen recording (bottom-right, 25% size)
ffmpeg -i screen.mp4 -i webcam.mp4 \
  -filter_complex "[1:v]scale=iw*0.25:ih*0.25[pip];[0:v][pip]overlay=W-w-20:H-h-20" \
  -c:a copy output.mp4

# With rounded corners and border
ffmpeg -i screen.mp4 -i webcam.mp4 \
  -filter_complex "[1:v]scale=384:216,format=yuva420p,geq=lum='p(X,Y)':a='if(gt(abs(X-W/2),W/2-10)*gt(abs(Y-H/2),H/2-10),0,255)'[pip];[0:v][pip]overlay=W-w-30:H-h-30" \
  output.mp4
```

### Text Overlays
```bash
# Step indicator (top center)
ffmpeg -i input.mp4 \
  -vf "drawtext=text='Step 1':fontsize=36:fontcolor=white:x=(w-text_w)/2:y=40:box=1:boxcolor=#00d4ff@0.9:boxborderw=15:enable='between(t,5,12)'" \
  output.mp4

# Lower third with name
ffmpeg -i input.mp4 \
  -vf "drawtext=text='Mahmud Qudrati | AI Skills':fontsize=28:fontcolor=white:x=40:y=h-80:box=1:boxcolor=black@0.7:boxborderw=12:enable='between(t,2,8)'" \
  output.mp4
```

### Transitions & Effects
```bash
# Fade in/out
ffmpeg -i input.mp4 -vf "fade=t=in:st=0:d=0.5,fade=t=out:st=END:d=0.5" output.mp4

# Zoom in (slow push, 5 seconds)
ffmpeg -i input.mp4 -vf "zoompan=z='if(lte(on,150),1+on*0.002,1.3)':d=1:x='iw/2-(iw/zoom/2)':y='ih/2-(ih/zoom/2)':s=1920x1080:fps=30" output.mp4

# Speed ramp (2x fast forward)
ffmpeg -i input.mp4 -filter:v "setpts=0.5*PTS" -filter:a "atempo=2.0" output.mp4

# Blur background (for vertical reformat)
ffmpeg -i input.mp4 -filter_complex "[0:v]scale=1080:1920:force_original_aspect_ratio=decrease[fg];[0:v]scale=1080:1920,boxblur=20[bg];[bg][fg]overlay=(W-w)/2:(H-h)/2" vertical.mp4
```

### Color Grading Presets
```bash
# Bright & Clean (educational content)
-vf "eq=brightness=0.04:contrast=1.08:saturation=1.15"

# Warm & Inviting (personal brand)
-vf "eq=brightness=0.03:contrast=1.05:saturation=1.2,colorbalance=rs=0.05:gs=-0.02:bs=-0.05"

# High Contrast Tech (dark mode feel)
-vf "eq=brightness=-0.02:contrast=1.2:saturation=1.1,curves=m='0/0 0.3/0.2 0.7/0.8 1/1'"

# Consistent across all clips
for f in clips/*.mp4; do
  ffmpeg -i "$f" -vf "eq=brightness=0.04:contrast=1.08:saturation=1.15" -c:a copy "graded/$(basename "$f")"
done
```

### Caption Generation & Styling
```bash
# Step 1: Extract audio for transcription
ffmpeg -i video.mp4 -vn -acodec pcm_s16le -ar 16000 -ac 1 audio.wav

# Step 2: Generate with Whisper (install: pip install openai-whisper)
whisper audio.wav --model medium --output_format srt --language en

# Step 3: Burn in with modern style
ffmpeg -i video.mp4 \
  -vf "subtitles=audio.srt:force_style='FontName=Montserrat Bold,FontSize=22,PrimaryColour=&H00FFFFFF,OutlineColour=&H00000000,BackColour=&H80000000,Outline=2,Shadow=1,Alignment=2,MarginV=50'" \
  captioned.mp4
```

### Audio Processing
```bash
# Normalize to -14 LUFS (YouTube standard)
ffmpeg -i input.mp4 -af "loudnorm=I=-14:TP=-1.5:LRA=11" -c:v copy normalized.mp4

# Mix background music at -18dB under voice
ffmpeg -i voice.mp4 -i music.mp3 \
  -filter_complex "[1:a]volume=-18dB[music];[0:a][music]amix=inputs=2:duration=first" \
  -c:v copy output.mp4

# Remove background noise (basic)
ffmpeg -i input.mp4 -af "highpass=f=200,lowpass=f=3000,anlmdn=s=7" clean.mp4
```

### Export Presets
```bash
# YouTube (main video)
ffmpeg -i input.mp4 -c:v libx264 -preset slow -crf 18 -c:a aac -b:a 192k -movflags +faststart youtube.mp4

# YouTube Shorts / Instagram Reels (vertical)
ffmpeg -i input.mp4 -vf "crop=ih*9/16:ih,scale=1080:1920" -c:v libx264 -crf 18 -c:a aac short.mp4

# Twitter/X (compressed)
ffmpeg -i input.mp4 -c:v libx264 -crf 23 -c:a aac -b:a 128k -fs 512M twitter.mp4

# GIF (for thumbnails/previews)
ffmpeg -i input.mp4 -ss 00:00:02 -t 3 -vf "fps=15,scale=480:-1:flags=lanczos" preview.gif
```

## Workflow Templates

### Educational Walkthrough (like the reference video)
1. Normalize all raw clips to 1080p
2. Arrange per EDL/shot list
3. Add PiP (webcam over screen recording)
4. Insert step indicators at each new section
5. Add pattern interrupts (stat callouts, zoom effects)
6. Color grade (bright & clean preset)
7. Generate captions → style → burn in
8. Mix audio (voice + background music)
9. Add lower third at first appearance
10. Export main + extract 3-5 short clips

### Short-Form Clip
1. Extract best 30-60s moment
2. Crop to 9:16 vertical
3. Add large centered captions
4. Speed ramp boring transitions
5. Add hook text at start (first 3 seconds)
6. Export for each platform

## Rules
- Always verify FFmpeg is installed before running commands
- Process ONE clip at a time, verify before next
- Never overwrite source files — always output to new path
- Check audio sync after every processing step
- Use `-y` flag carefully — confirm overwrite is intended
- Track all processing steps in TodoWrite
