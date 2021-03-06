import numpy as np
from csv import reader
from sys import exit
from math import sqrt
from operator import itemgetter
from sklearn.metrics import accuracy_score


def load_data_set(filename):
    try:
        with open(filename, newline='') as DataSet:
            return list(reader(DataSet, delimiter=','))
    
    except FileNotFoundError as e:
        raise e
    
def convert_to_float(data_set):
    new_set = []
    try:
        for data in data_set:
            #set data dan set label hasil
            new_set.append([float(x) for x in data[:len(data)-1]] + [data[len(data)-1]])
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
    count = 1
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

            # Display prediction
            #print('The predicted class for sample ' + str(test_instance) + ' is : ' + classes[index])
            #print('Number of votes : ' + str(value) + ' out of ' + str(k))

            # hasil prediksi 
            prediksi = classes[index]

            # save prediction into matrix 
            if count == 1 :
                matrixPrediksi = np.array(prediksi)
                count = 2
            else :
                row = np.array(prediksi)
                matrixPrediksi = np.vstack([matrixPrediksi,row])

            # empty the distance list
            distances.clear()

    except Exception as e:
        print(e)

    return matrixPrediksi

def main():
    try:
        # get value of k
        k = int(input('Enter the value of k : '))

        # load the training 
        training_file = "data-training.csv"
        training_set = convert_to_float(load_data_set(training_file))
        
        # test data set
        test_file = "data-test.csv"
        test_set = convert_to_float(load_data_set(test_file))

        # Files Check
        if not training_set:
            print('Empty training set')

        elif not test_set:
            print('Empty test set')

        elif k > len(training_set):
            print('Expected number of neighbors is higher than number of training data instances')

        else:
            matrixPrediksi = knn(training_set, test_set, k)
            
            # convert to numpy array
            matrixTarget = np.squeeze(np.asarray(test_set))
            matrixTarget = matrixTarget[:,3]
            score = accuracy_score(matrixTarget, matrixPrediksi)
            print('--------------------------------------')
            print('Accuracy KNN : ', score)
            print('--------------------------------------')

    except ValueError as v:
        print(v)

    except FileNotFoundError:
        print('File not found')

if __name__ == '__main__':
    main()
