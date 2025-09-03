import os
import time
from datetime import datetime

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.models.excursion import HealthResponse, HelloResponse, StatusResponse
from app.routers import excursions
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

# Service configuration
SERVICE_NAME = "${{values.name}}"
SERVICE_DESCRIPTION = "${{values.description}}"

# Initialize FastAPI app
app = FastAPI(
    title=SERVICE_NAME,
    description=SERVICE_DESCRIPTION,
    version="1.0.0",
    docs_url="/docs",
    redoc_url="/redoc",
)

# Add CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Configure appropriately for production
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Include routers
app.include_router(excursions.router)

# Store start time for uptime calculation
start_time = time.time()


@app.get("/health", response_model=HealthResponse)
async def health_check():
    """Health check endpoint."""
    return HealthResponse(
        status="OK",
        service=SERVICE_NAME,
        timestamp=datetime.utcnow().isoformat(),
        version="1.0.0",
    )


@app.get("/api/hello", response_model=HelloResponse)
async def hello():
    """Hello world endpoint."""
    return HelloResponse(
        message=f"Hello from {SERVICE_NAME}!",
        timestamp=datetime.utcnow().isoformat(),
    )


@app.get("/api/status", response_model=StatusResponse)
async def get_status():
    """Service status endpoint."""
    return StatusResponse(
        service=SERVICE_NAME,
        status="running",
        uptime=time.time() - start_time,
        environment=os.getenv("ENVIRONMENT", "development"),
    )


@app.get("/")
async def root():
    """Root endpoint with service information."""
    return {
        "service": SERVICE_NAME,
        "message": "Welcome to the Excursions API",
        "version": "1.0.0",
        "endpoints": {
            "health": "/health",
            "hello": "/api/hello",
            "status": "/api/status",
            "excursions": "/api/excursions",
            "docs": "/docs",
            "redoc": "/redoc",
        },
        "excursion_endpoints": {
            "get_all_excursions": "GET /api/excursions",
            "get_excursion_by_id": "GET /api/excursions/{id}",
            "create_excursion": "POST /api/excursions",
            "update_excursion": "PUT /api/excursions/{id}",
            "delete_excursion": "DELETE /api/excursions/{id}",
        },
    }


if __name__ == "__main__":
    import uvicorn

    port = int(os.getenv("PORT", 8000))
    host = os.getenv("HOST", "0.0.0.0")

    uvicorn.run(
        "main:app",
        host=host,
        port=port,
        reload=True if os.getenv("ENVIRONMENT") == "development" else False,
    )
