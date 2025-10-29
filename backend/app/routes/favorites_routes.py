# app/routes/favorites_routes.py
from fastapi import APIRouter, Depends, HTTPException
from typing import List
from ..schemas.favorites_schema import FavoriteAdd, FavoriteOut
from ..models.favorites_model import add_favorite, remove_favorite, list_favorites
from ..deps import get_current_user

router = APIRouter(prefix="/favorites", tags=["favorites"])

@router.post("/add")
async def add_to_favorites(payload: FavoriteAdd, current_user=Depends(get_current_user)):
    ok = await add_favorite(current_user["id"], payload.car_id)
    if not ok:
        raise HTTPException(status_code=400, detail="Already in favorites")
    return {"message": "Added to favorites"}

@router.delete("/remove/{car_id}")
async def remove_from_favorites(car_id: str, current_user=Depends(get_current_user)):
    ok = await remove_favorite(current_user["id"], car_id)
    if not ok:
        raise HTTPException(status_code=404, detail="Favorite not found")
    return {"message": "Removed from favorites"}

@router.get("/list", response_model=List[FavoriteOut])
async def list_user_favorites(current_user=Depends(get_current_user)):
    return await list_favorites(current_user["id"])
