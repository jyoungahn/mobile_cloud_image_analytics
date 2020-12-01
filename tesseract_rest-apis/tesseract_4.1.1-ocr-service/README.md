# Dockerfile
 * OCR model: Tesseract-ocr 4.1.1
 * REST API Server: Flask 1.1.2
 * Programming Language: Python 3.8

```
# Author: June-Young Ahn

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
$ docker build -t jyoungahn/tesseract-flask-ubuntu .
```

# Docker Container Run: Korean OCR REST-API
```
docker run -d -p 5000:5000 --name tesseract-4-1-1 jyoungahn/tesseract-flask-ubuntu
```
