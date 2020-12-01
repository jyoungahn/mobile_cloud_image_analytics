# Author: junyoung.ahn@samsung.com, jyoungahn@gmail.com

# Python 3.8.6
# Debian GNU/Linux 10
FROM python:3.8-slim

ENV PYTHONUNBUFFERED=1
ENV LANG=ko_KR.UTF-8
ENV FLASK_APP=/app/api.py

# tesseract 4.0.0
RUN apt update && apt install -y tesseract-ocr libtesseract-dev tesseract-ocr-eng tesseract-ocr-kor

COPY . /app
WORKDIR /app

# flake8==3.8.4
# Flask==1.1.2
# nose==1.3.7
# Pillow==8.0.1
# pytesseract==0.3.6
RUN pip install -r /app/requirements.txt

EXPOSE 5000
CMD ["python", "app.py"]