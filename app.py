import os
import cv2
import numpy
from flask import Flask, render_template, request, send_from_directory
from csv import reader
from sys import exit
from math import sqrt
from operator import itemgetter


app = Flask(__name__)
app.config['UPLOAD_FOLDER'] = './static/'

def load_data_set(filename):
    try:
        with open(filename, newline='') as iris:
            return list(reader(iris, delimiter=','))
    except FileNotFoundError as e:
        raise e


def convert_to_float(data_set, mode):
    new_set = []
    try:
        if mode == 'training':
            for data in data_set:
                new_set.append([float(x) for x in data[:len(data)-1]] + [data[len(data)-1]])

        elif mode == 'test':
            for data in data_set:
                new_set.append([float(x) for x in data])

        else:
            print('Invalid mode, program will exit.')
            exit()

        return new_set

    except ValueError as v:
        print(v)
        print('Invalid data set format, program will exit.')
        exit()


def get_classes(training_set):
    return list(set([c[-1] for c in training_set]))


def find_neighbors(distances, k):
    return distances[0:k]


def find_response(neighbors, classes):
    votes = [0] * len(classes)

    for instance in neighbors:
        for ctr, c in enumerate(classes):
            if instance[-2] == c:
                votes[ctr] += 1

    return max(enumerate(votes), key=itemgetter(1))


def knn(training_set, test_set, k):
    distances = []
    dist = 0
    limit = len(training_set[0]) - 1

    # generate response classes from training data
    classes = get_classes(training_set)

    try:
        for test_instance in test_set:
            for row in training_set:
                for x, y in zip(row[:limit], test_instance):
                    dist += (x-y) * (x-y)
                distances.append(row + [sqrt(dist)])
                dist = 0

            distances.sort(key=itemgetter(len(distances[0])-1))

            # find k nearest neighbors
            neighbors = find_neighbors(distances, k)

            # get the class with maximum votes
            index, value = find_response(neighbors, classes)

            return classes[index]

            # Display prediction
            print('The predicted class for sample ' + str(test_instance) + ' is : ' + classes[index])
            print('Number of votes : ' + str(value) + ' out of ' + str(k))

            # empty the distance list
            distances.clear()

    except Exception as e:
        print(e)

@app.route('/', methods=['GET' , 'POST'])
def index():
    if request.method == 'POST':
        if request.files:
            image = request.files['image']
            img_path = os.path.join(app.config['UPLOAD_FOLDER'],image.filename)
            image.save(img_path)
            # get value of k
            k = 5

            # load the training and test data set
            training_file = "data-training.csv"
            training_set = convert_to_float(load_data_set(training_file), 'training')

            # Image Target
            filename = img_path
            myimg = cv2.imread(filename)
            avg_color_per_row = numpy.average(myimg, axis=0)
            avg_color = numpy.average(avg_color_per_row, axis=0)
            test_set = [avg_color]

            # Files Check
            if not training_set:
                print('Empty training set')

            elif not test_set:
                print('Empty test set')

            elif k > len(training_set):
                print('Expected number of neighbors is higher than number of training data instances')

            else:
                #test_data = [4.3, 2.9, 1.7, 0.3]
                hasil = knn(training_set, test_set, k)

            return render_template('index.html',fileDir=hasil,img_path = image.filename)

    return render_template('index.html', fileDir='./static/default.jpeg')

if __name__ == '__main__':
    app.run(debug=True)