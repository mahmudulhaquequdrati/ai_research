---
name: market-research
description: Structured market research for evaluating opportunities, analyzing competition, sizing markets, and identifying trends. Use when evaluating new products, markets, competitors, or business opportunities.
argument-hint: "[market-or-opportunity]"
user-invocable: true
allowed-tools: Read, Grep, Glob, Bash, WebSearch, WebFetch
model: opus
effort: high
---

# Market Research Skill

Research: `$ARGUMENTS`

## Process

### 1. Define the Question
- What decision will this research inform?
- What would change our mind? (define upfront)
- What's the deadline?

### 2. Market Sizing
- **TAM** — Total addressable market (everyone who could buy)
- **SAM** — Serviceable addressable market (those we can reach)
- **SOM** — Serviceable obtainable market (realistic 1-2 year capture)
- Back each number with methodology and sources

### 3. Competitive Landscape
For each competitor (see [reference.md](reference.md) for template):
- What they offer
- Pricing model
- Strengths / Weaknesses
- Market share (if available)
- Our differentiation opportunity

### 4. Customer Analysis
- Ideal customer profile (ICP)
- Current pain points
- How they solve it today
- What would make them switch
- Budget range

### 5. Trend Analysis
- What's growing in this space?
- Technology shifts
- Regulatory changes
- 2-year outlook

### 6. Opportunity Score
Rate 1-10 on:
- Market attractiveness
- Competitive intensity (lower = better for us)
- Our fit/advantage

**Go / No-Go / Investigate Further** recommendation with reasoning.

## Output Format
```markdown
## Market Research: [Topic]

### Executive Summary
[3 sentences: opportunity, size, recommendation]

### Market Size
TAM: $X | SAM: $X | SOM: $X

### Top Competitors
| Name | Offering | Pricing | Our Advantage |
|------|---------|---------|---------------|

### Customer Profile
[ICP description]

### Opportunity Score: X/10
### Recommendation: [Go / No-Go / Investigate]
### Confidence: [High / Medium / Low]
```

## Rules
- Always load `.claude/memory/business_model.md` for own-business context
- Never present speculation as fact — always state confidence level
- Never skip cross-validation of claims
- Never confuse TAM with SOM
- Never ignore indirect competitors
- Always cite sources for key claims
