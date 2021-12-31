from flask import Flask, render_template, request, send_from_directory
import os


app = Flask(__name__)
app.config['UPLOAD_FOLDER'] = './static/uploads/'

@app.route('/', methods=['GET' , 'POST'])
def index():
	if request.method == 'POST':
		if request.files:
			image = request.files['image']
			img_path = os.path.join(app.config['UPLOAD_FOLDER'],image.filename)
			image.save(img_path)
			return render_template('index.html',fileDir=img_path)

	return render_template('index.html')

if __name__ == '__main__':
	app.run(debug=True)