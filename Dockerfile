FROM ollama/ollama:latest

# Install utilities
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      bash && \
    rm -rf /var/lib/apt/lists/*

# Build argument for model
ARG MODEL_NAME

# Copy and run model-pull script to preload the model
COPY pull-model.sh /tmp/pull-model.sh
RUN chmod +x /tmp/pull-model.sh && /tmp/pull-model.sh

# Expose Ollama API port
EXPOSE 11434

# Persist Ollama data/models
VOLUME /root/.ollama

# Use ollama as entrypoint and serve model
ENTRYPOINT ["ollama"]
CMD ["serve"]