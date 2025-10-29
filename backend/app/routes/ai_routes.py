# app/routes/ai_routes.py

from fastapi import APIRouter, HTTPException
from ..services.nlp_parser import parse_query
from ..models.car_model import filter_cars

router = APIRouter(prefix="/ai", tags=["ai"])

@router.post("/chat")
async def chat_endpoint(payload: dict):
    """
    Garibot (AI Assistant for Garizone):
    Understands simple natural queries like:
      - "Karachi me 10 lakh tak cars dikhao"
      - "Under 20 lacs cars in Lahore"
    Returns filtered car data + smart reply.
    """
    text = payload.get("text", "").strip()
    if not text:
        raise HTTPException(status_code=400, detail="Text query required")

    # Step 1: Parse query using NLP
    parsed = parse_query(text)
    max_price = parsed.get("max_price")
    city = parsed.get("city")

    # Step 2: Build Mongo filter dynamically
    filter_q = {}
    if max_price:
        filter_q["price"] = {"$lte": max_price}
    if city:
        filter_q["city"] = {"$regex": f"^{city}$", "$options": "i"}

    # Step 3: Fetch cars
    cars = []
    if filter_q:
        cars = await filter_cars(filter_q, limit=50)

    # Step 4: Smart Roman Urdu reply generation
    if not cars:
        if city and max_price:
            rp = f"Garibot: Sorry! {city} me {max_price:,} PKR tak koi car nahi mili 😔"
        elif max_price:
            rp = f"Garibot: {max_price:,} PKR tak koi car list me nahi hai."
        elif city:
            rp = f"Garibot: Filhal {city} ke liye koi cars available nahi hain."
        else:
            rp = "Garibot: Kripya price aur city mention karein (e.g. '10 lakh tak Karachi')."
    else:
        # Summary of top brands/models
        summary = ", ".join(set([f"{c.get('brand', '')} {c.get('model', '')}".strip() for c in cars[:5]]))
        if city and max_price:
            rp = f"Garibot: {city} me {max_price:,} PKR tak {len(cars)} cars mili hain. Misal: {summary}."
        elif city:
            rp = f"Garibot: {city} me {len(cars)} cars mili hain. Kuch options: {summary}."
        elif max_price:
            rp = f"Garibot: {max_price:,} PKR tak {len(cars)} cars mili hain. Misal: {summary}."
        else:
            rp = f"Garibot: {len(cars)} cars available hain. Misal: {summary}."

    # Step 5: Return clean structured response
    return {
        "reply": rp,
        "parsed": parsed,
        "count": len(cars),
        "cars": cars[:20]  # send limited cars for performance
    }
