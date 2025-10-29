# app/routes/chat_routes.py
from fastapi import APIRouter, Depends
from typing import List
from ..schemas.chat_schema import MessageSend, MessageOut
from ..models.chat_model import send_message, get_conversation
from ..deps import get_current_user

router = APIRouter(prefix="/chat", tags=["chat"])

@router.post("/send", response_model=MessageOut)
async def send_msg(payload: MessageSend, current_user=Depends(get_current_user)):
    msg = await send_message(current_user["id"], payload.receiver_id, payload.message)
    msg["id"] = str(msg["_id"]) if "_id" in msg else "temp"
    return msg

@router.get("/conversation/{receiver_id}", response_model=List[MessageOut])
async def get_chat(receiver_id: str, current_user=Depends(get_current_user)):
    messages = await get_conversation(current_user["id"], receiver_id)
    return messages
