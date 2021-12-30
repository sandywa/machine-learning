import cv2
import numpy
import glob
import csv
import numpy as np
#from PIL import Image


count = 1
for filename in glob.glob('C:/Users/acer/Pictures/NGEGAMBAR/*.jpg'): #assuming jpg
    myimg = cv2.imread(filename)
    avg_color_per_row = numpy.average(myimg, axis=0)
    avg_color = numpy.average(avg_color_per_row, axis=0)
    # color format is BGR not RGB, cv2 membaca gambar dalam format BGR.
    # print(avg_color)
    # save into 1 matrix
    if count == 1 :
        arr = np.array(avg_color)
        arr = np.hstack([avg_color,['satu']])
        count = 2
    else :
        row = np.array(avg_color)
        row = np.hstack([row,['satu']])
        arr = np.vstack([arr,row])
print("Hasilnya 1 : ")
print(arr)

count = 1
for filename in glob.glob('C:/Users/acer/Pictures/background/*.jpg'): #assuming jpg
    myimg = cv2.imread(filename)
    avg_color_per_row = numpy.average(myimg, axis=0)
    avg_color = numpy.average(avg_color_per_row, axis=0)
    # color format is BGR not RGB, cv2 membaca gambar dalam format BGR.
    # print(avg_color)
    # save into 1 matrix
    if count == 1 :
        arr2 = np.hstack([avg_color,['dua']])
        count = 2
    else :
        row = np.array(avg_color)
        row = np.hstack([row,['dua']])
        arr2 = np.vstack([arr2,row])
print("Hasilnya 2 : ")
print(arr2)

count = 1
for filename in glob.glob('C:/Users/acer/Pictures/BACKGROUND ZOOM/*.jpg'): #assuming jpg
    myimg = cv2.imread(filename)
    avg_color_per_row = numpy.average(myimg, axis=0)
    avg_color = numpy.average(avg_color_per_row, axis=0)
    # color format is BGR not RGB, cv2 membaca gambar dalam format BGR.
    # print(avg_color)
    # save into 1 matrix
    if count == 1 :
        arr3 = np.array(avg_color)
        arr3 = np.hstack([avg_color,['tiga']])
        count = 2
    else :
        row = np.array(avg_color)
        row = np.hstack([row,['tiga']])
        arr3 = np.vstack([arr3,row])
print("Hasilnya 3 : ")
print(arr3)

# menggabungkan semua data
dataset = np.vstack([arr,arr2])
dataset  = np.vstack([dataset,arr3])
print("Hasilnya Dataset : ")
print(dataset)

print("Save Dataset : ")
with open('dataset.csv', 'w', newline='') as file:
    mywriter = csv.writer(file, delimiter=',')
    mywriter.writerows(dataset)