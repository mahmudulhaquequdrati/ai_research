---
name: architecture_patterns
description: Design patterns and architectural decisions used across AI Skills projects
type: reference
---

## Core Patterns

### API Design
- RESTful for simple CRUD
- GraphQL when clients need flexible queries
- WebSockets for real-time features
- Always version APIs (v1, v2)

### Authentication
- JWT tokens for stateless auth
- Refresh token rotation
- OAuth2 for third-party integrations
- Role-based access control (RBAC)

### Database
- PostgreSQL as default relational DB
- Migrations tracked in version control
- Indexes for every query pattern
- Soft deletes for important data

### AI Integration
- RAG pattern for knowledge-augmented responses
- Structured output (JSON mode) for programmatic LLM use
- Streaming for real-time LLM responses
- Token budgeting for cost control
- Eval loops for quality assurance (autoresearch method)

### Error Handling
- Errors at system boundaries (API inputs, external services)
- Structured error responses with codes
- Don't over-catch — let unexpected errors bubble up
- Log errors with context, not just messages

### Deployment
- Git-based deployments (push to deploy)
- Feature flags for gradual rollouts
- Blue-green or canary deployments for critical services
- Rollback plan for every deployment

## Anti-Patterns to Avoid
- Don't abstract prematurely
- Don't add caching until there's a measured performance issue
- Don't build microservices until monolith is painful
- Don't use NoSQL unless there's a specific reason
- Don't write custom auth — use battle-tested libraries
