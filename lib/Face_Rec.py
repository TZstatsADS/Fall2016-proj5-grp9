# -*- coding: utf-8 -*-
import cv2
import os
import numpy

face_cascade = cv2.CascadeClassifier('G:/Columbia/STAT GR5243/project05/haarcascade_frontalface_default.xml')
face_side_cascade = cv2.CascadeClassifier('G:/Columbia/STAT GR5243/project05/haarcascade_profileface.xml')

img_path = "G:/Columbia/STAT GR5243/project05/poster 2015"
img_listing = os.listdir(img_path)

for file in img_listing:
    img = cv2.imread(img_path + '\\' + file)
    img_gray = cv2.imread(img_path + '\\' + file,0)
    img_flip = cv2.flip(img, 1)
    img_gray_flip = cv2.flip(img_gray, 1)
    faces_front = face_cascade.detectMultiScale(img_gray,scaleFactor=1.1,minNeighbors=5,minSize=(50,50))
    faces_side = face_side_cascade.detectMultiScale(img_gray,scaleFactor=1.1,minNeighbors=5,minSize=(50,50))
    faces_side_flip = face_side_cascade.detectMultiScale(img_gray_flip,scaleFactor=1.1,minNeighbors=5,minSize=(50,50))
    if len(faces_front) != 0:
        for (x, y, w, h) in faces_front:
            crop_img = img[y:(y + h), x:(x + w)]
            cv2.imwrite('G:/Columbia/STAT GR5243/project05/poster 2015 face/' + file[0:7] + '_front_' +str(numpy.where(faces_front==x)[0][0]) + '.jpg',crop_img)
    if len(faces_side) != 0:
        for (x, y, w, h) in faces_side:
            crop_img = img[y:(y + h), x:(x + w)]
            cv2.imwrite('G:/Columbia/STAT GR5243/project05/poster 2015 face/' + file[0:7] + '_side_' + str(numpy.where(faces_side==x)[0][0]) + '.jpg',crop_img)
    if len(faces_side_flip) != 0:
        for (x, y, w, h) in faces_side_flip:
            crop_img = img_flip[y:(y + h), x:(x + w)]
            cv2.imwrite('G:/Columbia/STAT GR5243/project05/poster 2015 face/' + file[0:7] + '_sideflip_' + str(numpy.where(faces_side_flip==x)[0][0]) + '.jpg',crop_img)

img = cv2.imread('G:/Columbia/STAT GR5243/project05/img004.jpg')
img_gray = cv2.imread('G:/Columbia/STAT GR5243/project05/img004.jpg',0)
faces = face_side_cascade.detectMultiScale(img_gray,scaleFactor=1.1,minNeighbors=5,minSize=(50,50))
for (x, y, w, h) in faces:
    cv2.rectangle(img, (x, y), (x+w, y+h), (0, 255, 0), 2)
cv2.imwrite('G:/Columbia/STAT GR5243/project05/sample08.jpg',img)
