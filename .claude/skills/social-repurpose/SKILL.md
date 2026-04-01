---
name: social-repurpose
description: Repurpose long-form video into social media content — short clips, LinkedIn posts, Twitter threads, Instagram carousels, blog posts. Use after producing any video content.
argument-hint: "[video-title-or-script-path]"
user-invocable: true
allowed-tools: Read, Grep, Glob, Write, Edit, Bash
model: sonnet
effort: medium
---

# Social Repurpose Skill

Repurpose video content for: `$ARGUMENTS`

## The 1-to-10 Content Multiplier

Every long-form video produces at minimum 10 pieces of content:

```
1 YouTube Video (10-15 min)
├── 3-5 YouTube Shorts (30-60s vertical clips)
├── 1 LinkedIn Post (key insight, text-based)
├── 1 Twitter/X Thread (5-7 tweets, key takeaways)
├── 1 Instagram Carousel (5-7 slides, step-by-step)
├── 1 Instagram Reel (best 30-60s clip, vertical)
├── 1 Blog Post (tutorial version, 800-1200 words)
├── 1 Email Newsletter Block (200-300 words + CTA)
└── 1 LinkedIn Article (deep-dive, 600-800 words)
```

## Phase 1: Identify Clip-Worthy Moments

From the script/video, extract:
- **Hook moments** — Bold claims, surprising stats, counterintuitive insights
- **Aha moments** — When the solution clicks
- **Proof moments** — Results, data, screenshots
- **Quotable lines** — Single sentences that stand alone
- **Step summaries** — Compressed how-to in 60 seconds

Output a clips list:
```yaml
clips:
  - name: "hook_ai_agent_morning"
    timestamp: "00:00:00-00:00:45"
    type: "hook"
    platforms: [youtube_shorts, instagram_reels, tiktok, linkedin]
    caption: "This AI agent gets me LinkedIn content before I wake up"

  - name: "3_step_setup"
    timestamp: "00:03:20-00:04:15"
    type: "step_summary"
    platforms: [youtube_shorts, instagram_reels]
    caption: "Build this in 3 steps"
```

## Phase 2: Platform-Specific Content

### LinkedIn Post
```
[Hook line — bold claim or question]

[2-3 sentences expanding on the insight]

Here's exactly how it works:

→ Step 1: [Brief description]
→ Step 2: [Brief description]
→ Step 3: [Brief description]

The result? [Specific outcome with numbers]

[CTA — comment, follow, or link to video]

---
♻️ Repost if this helped
🔔 Follow @mahmudqudrati for more AI automation
```

**Rules:**
- Max 1300 characters for optimal reach
- Use → or • for lists (not numbers)
- Line breaks between every 1-2 sentences
- Hook must work without the rest of the post
- No hashtags in body (3 max in comments)

### Twitter/X Thread
```
Tweet 1 (Hook):
[Bold claim or result] — Here's the exact system: 🧵

Tweet 2-6 (Steps):
{n}/ [Step name]

[2-3 sentences explaining]

[Screenshot or diagram if available]

Tweet 7 (CTA):
That's the full system.

If you want the complete walkthrough: [YouTube link]

Follow @mahmudqudrati for more AI automation breakdowns.
```

**Rules:**
- Tweet 1 must be viral-worthy standalone
- Each tweet < 280 chars
- Include media (screenshots/diagrams) on 2-3 tweets
- Thread should be valuable even without watching video
- End with CTA to video + follow

### Instagram Carousel
```yaml
slides:
  1:
    type: "cover"
    headline: "[Attention-grabbing title]"
    subline: "Swipe to learn how →"
    design: "bold text on branded gradient"

  2-6:
    type: "step"
    headline: "Step {n}: [Name]"
    body: "[2-3 bullet points, max 50 words]"
    visual: "[Screenshot or diagram]"
    design: "clean, readable, branded colors"

  7:
    type: "cta"
    headline: "Want the full walkthrough?"
    body: "Link in bio for the complete YouTube tutorial"
    cta: "Save this post + Follow for more"
    design: "branded, clear CTA"
```

**Rules:**
- 1080x1350px (4:5 ratio)
- Max 7 slides
- Each slide scannable in 3 seconds
- Cover slide must stop the scroll
- Consistent brand colors throughout

### Blog Post
```markdown
# [SEO Title — matches YouTube but written for search]

**TL;DR:** [1-2 sentence summary]

## The Problem
[Expand on the pain point from the video]

## The Solution
[Overview of what you built/demonstrate]

## Step-by-Step Guide

### Step 1: [Name]
[Detailed written instructions]
[Screenshot]

### Step 2: [Name]
[Detailed written instructions]
[Screenshot]

### Step 3: [Name]
[Detailed written instructions]
[Screenshot]

## Results
[Data, screenshots, proof]

## What's Next
[CTA to video, newsletter, or related content]
```

**Rules:**
- 800-1200 words
- Include screenshots from the video as images
- SEO-optimize headers and meta description
- Internal link to related content
- CTA to YouTube video and newsletter

### Email Newsletter Block
```
Subject: [Curiosity-driven, < 50 chars]

[First name],

[1-2 sentences on the problem]

This week I built [solution] and the results are wild:
→ [Result 1]
→ [Result 2]

[1-2 sentences on key insight]

👉 [Watch the full breakdown (X min)]

[Sign-off]
```

## Phase 3: Clip Processing (video-editor agent)

For each identified clip:
```bash
# Extract clip
ffmpeg -i full_video.mp4 -ss START -to END -c copy clip.mp4

# Convert to vertical (9:16)
ffmpeg -i clip.mp4 -vf "crop=ih*9/16:ih,scale=1080:1920" vertical.mp4

# Add captions (large, centered for mobile)
ffmpeg -i vertical.mp4 \
  -vf "subtitles=clip.srt:force_style='FontSize=28,Alignment=2,MarginV=100,Bold=1'" \
  captioned.mp4

# Add hook text (first 3 seconds)
ffmpeg -i captioned.mp4 \
  -vf "drawtext=text='This changes everything':fontsize=42:fontcolor=white:x=(w-text_w)/2:y=h*0.2:enable='between(t,0,3)':box=1:boxcolor=black@0.6:boxborderw=15" \
  final_short.mp4
```

## Content Calendar Template

After repurposing, schedule across 7 days:

| Day | Platform | Content Type | Asset |
|-----|----------|-------------|-------|
| Day 0 (Publish) | YouTube | Full video | main video |
| Day 0 | LinkedIn | Text post (key insight) | linkedin_post.md |
| Day 1 | Twitter/X | Thread | twitter_thread.md |
| Day 1 | Instagram | Reel (best clip) | reel_clip.mp4 |
| Day 2 | YouTube | Short #1 | short_1.mp4 |
| Day 3 | Instagram | Carousel | carousel/ |
| Day 3 | LinkedIn | Article | linkedin_article.md |
| Day 4 | YouTube | Short #2 | short_2.mp4 |
| Day 5 | Blog | Tutorial post | blog_post.md |
| Day 5 | Email | Newsletter | email_block.md |
| Day 6 | YouTube | Short #3 | short_3.mp4 |
| Day 7 | Twitter/X | Recap tweet | recap_tweet.md |

## Rules
- Always load `.claude/memory/brand_identity.md` before writing any content
- Never post the same text on multiple platforms — adapt for each
- Every piece must deliver value standalone (not just "watch my video")
- Short clips must have captions (85% of social video is watched on mute)
- Track all repurposed content in TodoWrite
