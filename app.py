from flask import Flask, render_template, request

app = Flask(__name__)

@app.route('/')
def index():
	return render_template('index.html')

@app.route('/',methods=['POST'])
def getvalue():
	file = request.form['formFile']
	return render_template('index.html',fileDir = file)

if __name__ == '__main__':
	app.run(debug=True)