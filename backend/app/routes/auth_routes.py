# app/routes/auth_routes.py
from fastapi import APIRouter, HTTPException, status
from ..schemas.user_schema import UserCreate, UserOut, TokenResponse
from ..models.user_model import create_user, get_user_by_email, verify_password
from ..utils.jwt_handler import create_access_token

router = APIRouter(prefix="/auth", tags=["auth"])

@router.post("/register", response_model=UserOut)
async def register(user_in: UserCreate):
    existing = await get_user_by_email(user_in.email)
    if existing:
        raise HTTPException(status_code=400, detail="Email already registered")
    user = await create_user(user_in.dict())
    return {
        "id": user["id"],
        "name": user["name"],
        "email": user["email"],
        "city": user.get("city")
    }

@router.post("/login", response_model=TokenResponse)
async def login(data: UserCreate):
    user = await get_user_by_email(data.email)
    if not user:
        raise HTTPException(status_code=400, detail="Invalid credentials")
    if not verify_password(data.password, user["password"]):
        raise HTTPException(status_code=400, detail="Invalid credentials")
    token = create_access_token(subject=user["id"])
    return {"access_token": token}
