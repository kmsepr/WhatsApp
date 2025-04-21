# Use Puppeteer base image with Chromium pre-installed
FROM ghcr.io/puppeteer/puppeteer:latest

# Set working directory
WORKDIR /app

# Copy only package files first to cache layer
COPY package*.json ./

# Install only production dependencies
RUN npm ci --omit=dev

# Copy rest of the app
COPY . .

# Expose app port
EXPOSE 8000

# Run the app
CMD ["node", "server.js"]