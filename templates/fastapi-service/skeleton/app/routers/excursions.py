from datetime import datetime
from typing import List

from fastapi import APIRouter, HTTPException

from app.models.excursion import Excursion, ExcursionCreate, ExcursionUpdate

router = APIRouter(prefix="/api/excursions", tags=["excursions"])

# In-memory storage for demonstration purposes
# In a real application, this would be replaced with a proper database
excursions: List[Excursion] = [
    Excursion(
        id=1,
        name="Mountain Hiking Adventure",
        description=(
            "A thrilling hike through the scenic mountain trails with "
            "breathtaking views"
        ),
        location="Rocky Mountains",
        price=75.00,
        duration=6,
        max_participants=12,
        created_at=datetime.utcnow(),
        updated_at=datetime.utcnow(),
    ),
    Excursion(
        id=2,
        name="City Food Tour",
        description=(
            "Explore the best local cuisine and hidden food gems in the city"
        ),
        location="Downtown",
        price=45.00,
        duration=3,
        max_participants=8,
        created_at=datetime.utcnow(),
        updated_at=datetime.utcnow(),
    ),
]
next_id = 3


@router.get("/", response_model=List[Excursion])
async def get_all_excursions():
    """Get all excursions."""
    return excursions


@router.get("/{excursion_id}", response_model=Excursion)
async def get_excursion_by_id(excursion_id: int):
    """Get an excursion by ID."""
    excursion = next((e for e in excursions if e.id == excursion_id), None)
    if not excursion:
        raise HTTPException(
            status_code=404,
            detail=f"Excursion with id {excursion_id} not found",
        )
    return excursion


@router.post("/", response_model=Excursion, status_code=201)
async def create_excursion(excursion_data: ExcursionCreate):
    """Create a new excursion."""
    global next_id

    new_excursion = Excursion(
        id=next_id,
        **excursion_data.dict(),
        created_at=datetime.utcnow(),
        updated_at=datetime.utcnow(),
    )

    excursions.append(new_excursion)
    next_id += 1

    return new_excursion


@router.put("/{excursion_id}", response_model=Excursion)
async def update_excursion(excursion_id: int, excursion_data: ExcursionUpdate):
    """Update an existing excursion."""
    excursion = next((e for e in excursions if e.id == excursion_id), None)
    if not excursion:
        raise HTTPException(
            status_code=404,
            detail=f"Excursion with id {excursion_id} not found",
        )

    # Update the excursion
    update_data = excursion_data.dict()
    for field, value in update_data.items():
        setattr(excursion, field, value)

    excursion.updated_at = datetime.utcnow()

    return excursion


@router.delete("/{excursion_id}", status_code=204)
async def delete_excursion(excursion_id: int):
    """Delete an excursion."""
    global excursions

    excursion_index = next(
        (i for i, e in enumerate(excursions) if e.id == excursion_id),
        None,
    )
    if excursion_index is None:
        raise HTTPException(
            status_code=404,
            detail=f"Excursion with id {excursion_id} not found",
        )

    excursions.pop(excursion_index)
    return
