# Use Node.js LTS as base image  
FROM node:18-alpine  
  
# Set working directory  
WORKDIR /app  
  
# Copy package files  
COPY package*.json ./  
  
# Install dependencies  
RUN npm install  
  
# Copy source code  
COPY . .  
  
# Build the application  
RUN npm run build  
  
# Expose port 4173 (Vite preview default)  
EXPOSE 4173  
  
# Start the application in preview mode  
CMD ["npm", "run", "dev"]
