from flask import Flask, request, jsonify
from PIL import Image
import pytesseract
import cv2

app = Flask(__name__)

@app.route('/', methods=['POST'])
def tesseract_rest_api():
    if 'image' not in request.files:
        return jsonify(
            error={
                'image': 'image data needed'
            }
        ), 400

    # image = Image.open(request.files['image'])
    image_gray = cv2.imread(Image.open(request.files['image']), cv2.IMREAD_GRAYSCALE)

    image_text = pytesseract.image_to_string(image_gray, lang='kor')

    return jsonify({
        'text': image_text
    })

if __name__=='__main__':
    app.run(debug=True,host='0.0.0.0', port=5000)
    