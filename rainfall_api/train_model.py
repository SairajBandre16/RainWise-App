import pandas as pd
import numpy as np
import pickle
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestRegressor
from sklearn.metrics import mean_absolute_error, r2_score

# Load dataset
dataset_path = "rainfall_api/santacruzdataset.csv"
df = pd.read_csv(dataset_path)

# Ensure necessary columns are present
required_columns = ["LATITUDE", "LONGITUDE", "ELEVATION", "PRCP"]
if not all(col in df.columns for col in required_columns):
    raise ValueError("Dataset must contain latitude, longitude, elevation, and rainfall columns.")

# Handle missing values
df = df.dropna(subset=["PRCP"])  # Remove rows where PRCP is NaN

# Features and target
X = df[["LATITUDE", "LONGITUDE", "ELEVATION"]]
y = df["PRCP"]

# Split data into training and testing sets
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Train model
model = RandomForestRegressor(n_estimators=100, random_state=42)
model.fit(X_train, y_train)

# Evaluate model
y_pred = model.predict(X_test)
mae = mean_absolute_error(y_test, y_pred)
r2 = r2_score(y_test, y_pred)
print(f"Model Performance: MAE = {mae:.2f}, R^2 = {r2:.2f}")

# Save the trained model
model_path = "rainfall_api/rainfall_model.pkl"
with open(model_path, "wb") as model_file:
    pickle.dump(model, model_file)

print(f"Model saved to {model_path}")
