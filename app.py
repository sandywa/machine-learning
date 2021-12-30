from flask import Flask, render_template, request

app = Flask(__name__)

@app.route('/')
def index():
	return render_template('index.php')

@app.route('/',methods=['POST'])
def getvalue():
	file = request.form['formFile']
	return render_template('index.php',fileDir = file)

if __name__ == '__main__':
	app.run(debug=True)