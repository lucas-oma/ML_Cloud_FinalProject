# llama.cpp server on Apple Sillicon: llama.cpp Server

Author: Alex Peterson

## 1. Install llama.cpp
```
https://github.com/ggml-org/llama.cpp/blob/master/docs/install.md
brew install llama.cpp
```

## 2. Download llama-2-7b quantized 2bit in gguf format
```
https://huggingface.co/TheBloke/Llama-2-7B-GGUF?show_file_info=llama-2-7b.Q2_K.gguf
```

## 3. Run server
```
llama-server -m models/llama-2-7b.Q4_K_M.gguf  --ctx-size 2048 --n-gpu-layers 1
```

## 4. Run Inference request to test server
```
./run_inference.sh
```

## 5. Install and Run llm-perf

```
git clone https://github.com/ray-project/llmperf.git
cd llmperf
pyenv activate py310
pip install -e .
cd .. & ./perf_test.sh
```

## 6. Plot charts
Run the notebook: `graphs.ipynb`