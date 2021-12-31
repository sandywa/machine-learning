import cv2
import numpy
import glob
import csv
import numpy as np

# ------------- Data Klasifikasi 1
count = 1
for filename in glob.glob('C:/Users/acer/Documents/MATLAB/dataset/original_data_set/Test/freshapples/*.png'): #assuming jpg
    myimg = cv2.imread(filename)
    avg_color_per_row = numpy.average(myimg, axis=0)
    avg_color = numpy.average(avg_color_per_row, axis=0)
    # color format is BGR not RGB, cv2 membaca gambar dalam format BGR.
    # save into 1 matrix
    if count == 1 :
        arr = np.array(avg_color)
        arr = np.hstack([avg_color,['Apple']])
        count = 2
    else :
        row = np.array(avg_color)
        row = np.hstack([row,['Apple']])
        arr = np.vstack([arr,row])
print("Hasil Data 1 : ")
print(arr)

# ------------- Data Klasifikasi 2

count = 1
for filename in glob.glob('C:/Users/acer/Documents/MATLAB/dataset/original_data_set/Test/freshbanana/*.png'): #assuming jpg
    myimg = cv2.imread(filename)
    avg_color_per_row = numpy.average(myimg, axis=0)
    avg_color = numpy.average(avg_color_per_row, axis=0)
    # color format is BGR not RGB, cv2 membaca gambar dalam format BGR.
    # save into 1 matrix
    if count == 1 :
        arr2 = np.hstack([avg_color,['Banana']])
        count = 2
    else :
        row = np.array(avg_color)
        row = np.hstack([row,['Banana']])
        arr2 = np.vstack([arr2,row])
print("Hasil Data 2 : ")
print(arr2)


# ------------- Data Klasifikasi 3

count = 1
for filename in glob.glob('C:/Users/acer/Documents/MATLAB/dataset/original_data_set/Test/freshoranges/*.png'): #assuming jpg
    myimg = cv2.imread(filename)
    avg_color_per_row = numpy.average(myimg, axis=0)
    avg_color = numpy.average(avg_color_per_row, axis=0)
    # color format is BGR not RGB, cv2 membaca gambar dalam format BGR.
    # save into 1 matrix
    if count == 1 :
        arr3 = np.array(avg_color)
        arr3 = np.hstack([avg_color,['Orange']])
        count = 2
    else :
        row = np.array(avg_color)
        row = np.hstack([row,['Orange']])
        arr3 = np.vstack([arr3,row])
print("Hasil Data 3 : ")
print(arr3)

# Menggabungkan semua data menjadi 1 matrix utuh
dataset = np.vstack([arr,arr2])
dataset  = np.vstack([dataset,arr3])
print("Hasil Dataset : ")
print(dataset)

print("Save Dataset : ")
nameFile = str(input('Input nama file : '))
nameFile = nameFile + '.csv'
with open(nameFile, 'w', newline='') as file:
    mywriter = csv.writer(file, delimiter=',')
    mywriter.writerows(dataset)
print("Dataset Tersimpan dengan nama : " + nameFile)