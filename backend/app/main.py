# app/main.py
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from fastapi.staticfiles import StaticFiles
from .config import settings
from .routes import (
    auth_routes,
    car_routes,
    ai_routes,
    favorites_routes,
    chat_routes,
)
import os

# Initialize FastAPI App
app = FastAPI(title=settings.APP_NAME, version="2.0", description="Garizone Backend API")

# Allow Flutter frontend (adjust origin if hosted)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # you can set specific origins like ["http://localhost:3000"]
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Include all routers
app.include_router(auth_routes.router)
app.include_router(car_routes.router)
app.include_router(ai_routes.router)
app.include_router(favorites_routes.router)
app.include_router(chat_routes.router)

# Serve static files (uploaded car images)
static_path = os.path.join(os.path.dirname(__file__), "static")
os.makedirs(static_path, exist_ok=True)
app.mount("/static", StaticFiles(directory=static_path), name="static")

# Root route for quick health check
@app.get("/")
async def root():
    return {
        "app": settings.APP_NAME,
        "status": "running ✅",
        "version": "2.0",
        "message": "Welcome to Garizone API — Pakistan's Car Marketplace 🚗",
    }
