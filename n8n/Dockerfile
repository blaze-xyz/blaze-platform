FROM n8nio/n8n:latest

# Set the working directory
WORKDIR /home/node

# Copy any custom configuration or extensions if needed
# COPY custom-nodes/ /home/node/.n8n/custom/

# Create the .n8n directory with proper permissions
RUN mkdir -p /home/node/.n8n && chown -R node:node /home/node/.n8n

# Switch to the node user
USER node

# Expose the port
EXPOSE 5678

# Start n8n
CMD ["n8n", "start"]
