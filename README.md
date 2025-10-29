# Garizone - FastAPI Backend (Development)

## Setup (local)
1. Create virtual env:
   python -m venv venv
   source venv/bin/activate   # windows: venv\Scripts\activate

2. Install:
   pip install -r requirements.txt

3. Copy .env.example to .env and set values:
   cp .env.example .env
   # edit .env: set MONGODB_URI & JWT_SECRET

4. Start MongoDB (local) or use Atlas and set MONGODB_URI.

5. Seed sample data (optional):
   python scripts/seed_cars.py

6. Run app:
   uvicorn app.main:app --reload --port 8000

7. Test endpoints:
   - POST /auth/register
   - POST /auth/login
   - POST /ai/chat
   - GET /cars/search?query=civic

Static images uploaded to `app/static/` served at `/static/<filename>`
