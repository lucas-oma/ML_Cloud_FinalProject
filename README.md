# LLM Inference Server Benchmarks

> This entire directory is also available in our github repository to make it easier to read the MarkDown files! Find it here: 

This directory contains setup scripts, configuration files, and runtime instructions for benchmarking three popular LLM inference servers using [`LLMPerf`](https://github.com/ray-project/llmperf):  
- **llama.cpp**
- **vLLM**
- **Text Generation Inference (TGI)**

---

## Benchmarking Setup: LLMPerf

Before using any of the inference server directories, clone and install `LLMPerf`:

```
git clone https://github.com/ray-project/llmperf
cd llmperf
pip install -e .
```

## Directory Structure

Each subdirectory contains environment setup and runtime instructions specific to a given server, as well as benchmarking instructions:

### `llamacpp/`

- This directory contains a markdown file with scripts and build instructions for compiling and running [`llama.cpp`](https://github.com/ggerganov/llama.cpp).
- Includes test prompts and benchmarking calls using `LLMPerf`.


### `vLLM/`

- This directory contains a markdown file with instructions for the setup of [`vLLM`](https://github.com/vllm-project/vllm), including running the API server.

- Includes example benchmark configs for A100 and V100 environments.


### `TGI/`

-  This directory contains a markdown file with  configuration and setup for [`Text Generation Inference`](https://github.com/huggingface/text-generation-inference).

- Demonstrates how to launch TGI with 4-bit GPTQ models and benchmark them using `LLMPerf`.

---

## Notes

- All servers expose OpenAI-compatible endpoints for uniform benchmarking via `LLMPerf`.

- Models used are quantized (4-bit GPTQ or GGUF) and consistent across servers where supported.

- See individual folders for detailed usage instructions and environment setup.



