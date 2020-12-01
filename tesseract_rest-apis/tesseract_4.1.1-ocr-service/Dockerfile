# Author: junyoung.ahn@samsung.com, jyoungahn@gmail.com

# Ubuntu 20.04.1 LTS
FROM ubuntu:20.04

ENV PYTHONUNBUFFERED=1
ENV LANG=ko_KR.UTF-8
ENV FLASK_APP=/app/api.py

RUN apt update

# tesseract 4.1.1
RUN apt install -y tesseract-ocr tesseract-ocr-eng tesseract-ocr-kor

# Python 3.8.5
RUN apt install -y python3
RUN ln -s /usr/bin/python3 /usr/bin/python

# pip 20.0.2
RUN apt install -y python3-pip
RUN ln -s /usr/bin/pip3 /usr/bin/pip

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
