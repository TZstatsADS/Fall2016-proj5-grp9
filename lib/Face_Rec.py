# -*- coding: utf-8 -*-
import cv2
import os
import numpy


wd = 'C:/Users/Qing/Documents/GitHub/Fall2016-proj5-grp9'


def face_det(path_haar, path_read, path_write, path_write_face):
    face_cascade = cv2.CascadeClassifier(path_haar + '\\' + 'haarcascade_frontalface_default.xml')
    face_side_cascade = cv2.CascadeClassifier(path_haar + '\\' + 'haarcascade_profileface.xml')
    
    img_listing = os.listdir(path_read)
    for file in img_listing:
        img = cv2.imread(path_read + '\\' + file)
        img_side = cv2.imread(path_read + '\\' + file)
        img_gray = cv2.imread(path_read + '\\' + file, 0)
        img_flip = cv2.flip(img, 1)
        img_gray_flip = cv2.flip(img_gray, 1)
        faces_front = face_cascade.detectMultiScale(img_gray, scaleFactor = 1.1, minNeighbors = 5, minSize = (50,50))
        faces_side = face_side_cascade.detectMultiScale(img_gray, scaleFactor = 1.1, minNeighbors = 5, minSize = (50,50))
        faces_side_flip = face_side_cascade.detectMultiScale(img_gray_flip, scaleFactor = 1.1, minNeighbors = 5, minSize = (50,50))
        if len(faces_front) != 0:
            for (x, y, w, h) in faces_front:
                crop_img = img[y:(y + h), x:(x + w)]
                cv2.imwrite(path_write_face + '\\' + file + '_front_' +str(numpy.where(faces_front==x)[0][0]) + '.jpg', crop_img)
                cv2.rectangle(img, (x, y), (x+w, y+h), (0, 255, 0), 2)
        if len(faces_side) != 0:
            for (x, y, w, h) in faces_side:
                crop_img = img_side[y:(y + h), x:(x + w)]
                cv2.imwrite(path_write_face + '\\' + file + '_side_' + str(numpy.where(faces_side==x)[0][0]) + '.jpg', crop_img)
                cv2.rectangle(img, (x, y), (x+w, y+h), (0, 255, 0), 2)
        if len(faces_side_flip) != 0:
            for (x, y, w, h) in faces_side_flip:
                crop_img = img_flip[y:(y + h), x:(x + w)]
                cv2.imwrite(path_write_face + '\\' + file + '_sideflip_' + str(numpy.where(faces_side_flip==x)[0][0]) + '.jpg', crop_img)
        cv2.imwrite(path_write + '\\' + 'sample' + file + '.jpg', img)

face_det(wd+'/lib',
         wd+'/data/image_read_test',
         wd+'/output/image_write_test',
         wd+'/output/image_write_face_test')