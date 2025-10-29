# app/schemas/car_schema.py
from pydantic import BaseModel, Field
from typing import List, Optional

class CarCreate(BaseModel):
    brand: str
    model: str
    year: int
    price: int           # in PKR (e.g., 1000000)
    mileage: Optional[int] = None
    fuel: Optional[str] = None
    transmission: Optional[str] = None
    city: str
    description: Optional[str] = None
    images: Optional[List[str]] = []

class CarOut(CarCreate):
    id: str
    owner_id: str
