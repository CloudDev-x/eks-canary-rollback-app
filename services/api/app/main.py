import os
import random

from fastapi import FastAPI, Request
from fastapi.responses import JSONResponse, Response
from prometheus_client import CONTENT_TYPE_LATEST, Counter, generate_latest

APP_VERSION = os.getenv("APP_VERSION", "dev")
FAIL_RATE = float(os.getenv("FAIL_RATE", "0"))

REQUESTS = Counter(
    "http_requests_total",
    "HTTP requests by method, route and status",
    ["method", "route", "status"],
)

app = FastAPI()


@app.middleware("http")
async def count_requests(request: Request, call_next):
    response = await call_next(request)
    route = request.scope.get("route")
    path = route.path if route is not None else "unmatched"
    REQUESTS.labels(request.method, path, str(response.status_code)).inc()
    return response


@app.get("/")
def root():
    if random.random() < FAIL_RATE:
        return JSONResponse({"error": "injected failure"}, status_code=500)
    return {"service": "api", "version": APP_VERSION}


@app.get("/healthz")
def healthz():
    return {"status": "ok"}


@app.get("/metrics")
def metrics():
    return Response(content=generate_latest(), media_type=CONTENT_TYPE_LATEST)
