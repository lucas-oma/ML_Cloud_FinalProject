# Greene HPC CLuster Instructions: TGI Server

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
conda create --name tgi_env python=3.10 -y
conda activate tgi_env
```

## 4. Installing requirements
```
# Install Rust (required to compile the Rust backend)
conda install -c conda-forge rust -y

# Install Protobuf (required for model serving)
conda install -c conda-forge protobuf -y
```


## 5. Install (build) TGI from source

> Be warned that this step takes a lot of time

```
git clone https://github.com/huggingface/text-generation-inference.git
cd text-generation-inference
BUILD_EXTENSIONS=True make install
```

## 6. Start GPU Slurm Job V100/A100
```
srun --partition=gpu4_dev --gres=gpu:1 --mem=32GB --pty bash
srun --partition=a100_dev --gres=gpu:1 --mem=32GB --pty bash
```

## 7. Run server

> This will download the model automatically if not already installed

```
text-generation-launcher \
  --model-id ModelCloud/DeepSeek-R1-Distill-Qwen-7B-gptqmodel-4bit-vortex-v2 \
  --quantize gptq \
  --max-input-length 2048 \
  --port 8080
```

## 8. Performance Test
```
export OPENAI_API_KEY=none

export OPENAI_API_BASE=http://localhost:8080/v1

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

## 9. Cancel Interactive Slurm Job
```
sacct
scancel <job-id>
```

## 10. Plot charts
Run the notebook: `graphs.ipynb`
