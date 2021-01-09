import requests
import json

# Azure container REST-API for tesseract 4.0.0
url = 'http://sfmi-vision-ocr40.koreacentral.azurecontainer.io:5000/'

# Azure container REST-API for tesseract 4.1.1
# url = 'http://sfmi-vision-ocr.koreacentral.azurecontainer.io:5000/'

img = {'image': open('번호판_38육4104_cropped.png', 'rb')}
# img = {'image': open('번호판_38육4104.jpg', 'rb')}

response = requests.post(url, files=img)

print(response.json)

texts = json.loads(response.text)

print(texts)

# for text in texts['text']:
#     print(text)