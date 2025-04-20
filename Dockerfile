# Base image
FROM node:18

# App working directory
WORKDIR /app

# Copy package files and install
COPY package*.json ./
RUN npm install

# Copy rest of the files
COPY . .

# Expose HTTP port
EXPOSE 80

# Start the app
CMD ["npm", "start"]
