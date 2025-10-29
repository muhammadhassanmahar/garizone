# app/models/user_model.py
from passlib.context import CryptContext
from ..database import users_collection
from bson import ObjectId

pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

def hash_password(password: str) -> str:
    return pwd_context.hash(password)

def verify_password(plain: str, hashed: str) -> bool:
    return pwd_context.verify(plain, hashed)

async def create_user(data: dict) -> dict:
    data["password"] = hash_password(data["password"])
    data["created_at"] = __now()
    res = await users_collection.insert_one(data)
    user = await users_collection.find_one({"_id": res.inserted_id})
    if user:
        user["id"] = str(user["_id"])
    return user

async def get_user_by_email(email: str):
    user = await users_collection.find_one({"email": email})
    if user:
        user["id"] = str(user["_id"])
    return user

async def get_user_by_id(user_id: str):
    try:
        user = await users_collection.find_one({"_id": ObjectId(user_id)})
    except Exception:
        return None
    if user:
        user["id"] = str(user["_id"])
    return user

def __now():
    from datetime import datetime
    return datetime.utcnow()
