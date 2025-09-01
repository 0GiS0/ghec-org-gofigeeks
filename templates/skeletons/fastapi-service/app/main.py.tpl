import os
import time
from datetime import datetime
from typing import Dict, Any

from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

# Initialize FastAPI app
app = FastAPI(
    title="${{values.name}}",
    description="${{values.description}}",
    version="1.0.0",
    docs_url="/docs",
    redoc_url="/redoc"
)

# Add CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Configure appropriately for production
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Pydantic models
class HealthResponse(BaseModel):
    status: str
    service: str
    timestamp: str
    version: str

class HelloResponse(BaseModel):
    message: str
    timestamp: str

class StatusResponse(BaseModel):
    service: str
    status: str
    uptime: float
    environment: str

# Store start time for uptime calculation
start_time = time.time()

@app.get("/health", response_model=HealthResponse)
async def health_check():
    """Health check endpoint."""
    return HealthResponse(
        status="OK",
        service="${{values.name}}",
        timestamp=datetime.utcnow().isoformat(),
        version="1.0.0"
    )

@app.get("/api/hello", response_model=HelloResponse)
async def hello():
    """Hello world endpoint."""
    return HelloResponse(
        message="Hello from ${{values.name}}!",
        timestamp=datetime.utcnow().isoformat()
    )

@app.get("/api/status", response_model=StatusResponse)
async def get_status():
    """Service status endpoint."""
    return StatusResponse(
        service="${{values.name}}",
        status="running",
        uptime=time.time() - start_time,
        environment=os.getenv("ENVIRONMENT", "development")
    )

@app.get("/")
async def root():
    """Root endpoint with service information."""
    return {
        "service": "${{values.name}}",
        "message": "Welcome to ${{values.name}} API",
        "docs": "/docs",
        "health": "/health"
    }

if __name__ == "__main__":
    import uvicorn
    
    port = int(os.getenv("PORT", 8000))
    host = os.getenv("HOST", "0.0.0.0")
    
    uvicorn.run(
        "main:app",
        host=host,
        port=port,
        reload=True if os.getenv("ENVIRONMENT") == "development" else False
    )