# app/routes/car_routes.py
from fastapi import APIRouter, UploadFile, File, Depends, HTTPException, Query
from typing import List, Optional
from ..schemas.car_schema import CarCreate, CarOut
from ..models.car_model import create_car, list_cars, get_car_by_id, search_cars_by_text, filter_cars, append_images_to_car
from ..utils.file_utils import save_upload_file
from ..deps import get_current_user
from bson import ObjectId

router = APIRouter(prefix="/cars", tags=["cars"])

@router.post("/add", response_model=CarOut)
async def add_car(
    car_in: CarCreate,
    current_user = Depends(get_current_user)
):
    data = car_in.dict()
    data["owner_id"] = current_user["id"]
    new_car = await create_car(data)
    return {
        "id": new_car["id"],
        "owner_id": new_car["owner_id"],
        "brand": new_car["brand"],
        "model": new_car["model"],
        "year": new_car["year"],
        "price": new_car["price"],
        "mileage": new_car.get("mileage"),
        "fuel": new_car.get("fuel"),
        "transmission": new_car.get("transmission"),
        "city": new_car.get("city"),
        "description": new_car.get("description"),
        "images": new_car.get("images", [])
    }

@router.post("/upload-images/{car_id}", response_model=dict)
async def upload_images(car_id: str, files: List[UploadFile] = File(...), current_user = Depends(get_current_user)):
    # verify ownership
    car = await get_car_by_id(car_id)
    if not car:
        raise HTTPException(status_code=404, detail="Car not found")
    if str(car.get("owner_id")) != current_user["id"]:
        raise HTTPException(status_code=403, detail="Not the owner of this car")
    saved = []
    for f in files:
        path = await save_upload_file(f)
        saved.append(path)
    ok = await append_images_to_car(car_id, saved)
    if not ok:
        raise HTTPException(status_code=500, detail="Could not save images")
    return {"images": saved}

@router.get("/list", response_model=List[CarOut])
async def list_all(limit: int = 50, skip: int = 0, owner_id: Optional[str] = Query(None)):
    if owner_id:
        items = await filter_cars({"owner_id": owner_id}, limit=limit)
    else:
        items = await list_cars(limit=limit, skip=skip)
    return items

@router.get("/{car_id}", response_model=CarOut)
async def get_car(car_id: str):
    car = await get_car_by_id(car_id)
    if not car:
        raise HTTPException(status_code=404, detail="Car not found")
    return car

@router.get("/search", response_model=List[CarOut])
async def search(query: str, limit: int = 50):
    items = await search_cars_by_text(query, limit=limit)
    return items
