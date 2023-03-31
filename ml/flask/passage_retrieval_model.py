import re
import pandas as pd
import numpy as np
from konlpy.tag import Okt
from sklearn.feature_extraction.text import TfidfVectorizer
# import joblib
# import pickle

# def save_joblib(data, path_file_name):
#     joblib.dump(data, path_file_name)
#     return 'success to save'

# def load_joblib(path_file_name):
#     loaded_model = joblib.load(path_file_name)
#     return loaded_model

# 특수기호, 숫자 제거
def clean_text(inputString):
    text_rmv = re.sub(r"[^\uAC00-\uD7A3a-zA-Z\s]", "", inputString)
    return text_rmv

def tokenizer_func(string):
    okt = Okt()
    return okt.morphs(string)

def get_sp_matrix_and_vectorizer_from_TfidfVectorizer(corpus, tokenizer_func, ngram_range):
    vectorizer = TfidfVectorizer(tokenizer=tokenizer_func, ngram_range=ngram_range)
    vectorizer.fit(corpus)
    sp_matrix = vectorizer.transform(corpus)
    return vectorizer, sp_matrix
    
# def get_corpus_Tfidf_score_df(vectorizer, sp_matrix, idx):
#     df = pd.DataFrame(sp_matrix[idx].T.todense(), index=vectorizer.get_feature_names_out(), columns=["TF-IDF"])
#     df = df.sort_values('TF-IDF', ascending=False)
#     return df

def search_and_get_place_id(query_string):
    global vectorizer, sp_matrix
    query_vec = vectorizer.transform([query_string])
    result = query_vec * sp_matrix.T
    
    sorted_result = np.argsort(-result.data)
    # doc_scores = result.data[sorted_result]
    doc_ids = result.indices[sorted_result]
    place_id = doc_ids + 1
    return place_id

    


############ 실행 예제 ############

# if __name__ == "__main__":
    
    ###### V1: Tfidf 직접 fit_transform하여 place_id 받기 ######

# 1. corpus 로드하기
def main():
    corpus = pd.read_csv('flask/data_with_tag.csv')['대본']

    # 2. 특수 기호, 숫자 제거하기
    corpus = corpus.apply(clean_text)
    corpus = list(corpus)

    # Tfidf Tokenizing 하기
    global vectorizer, sp_matrix
    vectorizer, sp_matrix = get_sp_matrix_and_vectorizer_from_TfidfVectorizer(corpus=corpus, tokenizer_func=tokenizer_func, ngram_range=(1,2))
    return "success"

    # # vectorizer, sp_matrix를 pickle 형태로 저장하기
    # save_joblib(vectorizer, 'vectorizer_model')
    # save_joblib(sp_matrix, 'sp_matrix')

    # # 특정 corpus에 해당하는 Tfidf 점수 데이터셋 얻기
    # Tfidf_score_df = get_corpus_Tfidf_score_df(vectorizer, sp_matrix, idx=9)
    # place_id, doc_scores = search_and_get_place_id_and_doc_scores(query_string='숲', vectorizer=vectorizer, places_sp_matrix=sp_matrix)


    # ###### V2: pickle 로드하여 place_id 받기 ######
    # place_id = pr.search_and_get_place_id(query_string='휴식할만한 곳')
