# Multi-stage build for production  
FROM node:18-alpine AS builder  
  
WORKDIR /app  
  
# Copy package files  
COPY package*.json ./  
  
# Install dependencies  
RUN npm ci --only=production  
  
# Copy source code  
COPY . .  
  
# Build the application  
RUN npm run build  
  
# Production stage with nginx  
FROM nginx:alpine  
  
# Copy built assets  
COPY --from=builder /app/dist /usr/share/nginx/html  
  
# Copy nginx configuration  
COPY nginx.conf /etc/nginx/conf.d/default.conf  
  
# Expose port 80 (Coolify default)  
EXPOSE 80  
  
CMD ["nginx", "-g", "daemon off;"]
