#!/bin/bash

# Step 1: Run the container (interactive, detached)
docker run -d --network=host --device=/dev/kfd --device=/dev/dri --ipc=host \
  --shm-size 32G --group-add video --cap-add=SYS_PTRACE --security-opt seccomp=unconfined \
  -v "$(pwd)":/workspace --name grok2_container rocm/sgl-dev:v0.5.0rc2-rocm630-mi30x-20250823

# Step 2: Download Grok-2 from Hugging Face (inside container)
docker exec grok2_container huggingface-cli download xai-org/grok-2 --local-dir /workspace/grok-2

# Step 3: Launch SGLang server inside the container
docker exec -d grok2_container python3 -m sglang.launch_server \
  --model /workspace/grok-2 \
  --tokenizer-path /workspace/grok-2/tokenizer.tok.json \
  --tp 8 --quantization fp8 --attention-backend triton

# Step 4: Send request from the client
curl -s http://localhost:30000/v1/completions \
  -H "Content-Type: application/json" \
  -d '{
    "model": "/workspace/grok-2",
    "prompt": "Human: I am three times as old as you were when I was your age. When you are my age, the sum of our ages will be 84. What are our current ages?<|separator|>\n\nAssistant:",
    "max_tokens": 1000,
    "temperature": 0.7
  }'
