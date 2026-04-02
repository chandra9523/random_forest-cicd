FROM python:3.10-slim

WORKDIR /app

COPY . .

RUN pip install -r requirements.txt

# Train model during build
RUN python train.py

CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "5000"]