# Dockerfile


```
# Author: June-Young Ahn

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
```
> ### requirements.txt
> ```
> flake8>=3.8,<4.0
> flask>=1.1,<1.2
> nose<2.0
> pytesseract>=0.3,<0.4
> ```

> ### app.py
> ```
> from flask import Flask, request, jsonify
> from PIL import Image
> import pytesseract
> 
> app = Flask(__name__)
> 
> @app.route("/")
> def tesseract_rest_api():
>     if 'image' not in request.files:
>         return jsonify(
>             error={
>                 'image': 'image data needed'
>             }
>         ), 400
> 
>     image = Image.open(request.files['image'])
> 
>     image_text = pytesseract.image_to_string(
>         image,
>         lang='kor'
>     )
> 
>     return jsonify({
>         'text': image_text
>     })
> 
> if __name__=='__main__':
>     app.run(debug=True,host='0.0.0.0', port=5000)
> ```

# Docker Image Build: Korean OCR REST-API
```
$ docker build -t jyoungahn/tesseract-flask-debian .
```

# Docker Container Run: Korean OCR REST-API
```
docker run -d -p 5000:5000 --name tesseract-4-0-0 jyoungahn/tesseract-flask-debian
```
