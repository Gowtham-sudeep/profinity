import pandas as pd
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.calibration import CalibratedClassifierCV
from sklearn.svm import LinearSVC
from sklearn.externals import joblib

data = pd.read_csv('clean_data.csv')
texts = data['text'].astype(str)
y = data['is_offensive']

vectorizer = CountVectorizer(stop_words='english', min_df=0.0001)
X = vectorizer.fit_transform(texts)

model = LinearSVC(class_weight="balanced", dual=False, tol=1e-2, max_iter=1e5)
cclf = CalibratedClassifierCV(base_estimator=model)
cclf.fit(X, y)

joblib.dump(vectorizer, 'vectorizer.joblib')
joblib.dump(cclf, 'model.joblib') 
