import pandas as pd
from sklearn.preprocessing import LabelEncoder
from sklearn.tree import DecisionTreeRegressor
from sklearn.tree import export_text
import matplotlib.pyplot as plt

# Load the dataset using pandas
df = pd.read_csv("human_cognitive_performance.csv")

# Drop columns that are not useful for training the model. 
# 'User_ID' = just a unique identifier and no influence on the outcome.
# 'AI_Predicted_Score' = is a prediction so we don't want to include it in our new prediction.
# 'Reaction_Time' = is a measure of cognitive performance
# 'Memory_Test_Score' = is a measure of cognitive performance
# 'Age' = personal characteristic
# 'Gender' = personal characteristic
df = df.drop(columns=['User_ID', 'AI_Predicted_Score', 'Reaction_Time', 'Memory_Test_Score', 'Age', 'Gender'])

# Encode categorical features to convert them to numeric form so it can be interpreted properly.
label_encoders = {}
for col in ['Diet_Type', 'Exercise_Frequency']:
    le = LabelEncoder()
    df[col] = le.fit_transform(df[col]) # replaces the category to integer codes
    label_encoders[col] = le # store the encoders just in case the decoding is needed later

# Separate the features, x, from the actual target variable (the cognitive score), y.
x = df.drop(columns=['Cognitive_Score'])
y = df['Cognitive_Score']


# Train the decision three regressor on the entire dataset to extract the rules.
# Set to a max depth of 3 to avoid overfitting the data
# Set the random state to a random (constant) number to make the result consistent for each run.
model = DecisionTreeRegressor(max_depth=3, random_state=99)
model.fit(x, y)


# Identify how much each feature actually contributes to predicting the cognitive score
importances = model.feature_importances_
feature_names = x.columns
feature_importance_df = pd.DataFrame({
    'Feature': feature_names,
    'Importance': importances
}).sort_values(by='Importance', ascending=False)

# Print the importance of each feature.
print("Feature Importances:")
print(feature_importance_df)

# Plot the feature importances in a horizontal bar chart
# Helps to visualize which features are the most significant
plt.figure(figsize=(10, 6))
plt.barh(feature_importance_df['Feature'], feature_importance_df['Importance'])
plt.xlabel("Importance")
plt.title("Decision Tree of Feature Importances")
plt.gca().invert_yaxis()
plt.tight_layout()
plt.show()

# Print the generated rules used in the decision tree
print(export_text(model, feature_names=list(x.columns)))