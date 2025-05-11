# Greene HPC CLuster Instructions

Author: Alex Peterson

## 1. start interactive job
```
srun --partition=gpu4_dev --gres=gpu:1 --mem=32GB --pty bash
```

## 2. module load 
```
module load anaconda3/gpu/new   # <-- conda
module load cuda/12.6           # <-- nvcc
module load libffi/3.4.3 
```

## 3. Activate Conda Env
```
conda init
conda create --name py10 -c conda-forge python=3.10
conda activate myenv
```

## 4. Build llama.cpp from source
(takes a while)

## 5. Build llama.cpp
```
module load cuda/12.6 
module load cmake/3.23.1
cmake -B build -DGGML_CUDA=ON -DCMAKE_CUDA_COMPILER=/gpfs/share/apps/cuda/12.6/bin/nvcc
cmake --build build --config Release
```
## 6. Download model
```
mkidr models && cd models && \
wget https://huggingface.co/TheBloke/Llama-2-7B-GGUF/resolve/main/llama-2-7b.Q2_K.gguf \
-O llama-2-7b.Q2_K.gguf

wget https://huggingface.co/TheBloke/Llama-2-7B-GGUF/resolve/main/llama-2-7b.Q4_K_M.gguf \
-O llama-2-7b.Q4_K_M.gguf
```

## 7. Set Up Environment 
```
conda activate py310
```

## 8. Start GPU Slurm Job V100/A100
```
srun --partition=gpu4_dev --gres=gpu:1 --mem=32GB --pty bash
srun --partition=a100_dev --gres=gpu:1 --mem=32GB --pty bash
```

## 9. Run server in the background
```
./llama.cpp/build/bin/llama-server --model models/llama-2-7b.gguf --n_gpu_layers 20 --port 8000 -c 4096 > server.log 2>&1 &
```

## 10. Run Inference
```
./run_inference.sh
```

## 11. Performance Test
```
./perf_test.sh
```

## 12. Stop Server
```
ps aux | grep llama_cpp.server
kill <PID>
```

## 13. Cancel Interactive Slurm Job
```
sacct
scancel <job-id>
```

## 14. Plot charts
Run the notebook: `graphs.ipynb`