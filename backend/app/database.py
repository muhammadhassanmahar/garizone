# app/database.py
from motor.motor_asyncio import AsyncIOMotorClient
from .config import settings

# Create MongoDB client
client = AsyncIOMotorClient(settings.MONGODB_URI)

# Select the database using DB_NAME from .env
db = client[settings.DB_NAME]

# Define collections
users_collection = db["users"]
cars_collection = db["cars"]
chats_collection = db["chats"]
favorites_collection = db["favorites"]  # ✅ add this line
