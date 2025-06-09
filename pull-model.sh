#!/usr/bin/env bash
set -e

# Start Ollama server in background
ollama serve &

# Wait until server is active (ollama list returns header)
until ollama list | grep -q "NAME"; do
  sleep 1
done

# Pull the specified model
ollama pull "${MODEL_NAME}"
