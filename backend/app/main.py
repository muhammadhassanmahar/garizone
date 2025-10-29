# app/main.py
from fastapi import FastAPI
from fastapi.staticfiles import StaticFiles
from .config import settings
from .routes import auth_routes, car_routes, ai_routes
import os

app = FastAPI(title=settings.APP_NAME)

# include routers
app.include_router(auth_routes.router)
app.include_router(car_routes.router)
app.include_router(ai_routes.router)

# Serve static files (images) from /static
static_path = os.path.join(os.path.dirname(__file__), "static")
os.makedirs(static_path, exist_ok=True)
app.mount("/static", StaticFiles(directory=static_path), name="static")
