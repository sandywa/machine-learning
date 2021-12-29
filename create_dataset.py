import cv2
import numpy
from PIL import Image
import glob
image_list = []
for filename in glob.glob('C:/Users/acer/Pictures/background/*.jpg'): #assuming jpg
    myimg = cv2.imread(filename)
    avg_color_per_row = numpy.average(myimg, axis=0)
    avg_color = numpy.average(avg_color_per_row, axis=0)
    #color format is BGR not RGB, cv2 membaca gambar dalam format BGR.
    print(avg_color)