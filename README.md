# Readers' Haven Public Library Website

A static, five-page informational website for the fictional **Readers' Haven Public Library**,
built with plain HTML + CSS, bundled with **Parcel**, and containerized with a **multi-stage Dockerfile**
(Node.js build stage -> Nginx runtime stage).

DevOps Fundamentals (SEST4663) - Assignment 02, Fall 2026.

## Pages

| Page | File | Owner |
|------|------|-------|
| Home | `src/index.html` | Team Lead |
| Collections | `src/collections.html` | Team Lead |
| Digital Services | `src/services.html` | Team Lead |
| Membership | `src/membership.html` | Member |
| Contact & Feedback | `src/contact.html` | Member |

> Our group has only two members, so the five pages are shared between the Team Lead and one member.

## Build locally

```bash
npm ci
npm run build      # outputs static site to dist/
```

## Run with Docker

```bash
docker image build -t <dockerhub-username>/readers-haven:v1-<page-name> .
docker container run -d --name haven-<username> -p 8081:80 <dockerhub-username>/readers-haven:v1-<page-name>
```

Then open http://localhost:8081

## Branching model

- `main` - production-ready code
- `develop` - integration branch
- `feature/<page-name>` - one branch per page (created from `develop`)
- `feature/dockerfile` - shared multi-stage Dockerfile
- `release/v2.0` - final testing before merging to `main`
