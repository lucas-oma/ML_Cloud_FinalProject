export OPENAI_API_KEY=secret_abcdefg
export OPENAI_API_BASE="http://localhost:8081/"


if [ -z "$1" ]; then
  echo "Error: No argument provided."
  exit 1
fi

result_name=$1

python llmperf/token_benchmark_ray.py \
--model "meta-llama/Llama-2-7b-chat-hf" \
--mean-input-tokens 250 \
--stddev-input-tokens 150 \
--mean-output-tokens 75 \
--stddev-output-tokens 10 \
--max-num-completed-requests 10 \
--num-concurrent-requests 1 \
--results-dir "result_outputs/$result_name" \
--llm-api openai \
--additional-sampling-params '{}'