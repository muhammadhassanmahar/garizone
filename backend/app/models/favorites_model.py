# app/models/favorites_model.py
from ..database import favorites_collection
from datetime import datetime

async def add_favorite(user_id: str, car_id: str):
    existing = await favorites_collection.find_one({"user_id": user_id, "car_id": car_id})
    if existing:
        return False
    fav = {"user_id": user_id, "car_id": car_id, "created_at": datetime.utcnow()}
    await favorites_collection.insert_one(fav)
    return True

async def remove_favorite(user_id: str, car_id: str):
    res = await favorites_collection.delete_one({"user_id": user_id, "car_id": car_id})
    return res.deleted_count > 0

async def list_favorites(user_id: str):
    cursor = favorites_collection.find({"user_id": user_id})
    items = []
    async for doc in cursor:
        doc["id"] = str(doc["_id"])
        items.append(doc)
    return items
