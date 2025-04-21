# Use the official Puppeteer image as base
FROM ghcr.io/puppeteer/puppeteer:latest

# Set the working directory
WORKDIR /app

# Copy package.json and optionally package-lock.json
COPY package*.json ./

# Install production dependencies only
RUN npm install --omit=dev

# Copy the rest of the application files
COPY . .

# Expose the port the app runs on
EXPOSE 8000

# Default command to run the app
CMD ["node", "server.js"]