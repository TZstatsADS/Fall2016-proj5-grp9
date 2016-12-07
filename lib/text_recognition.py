######################################################
# Helper function to extract text from movie posters #
######################################################

import sys
import cv2
import numpy as np
import pandas as pd
from PIL import Image, ImageEnhance, ImageFilter
from pytesseract import image_to_string



wd = "C:/Users/Qing/Documents/GitHub/Fall2016-proj5-grp9"



inputpath = wd + '/data/test_images'
from os import listdir
from os.path import isfile, join
name_list = [f for f in listdir(inputpath) if isfile(join(inputpath, f)) and f.endswith('.jpg')]

for i in range(1,len(name_list)):
    
    test_id = name_list[i][0:len(name_list[i])-4]

    # To count number of charaters and output one string
    def ImageSting_count(img_path):
        # Open image
        im = Image.open(img_path)
        ip = img_path
        # Image enhancers
        enhancer = ImageEnhance.Contrast(im)
        im = enhancer.enhance(1)
        # Extract string
        text = pytesseract.image_to_string(im)
        count = len(text)
        return count, text, ip


    def preprocess(gray):
        sobel = cv2.Sobel(gray, cv2.CV_8U, 1, 0, ksize = 3)
        # make it binary
        ret, binary = cv2.threshold(sobel, 0, 255, cv2.THRESH_OTSU+cv2.THRESH_BINARY)

        # Construct element
        element1 = cv2.getStructuringElement(cv2.MORPH_RECT, (30, 9))
        element2 = cv2.getStructuringElement(cv2.MORPH_RECT, (24, 6))

        # remove details
        dilation = cv2.dilate(binary, element2, iterations = 1)
        erosion = cv2.erode(dilation, element1, iterations = 1)
        dilation2 = cv2.dilate(erosion, element2, iterations = 3)

        # save intermediate pictures 
        #cv2.imwrite(wd+"/output/text_detection/"+test_id+"_binary.png", binary)
        #cv2.imwrite(wd+"/output/text_detection/"+test_id+"_dilation.png", dilation)
        #cv2.imwrite(wd+"/output/text_detection/"+test_id+"_erosion.png", erosion) 
        #cv2.imwrite(wd+"/output/text_detection/"+test_id+"_dilation2.png", dilation2)

        return dilation2

    def findTextRegion(img):
        region = []

        # Find boxes
        img2, contours, hierarchy = cv2.findContours(img, cv2.RETR_TREE, cv2.CHAIN_APPROX_SIMPLE)

        for i in range(len(contours)):
            cnt = contours[i]
            # Area
            area = cv2.contourArea(cnt) 

            if(area < 1000):
                continue

            epsilon = 0.001 * cv2.arcLength(cnt, True)
            approx = cv2.approxPolyDP(cnt, epsilon, True)
            rect = cv2.minAreaRect(cnt)
            print("rect is: ")
            print(rect)

            # four corners
            box = cv2.boxPoints(rect)
            box = np.int0(box)

            # calculate height and width
            height = abs(box[0][1] - box[2][1])
            width = abs(box[0][0] - box[2][0])

            if(height > width * 1.2):
                continue

            region.append(box)

        return region


    def get_num_pixels(img):
        width, height = Image.open(img).size
        return width*height

    def percentage_text(img):
        region = []
        barea = []
        # Total amount of pixels
        total_px = get_num_pixels(img)
        # Gray
        gray = cv2.imread(img,0)

        # Shape
        dilation = preprocess(gray)
        # Find boxes
        img2, contours, hierarchy = cv2.findContours(dilation, cv2.RETR_TREE, cv2.CHAIN_APPROX_SIMPLE)

        for i in range(len(contours)):
            cnt = contours[i]
            # Area
            area = cv2.contourArea(cnt) 

            if(area < 1000):
                continue

            epsilon = 0.001 * cv2.arcLength(cnt, True)
            approx = cv2.approxPolyDP(cnt, epsilon, True)
            rect = cv2.minAreaRect(cnt)
            #print "rect is: "
            #print rect

            # four corners
            box = cv2.boxPoints(rect)
            box = np.int0(box)

            # calculate height and width
            height = abs(box[0][1] - box[2][1])
            width = abs(box[0][0] - box[2][0])

            if(height > width * 1.2):
                continue
            barea.append(height*width)

        total_area = sum(barea)

        a = pd.DataFrame([float(total_area)/float(total_px)])

        a.to_csv('C:/Users/Qing/Documents/GitHub/Fall2016-proj5-grp9/output/test_detection'+"\\"+test_id+"_text.csv")

    def detect(img):
        # Gray
        gray = cv2.imread(img,0)

        # Shape
        dilation = preprocess(gray)

        # find text regions
        region = findTextRegion(dilation)


        d = cv2.imread(img)

        # Draw lines to form boxes
        for box in region:
            cv2.drawContours(d, [box], 0, (0, 255, 0), 2)

        #cv2.namedWindow("img", cv2.WINDOW_NORMAL)
        #cv2.imshow("img", d)

        cv2.imwrite('C:/Users/Qing/Documents/GitHub/Fall2016-proj5-grp9/output/test_detection'+"\\"+test_id+"_contours.png", d)

        #cv2.waitKey(0)
        #cv2.destroyAllWindows()

    detect(img = wd+"/data/test_images/"+test_id+".jpg")
    percentage_text(img = wd+"/data/test_images/"+test_id+".jpg")

