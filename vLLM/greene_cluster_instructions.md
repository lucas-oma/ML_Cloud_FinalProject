# Greene HPC CLuster Instructions: vLLM Server

Author: Lucas Martinez

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
conda create --name vllm_env python=3.10 -y
conda activate vllm_env
```

## 4. Install vLLM via pip
```
pip install vllm
```

## 5. Start GPU Slurm Job V100/A100
```
srun --partition=gpu4_dev --gres=gpu:1 --mem=32GB --pty bash
srun --partition=a100_dev --gres=gpu:1 --mem=32GB --pty bash
```

## 6. Run server

> This will download the model automatically if not already installed

```
python -m vllm.entrypoints.openai.api_server \
  --model ModelCloud/DeepSeek-R1-Distill-Qwen-7B-gptqmodel-4bit-vortex-v2 \
  --dtype float16 \
  --max-model-len 2048

```

## 7. Performance Test
```
export OPENAI_API_KEY=none

export OPENAI_API_BASE=http://localhost:8000/v1

python token_benchmark_ray.py \
  --model "ModelCloud/DeepSeek-R1-Distill-Qwen-7B-gptqmodel-4bit-vortex-v2" \
  --mean-input-tokens 250 \
  --stddev-input-tokens 75 \
  --mean-output-tokens 75 \
  --stddev-output-tokens 10 \
  --max-num-completed-requests 10 \
  --timeout 600 \
  --num-concurrent-requests 1 \
  --results-dir "result_outputs" \
  --llm-api openai \
  --additional-sampling-params '{}'

```

## 8. Cancel Interactive Slurm Job
```
sacct
scancel <job-id>
```

## 9. Plot charts
Run the notebook: `graphs.ipynb`
