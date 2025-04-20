# Base image with Node.js
FROM node:18-slim

# Install Puppeteer dependencies
RUN apt-get update && apt-get install -y \
  libnss3 \
  libatk-bridge2.0-0 \
  libx11-xcb1 \
  libgbm1 \
  libnspr4 \
  fonts-liberation \
  libappindicator3-1 \
  libxss1 \
  libxtst6 \
  libasound2 \
  lsb-release \
  xdg-utils \
  wget \
  ca-certificates \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of the app
COPY . .

# Expose the port your app uses
EXPOSE 8000

# Start the application
CMD ["node", "server.js"]