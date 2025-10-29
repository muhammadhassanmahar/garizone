# app/schemas/user_schema.py
from pydantic import BaseModel, EmailStr, Field
from typing import Optional

class UserCreate(BaseModel):
    name: str = Field(...)
    email: EmailStr
    password: str = Field(..., min_length=6)
    city: Optional[str] = None

class UserOut(BaseModel):
    id: str
    name: str
    email: EmailStr
    city: Optional[str] = None

class TokenResponse(BaseModel):
    access_token: str
    token_type: str = "bearer"
