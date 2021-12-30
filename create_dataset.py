import cv2
import numpy
import glob
import numpy as np
#from PIL import Image

count = 1
for filename in glob.glob('C:/Users/acer/Pictures/background/*.jpg'): #assuming jpg
    myimg = cv2.imread(filename)
    avg_color_per_row = numpy.average(myimg, axis=0)
    avg_color = numpy.average(avg_color_per_row, axis=0)
    # color format is BGR not RGB, cv2 membaca gambar dalam format BGR.
    print(avg_color)
    # save into 1 matrix
    if count == 1 :
        arr = np.array(avg_color)
        count = 2
    else :
        row = np.array(avg_color)
        arr = np.vstack([arr,row])
print("Hasilnya : ")
print(arr)