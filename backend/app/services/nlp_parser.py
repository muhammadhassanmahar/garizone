# app/services/nlp_parser.py
import re
from typing import Optional, Dict

# Basic Pakistan cities list (extend as needed)
CITIES = ["karachi", "lahore", "islamabad", "quetta", "peshawar", "faisalabad", "multan", "rawalpindi", "sialkot", "gujranwala", "hyderabad"]

def extract_price(text: str) -> Optional[int]:
    """
    Extract price from phrases like:
    - "10 lakh", "15 lacs", "1.2 million", "500k", "500,000"
    Returns price in integer PKR (approx).
    """
    if not text:
        return None
    t = text.lower().replace(",", "")
    # lakh detection (e.g., 10 lakh, 10 lacs)
    m = re.search(r"(\d+(\.\d+)?)\s*(lakh|lac|lacs|lakhon|lakh ka|lacs ka|lakh mein|lakh tak)", t)
    if m:
        try:
            num = float(m.group(1))
            return int(num * 100000)
        except:
            pass
    # k or thousand
    m = re.search(r"(\d+(\.\d+)?)\s*(k|thousand)", t)
    if m:
        try:
            num = float(m.group(1))
            return int(num * 1000)
        except:
            pass
    # million/m
    m = re.search(r"(\d+(\.\d+)?)\s*(million|m)(\b|$)", t)
    if m:
        try:
            num = float(m.group(1))
            return int(num * 1000000)
        except:
            pass
    # plain PKR numbers (5+ digits)
    m = re.search(r"(\d{5,})", t)
    if m:
        try:
            return int(m.group(1))
        except:
            pass
    return None

def extract_city(text: str) -> Optional[str]:
    if not text:
        return None
    t = text.lower()
    for c in CITIES:
        if c in t:
            # return capitalized form
            return c.capitalize()
    # try Urdu city names? (extend here if needed)
    return None

def parse_query(text: str) -> Dict:
    price = extract_price(text)
    city = extract_city(text)
    return {"max_price": price, "city": city}
