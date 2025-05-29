FROM python:3.12-alpine AS builder
LABEL stage="builder"
WORKDIR /app
RUN apk add --no-cache \
    build-base \
    libffi-dev \
    openssl-dev 
COPY requirements.txt .
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"
RUN pip install --no-cache-dir -r requirements.txt
FROM python:3.12-alpine
LABEL stage="runner"
WORKDIR /app
COPY --from=builder /opt/venv /opt/venv
COPY ./spaceship ./spaceship
COPY ./build ./build
ENV PATH="/opt/venv/bin:$PATH"
EXPOSE 8000
CMD ["uvicorn", "spaceship.main:app", "--host", "0.0.0.0", "--port", "8000"]