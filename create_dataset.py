import cv2
import numpy
myimg = cv2.imread('image.jpg')
avg_color_per_row = numpy.average(myimg, axis=0)
avg_color = numpy.average(avg_color_per_row, axis=0)
#color format is BGR not RGB, cv2 membaca gambar dalam format BGR.
print(avg_color)