# Stage 1: Builder
FROM node:18-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# Stage 2: Runtime %ww
FROM node:18-alpine
WORKDIR /app
COPY --from=builder /app .
EXPOSE 9000
CMD ["npm", "run", "start"]
