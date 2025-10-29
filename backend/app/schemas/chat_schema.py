# app/schemas/chat_schema.py
from pydantic import BaseModel
from typing import List
from datetime import datetime

class MessageSend(BaseModel):
    receiver_id: str
    message: str

class MessageOut(BaseModel):
    id: str
    sender_id: str
    receiver_id: str
    message: str
    timestamp: datetime
