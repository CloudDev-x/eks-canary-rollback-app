FROM python:3.12-slim

WORKDIR /app

COPY main.py .

RUN useradd --create-home appuser
USER appuser

CMD ["python", "-u", "main.py"]
