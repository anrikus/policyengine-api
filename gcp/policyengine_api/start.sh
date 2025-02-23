# Start the API
gunicorn -b :$PORT policyengine_api.api --timeout 300 --workers 4 &
echo "Running on PORT:$PORT"
# Start the redis server
redis-server &
# Start the worker
python3.9 policyengine_api/worker.py
