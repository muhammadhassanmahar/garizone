# app/utils/file_utils.py
import os
from uuid import uuid4
from fastapi import UploadFile

BASE_DIR = os.path.dirname(os.path.dirname(__file__))
STATIC_DIR = os.path.join(BASE_DIR, "static")
os.makedirs(STATIC_DIR, exist_ok=True)

async def save_upload_file(upload_file: UploadFile) -> str:
    ext = upload_file.filename.split(".")[-1] if "." in upload_file.filename else "jpg"
    fname = f"{uuid4().hex}.{ext}"
    file_path = os.path.join(STATIC_DIR, fname)
    # write file
    with open(file_path, "wb") as buffer:
        content = await upload_file.read()
        buffer.write(content)
    # return url path for serving via StaticFiles
    return f"/static/{fname}"
