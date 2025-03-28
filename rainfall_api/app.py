from flask import Flask, request, jsonify
import pickle
import pandas as pd
import numpy as np

app = Flask(__name__)

# Load the trained model
model_path = "rainfall_api/rainfall_model.pkl"
with open(model_path, "rb") as model_file:
    model = pickle.load(model_file)

@app.route("/predict", methods=["POST"])
def predict_rainfall():
    try:
        data = request.get_json()
        latitude = data.get("latitude")
        longitude = data.get("longitude")
        elevation = data.get("elevation")
        
        if latitude is None or longitude is None or elevation is None:
            return jsonify({"error": "Missing required parameters"}), 400

        # Create a DataFrame for prediction
        input_data = pd.DataFrame([[latitude, longitude, elevation]], columns=["LATITUDE", "LONGITUDE", "ELEVATION"])
        
        # Predict rainfall
        predicted_rainfall = model.predict(input_data)[0]

        return jsonify({"predicted_rainfall": float(predicted_rainfall)})
    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)
