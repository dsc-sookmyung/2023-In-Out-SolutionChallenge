from flask import Flask,render_template,request,redirect,url_for,g,session,Blueprint, jsonify
import json
import psycopg2
import psycopg2.extensions
import passage_retrieval_model
import os

search = Blueprint('search', __name__)

@search.route('/get_retrieval', methods=['POST'])
def get_retrieval():
    value = request.form['input']
    if value[0] == '#':
        print('This is Tag Search.')
        return tag_search(value[1:].strip())
    else:
        print('This is Normal Search.')
        return place_retrieval(value)
    
    
def tag_search(value):
    
    j_dict = {}
    i = 0

    DB_HOST = os.environ.get('DB_HOST')
    DB_DBNAME = os.environ.get('DB_DBNAME')
    DB_USER = os.environ.get('DB_USER')
    DB_PASSWORD = os.environ.get('DB_PASSWORD')
    DB_PORT = os.environ.get('DB_PORT')

    conn = psycopg2.connect(host=DB_HOST, dbname=DB_DBNAME, user=DB_USER, password=DB_PASSWORD, port=DB_PORT)
    
    with conn.cursor() as cur:
        cur.execute(f"""select DISTINCT p.place_id, p.place_name, p.address_name, p.address_num, p.info, p.category, p.picture
                    from place p
                    inner join
                    (select p_h.PLACE_ID, p_h.TAG_ID
                    FROM place_hashtag p_h
                    inner join
                    (select h.tag_id, h.data
                    from hashtag as h
                    where h.data like '%{value}%') t1
                    on p_h.TAG_ID = t1.tag_id) t2
                    on p.place_id = t2.place_id; """)
        for row in cur:
            j_dict[i] = {'place_id':row[0], 'place_name':row[1], 'address_name':row[2], 'address_num':row[3], 'info':row[4], 'category':row[5], 'picture':row[6]}
            i = i + 1
    print(len(j_dict))
    if len(j_dict) == 0:
        return f'"# {value}" 검색 결과 없음'
            
    return json.dumps(j_dict, ensure_ascii=False)


def place_retrieval(value):
        
    place_id = passage_retrieval_model.search_and_get_place_id(value)
    
    j_dict = {}
    i = 0
    DB_HOST = os.environ.get('DB_HOST')
    DB_DBNAME = os.environ.get('DB_DBNAME')
    DB_USER = os.environ.get('DB_USER')
    DB_PASSWORD = os.environ.get('DB_PASSWORD')
    DB_PORT = os.environ.get('DB_PORT')

    conn = psycopg2.connect(host=DB_HOST, dbname=DB_DBNAME, user=DB_USER, password=DB_PASSWORD, port=DB_PORT)
    with conn.cursor() as cur:
        cur.execute(f"""select place_id, place_name, address_name, address_num, info, category, picture
                    from place
                    where place_id in {tuple(place_id)};""")
        for row in cur:
            j_dict[i] = {'place_id':row[0], 'place_name':row[1], 'address_name':row[2], 'address_num':row[3], 'info':row[4], 'category':row[5], 'picture':row[6]}
            i = i + 1
    print(len(j_dict))
    if len(j_dict) == 0:
        return f'"# {value}" 검색 결과 없음'
            
    return json.dumps(j_dict, ensure_ascii=False)