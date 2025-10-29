# app/models/chat_model.py
from ..database import chats_collection
from datetime import datetime

async def send_message(sender_id: str, receiver_id: str, message: str):
    msg = {
        "sender_id": sender_id,
        "receiver_id": receiver_id,
        "message": message,
        "timestamp": datetime.utcnow()
    }
    await chats_collection.insert_one(msg)
    return msg

async def get_conversation(user1: str, user2: str):
    cursor = chats_collection.find({
        "$or": [
            {"sender_id": user1, "receiver_id": user2},
            {"sender_id": user2, "receiver_id": user1}
        ]
    }).sort("timestamp", 1)
    messages = []
    async for doc in cursor:
        doc["id"] = str(doc["_id"])
        messages.append(doc)
    return messages
