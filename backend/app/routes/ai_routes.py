# app/routes/ai_routes.py
from fastapi import APIRouter
from ..services.nlp_parser import parse_query
from ..models.car_model import filter_cars

router = APIRouter(prefix="/ai", tags=["ai"])

@router.post("/chat")
async def chat_endpoint(payload: dict):
    """
    Garibot: simple rule-based conversational parser.
    payload = {"text": "10 lakh tak cars dikhao karachi me"}
    returns: {"reply": "...", "cars": [...], "parsed": {...}}
    """
    text = payload.get("text", "") or ""
    parsed = parse_query(text)
    max_price = parsed.get("max_price")
    city = parsed.get("city")

    filter_q = {}
    if max_price:
        filter_q["price"] = {"$lte": max_price}
    if city:
        # case-insensitive exact match of city field
        filter_q["city"] = {"$regex": f"^{city}$", "$options": "i"}

    cars = []
    if filter_q:
        cars = await filter_cars(filter_q, limit=50)

    # craft reply in Urdu/Roman-friendly text (simple)
    if not cars:
        if city and max_price:
            rp = f"Maaf kijiye — Garibot ne {city} mein {max_price:,} PKR tak koi cars nahi dhoondi."
        elif max_price:
            rp = f"Maaf kijiye — Garibot ne {max_price:,} PKR tak koi cars nahi dhoondi."
        else:
            rp = "Garibot: Kripya price ya city mention karein (misal: '10 lakh tak Karachi')."
    else:
        rp = f"Garibot: Yeh {len(cars)} car(s) match kar rahi hain."
    return {"reply": rp, "cars": cars, "parsed": parsed}
