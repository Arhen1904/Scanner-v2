from flask import Flask, request, jsonify, render_template
from flask_cors import CORS
from paddleocr import PaddleOCR
from PIL import Image
import io

app = Flask(__name__)
CORS(app)  # habilita CORS globalmente

ocr = PaddleOCR(use_angle_cls=True, lang='latin')

@app.route('/')
def home():
    return render_template('index.html')

@app.route('/ocr', methods=['OPTIONS', 'POST'])
def ocr_route():
    if request.method == 'OPTIONS':
        # Responde al preflight
        return '', 200

    # Procesamiento POST
    image_file = request.files.get('image')
    if not image_file:
        return jsonify({"error": "No image provided"}), 400

    image = Image.open(io.BytesIO(image_file.read()))
    result = ocr.ocr(image, cls=True)

    text = ""
    if result and result[0]:
        for line in result[0]:
            text += line[1][0] + "\n"
    else:
        text = "(No se detectó texto)"

    return jsonify({"text": text})

if __name__ == '__main__':
    app.run(debug=True, host="0.0.0.0", port=5000)
