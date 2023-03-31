from flask import Flask,render_template,request,redirect,url_for,g,session, make_response, jsonify, json
from search_api import search
import passage_retrieval_model


app = Flask(__name__)
app.register_blueprint(search)
passage_retrieval_model.main()


@app.route('/')
def select():
    return render_template('tag_test.html')

 
if __name__ == "__main__":
    app.run(debug=True)
