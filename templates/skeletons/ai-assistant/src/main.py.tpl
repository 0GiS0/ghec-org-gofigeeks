import os
from typing import Dict, Any
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from dotenv import load_dotenv

load_dotenv()

app = FastAPI(
    title="${{values.name}}",
    description="${{values.description}}",
    version="1.0.0"
)

class ChatRequest(BaseModel):
    message: str
    context: str = ""

class ChatResponse(BaseModel):
    response: str
    confidence: float = 1.0

@app.get("/health")
async def health_check():
    return {
        "status": "OK",
        "service": "${{values.name}}",
        "version": "1.0.0"
    }

@app.post("/chat", response_model=ChatResponse)
async def chat(request: ChatRequest):
    """
    Simple AI assistant endpoint.
    In a real implementation, this would connect to OpenAI, LangChain, or other AI services.
    """
    # Simple echo for demonstration
    response_text = f"AI Assistant received: {request.message}"
    
    if "hello" in request.message.lower():
        response_text = "Hello! How can I assist you today?"
    elif "help" in request.message.lower():
        response_text = "I'm here to help! Ask me anything."
    
    return ChatResponse(
        response=response_text,
        confidence=0.8
    )

@app.get("/")
async def root():
    return {
        "service": "${{values.name}}",
        "message": "AI Assistant API",
        "endpoints": {
            "chat": "/chat",
            "health": "/health",
            "docs": "/docs"
        }
    }

if __name__ == "__main__":
    import uvicorn
    uvicorn.run("main:app", host="0.0.0.0", port=8000, reload=True)