# app/schemas/favorites_schema.py
from pydantic import BaseModel

class FavoriteAdd(BaseModel):
    car_id: str

class FavoriteOut(BaseModel):
    id: str
    user_id: str
    car_id: str
