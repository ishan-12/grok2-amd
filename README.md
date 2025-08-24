# Grok2.5 on AMD MI300X with SGLang

This repository provides a script to run Grok2.5 out-of-the-box on AMD MI300X GPUs using SGLang.

## Prerequisites

- AMD MI300X GPU
- Docker installed
- Internet access (to download model from Hugging Face)
- **Run from the host machine** (not from within a Docker container)

## How to Run

1. **Clone this repository to your host machine**
2. **Run the script from the host:**
	```bash
	bash run_grok2.sh
	```

The script will:

1. Start a Docker container with ROCm and SGLang pre-installed for MI300X.
2. Download the Grok-2 model from Hugging Face into the container.
3. Launch the SGLang server with Grok2.5 using optimal settings for MI300X (FP8 quantization, Triton attention backend, tensor parallelism).
4. Send a sample request to the server using `curl`.

## Example Output

After running the script, you should see a response from Grok2.5 to the sample prompt.

## Customization

- To use a different prompt, edit the `curl` command in `run_grok2.sh`.
- For advanced SGLang options, see [SGLang documentation](https://github.com/sglang/sglang).

## References

- [Grok-2 on Hugging Face](https://huggingface.co/xai-org/grok-2)
- [SGLang](https://github.com/sglang/sglang)