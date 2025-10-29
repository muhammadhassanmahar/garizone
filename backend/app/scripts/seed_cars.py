# scripts/seed_cars.py
import asyncio
from app.database import cars_collection

SAMPLE = [
    {"brand":"Toyota","model":"Corolla","year":2015,"price":900000,"mileage":80000,"fuel":"Petrol","transmission":"Manual","city":"Karachi","description":"Well maintained","images":[],"owner_id":"seed"},
    {"brand":"Suzuki","model":"Cultus","year":2018,"price":800000,"mileage":60000,"fuel":"Petrol","transmission":"Manual","city":"Lahore","description":"Single owner","images":[],"owner_id":"seed"},
    {"brand":"Honda","model":"Civic","year":2012,"price":1200000,"mileage":90000,"fuel":"Petrol","transmission":"Automatic","city":"Islamabad","description":"Good condition","images":[],"owner_id":"seed"},
    {"brand":"KIA","model":"Sportage","year":2016,"price":2500000,"mileage":70000,"fuel":"Diesel","transmission":"Automatic","city":"Karachi","description":"Imported","images":[],"owner_id":"seed"},
    {"brand":"Suzuki","model":"Mehran","year":2010,"price":300000,"mileage":120000,"fuel":"Petrol","transmission":"Manual","city":"Multan","description":"City car","images":[],"owner_id":"seed"},
]

async def seed():
    await cars_collection.delete_many({"owner_id":"seed"})
    await cars_collection.insert_many(SAMPLE)
    print("Seeded sample cars into Garizone DB")

if __name__ == "__main__":
    asyncio.run(seed())
