# app/database.py
from motor.motor_asyncio import AsyncIOMotorClient
from .config import settings

client = AsyncIOMotorClient(settings.MONGODB_URI)
db = client.get_default_database()

# Collections
users_collection = db.get_collection("users")
cars_collection = db.get_collection("cars")
chats_collection = db.get_collection("chats")
favorites_collection = db.get_collection("favorites")
