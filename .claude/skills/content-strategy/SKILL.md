---
name: content-strategy
description: Content planning and creation skill. Plans content calendars, writes platform-optimized content, and ensures consistent brand voice. Use when planning content, writing posts, or building content calendars.
argument-hint: "[topic-or-platform]"
user-invocable: true
allowed-tools: Read, Grep, Glob, Write
model: sonnet
effort: medium
---

# Content Strategy Skill

Create content for: `$ARGUMENTS`

## Process

### 1. Audience & Platform
- Who are we writing for? (check brand_identity.md for personas)
- Which platform? (LinkedIn, X, Instagram, Blog, Email, YouTube)
- What's their knowledge level?
- What action do we want them to take?

### 2. Topic Selection
- Aligns with business goals?
- Addresses audience pain points?
- Fills gap competitors miss?
- Timely/trending relevance?

### 3. Content Creation
See [reference.md](reference.md) for platform-specific formats.

For each piece:
1. **Outline** — headline, subheads, key points
2. **Hook** — first 2 sentences that stop the scroll
3. **Body** — value delivery, specific not generic
4. **CTA** — clear next step for the reader

### 4. Quality Check
- [ ] Clear value in first paragraph
- [ ] No filler words (very, really, basically, actually)
- [ ] Specific examples or data included
- [ ] CTA is clear and actionable
- [ ] Brand voice consistent (confident, technical, direct, human)
- [ ] No generic "AI is transforming..." openings
- [ ] Formatted for target platform
- [ ] Proofread

### 5. Distribution Plan
- Primary platform publish
- Repurpose for secondary platforms
- Cross-promote strategy

## Rules
- Always load `.claude/memory/brand_identity.md` before writing content
- Never write generic "AI is transforming/revolutionizing..." openings
- Never publish without running the quality checklist above
- Never write without knowing the target audience and platform
- Never sacrifice clarity for cleverness
- No filler words: very, really, basically, actually, honestly
