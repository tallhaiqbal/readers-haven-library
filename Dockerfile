# =====================================================================
# Readers' Haven Public Library - Multi-stage Dockerfile
# Stage 1 builds the static site with Node.js + Parcel.
# Stage 2 serves only the built files with a small Nginx image.
# =====================================================================

# ---------- Stage 1: builder ----------
# Pinned Node.js 22 on Alpine Linux (small base, no :latest tag); named "builder"
FROM node:22-alpine AS builder

# All following commands run inside /app (created automatically)
WORKDIR /app

# Copy only the dependency manifests first so the npm ci layer stays
# cached until package.json / package-lock.json actually change
COPY package*.json ./

# Clean, reproducible install of the exact versions in package-lock.json
RUN npm ci

# Copy the website source pages and the shared stylesheet
COPY src ./src
COPY styles ./styles

# Build all pages in src/ into the static dist/ folder using Parcel
RUN npm run build

# ---------- Stage 2: runtime ----------
# Pinned lightweight Nginx web server; Node.js and node_modules are NOT carried over
FROM nginx:1.27-alpine

# Copy only the built static files from the builder stage into Nginx's web root
COPY --from=builder /app/dist /usr/share/nginx/html

# Document that the container listens on port 80 (HTTP)
EXPOSE 80

# Run Nginx in the foreground so the container keeps running
CMD ["nginx", "-g", "daemon off;"]
