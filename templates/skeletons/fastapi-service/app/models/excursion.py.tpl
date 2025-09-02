from datetime import datetime
from typing import Optional
from pydantic import BaseModel, Field


class ExcursionBase(BaseModel):
    name: str = Field(..., min_length=1, description="Name of the excursion")
    description: str = Field(default="", description="Description of the excursion")
    location: str = Field(..., min_length=1, description="Location where the excursion takes place")
    price: float = Field(..., gt=0, description="Price of the excursion")
    duration: int = Field(..., gt=0, description="Duration in hours")
    max_participants: int = Field(..., gt=0, description="Maximum number of participants")


class ExcursionCreate(ExcursionBase):
    pass


class ExcursionUpdate(ExcursionBase):
    pass


class Excursion(ExcursionBase):
    id: int
    created_at: datetime
    updated_at: datetime

    class Config:
        from_attributes = True


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