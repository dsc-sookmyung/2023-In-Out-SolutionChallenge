import pandas as pd
import re
from konlpy.tag import Okt
from soynlp.utils import DoublespaceLineCorpus
from soynlp.noun import LRNounExtractor_v2

# 데이터셋 로드
def get_csv_file(path):
    df = pd.read_csv(path)
    return df

# 특수기호, 숫자 제거
def clean_text(inputString):
  text_rmv = re.sub(r"[^\uAC00-\uD7A3a-zA-Z\s]", "", inputString)
  return text_rmv

# konlpy 형태소 사전을 기반으로 한국어 단어 추출
def get_nouns_from_konlpy(a_sentence):
    okt = Okt()
    noun_list = set(okt.nouns(a_sentence))
    return noun_list

# 명사리스트에 해당하는 텍스트내의 명사 빈도 세기
def count_nouns(noun_list, text):
    noun_counter = dict()
    
    for noun in noun_list:
        if noun not in noun_counter:
            noun_counter[noun] = text.count(noun)
        else:
            noun_counter[noun] += text.count(noun)
    
    return sorted(noun_counter.items(), key=lambda x: x[1], reverse=True)

# soynlp 기반으로 한국어 단어 추출
def get_nouns_from_konlpy(train_data_path):
    train_data = DoublespaceLineCorpus(train_data_path)

    nount_extractor = LRNounExtractor_v2()
    noun_list = nount_extractor.train_extract(train_data)
    return noun_list

# 텍스트 파일 열고, 공백/줄바꿈 기준으로 split해서 리스트 만들기
def open_file_and_get_list_type(stopword_path):
    stopword_list = []
    file = open(stopword_path, 'r', encoding='utf-8')
    for line in file:
        stopword_list += line.split()
    return stopword_list

# 태그 리스트에서 지워버리기
def remove_word_in_tag_list(remove_list, tag_list):
    for i in remove_list:
        if i in tag_list:
            tag_list.remove(i)
            
    return tag_list


# 자동화
def make_tag_list(script):
    
    # konlpy 형태소 사전을 기반으로 한국어 단어 추출
    ko_list = get_nouns_from_konlpy(script)

    
    # Stopword 제거
    stopword_list = open_file_and_get_list_type('stopwords.txt')
    new_ko_list = remove_word_in_tag_list(stopword_list, ko_list)


    # 한 글자가 너무 많아 명확한 산, 숲, 묘 세 개를 제외한 모든 한 글자 지워버리기
    save_word = ['산', '숲', '묘']
    sample_list = new_ko_list.copy()

    for i in sample_list:
        if len(i) <= 1 and i not in save_word:
            new_ko_list.remove(i)
            
    # 본문에 2번 이상 등장한 단어, 최대 10개 태그로 선정
    tag_list = count_nouns(new_ko_list, script)[:10]
    new_tag_list = list(filter(lambda x: x[1] >= 2, tag_list))
    
    return new_tag_list


def tag_only(script):
    return list(dict(make_tag_list(script)).keys())

def save_csv(path, df):
    df.to_csv(path, index=False)
    return None




### 실행 예제 ###

# 1. 데이터셋 로드하기
df = get_csv_file('Solution_Challege/final_data.csv')

# 2. 특수 기호, 숫자 제거하기
script = df['대본'].copy()
script = script.apply(clean_text)

# 3. konlpy 형태소 사전을 기반으로 한국어 단어 추출
ko_list = get_nouns_from_konlpy(script[0])

# 4. Stopword 제거
stopword_list = open_file_and_get_list_type('stopwords.txt')
new_ko_list = remove_word_in_tag_list(stopword_list, ko_list)

# 한 글자가 너무 많아 명확한 산, 숲, 묘 세 개를 제외한 모든 한 글자 지워버리기
save_word = ['산', '숲', '묘']
sample_list = new_ko_list.copy()

for i in sample_list:
    if len(i) <= 1 and i not in save_word:
        new_ko_list.remove(i)
        
# 5. 태그 점수 매기기
# 2번 이상 등장
tag_list = count_nouns(new_ko_list, script[0])
list(filter(lambda x: x[1] >= 2, tag_list))
# 세 글자 이상 높은 점수 주는 것 보다 두글자가 매우 많으므로 두글자면 -1하기




### 자동화 실행 예제 ###
make_tag_list(script[20])

df['태그'] = script.apply(make_tag_list)
