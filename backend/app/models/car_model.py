# app/models/car_model.py
from ..database import cars_collection
from bson import ObjectId
from datetime import datetime

async def create_car(data: dict):
    data["created_at"] = datetime.utcnow()
    res = await cars_collection.insert_one(data)
    car = await cars_collection.find_one({"_id": res.inserted_id})
    if car:
        car["id"] = str(car["_id"])
    return car

async def list_cars(limit: int = 50, skip: int = 0):
    cursor = cars_collection.find().skip(skip).limit(limit)
    items = []
    async for doc in cursor:
        doc["id"] = str(doc["_id"])
        items.append(doc)
    return items

async def get_car_by_id(car_id: str):
    try:
        doc = await cars_collection.find_one({"_id": ObjectId(car_id)})
    except Exception:
        return None
    if doc:
        doc["id"] = str(doc["_id"])
    return doc

async def search_cars_by_text(query: str, limit: int = 50):
    q = {"$or": [
        {"brand": {"$regex": query, "$options": "i"}},
        {"model": {"$regex": query, "$options": "i"}},
        {"description": {"$regex": query, "$options": "i"}}
    ]}
    cursor = cars_collection.find(q).limit(limit)
    items = []
    async for doc in cursor:
        doc["id"] = str(doc["_id"])
        items.append(doc)
    return items

async def filter_cars(filter_q: dict, limit: int = 50):
    cursor = cars_collection.find(filter_q).limit(limit)
    items = []
    async for doc in cursor:
        doc["id"] = str(doc["_id"])
        items.append(doc)
    return items

async def append_images_to_car(car_id: str, image_paths: list):
    try:
        result = await cars_collection.update_one({"_id": ObjectId(car_id)}, {"$push": {"images": {"$each": image_paths}}})
        return result.modified_count > 0
    except Exception:
        return False
