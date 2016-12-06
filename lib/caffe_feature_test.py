
# coding: utf-8

# ### 0. Input
# 
# * caffepath indicates the root path of the `caffe` package
# * inputpath indicates the folder which saves all the training images
# * inputpath_test indicates the folder which saves all the testing images
# * outputpath indicates the foler which the features extracted should be saved in

# In[1]:

caffepath = '/Users/YaqingXie/caffe'
inputpath = '/Users/YaqingXie/Desktop/3-Applied Data Science/Fall2016-proj5-grp9/data/test_images'
outputpath = '/Users/YaqingXie/Desktop/3-Applied Data Science/Fall2016-proj5-grp9/data/'


# ### 1. Setup
# 
# * First, set up Python, `numpy`, `panda`, `datetime` and `matplotlib`.

# In[2]:

# set up Python environment: numpy for numerical routines, and matplotlib for plotting
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
import datetime
# display plots in this notebook
get_ipython().magic('matplotlib inline')

# set display defaults
plt.rcParams['figure.figsize'] = (10, 10)        # large images
plt.rcParams['image.interpolation'] = 'nearest'  # don't interpolate: show square pixels
plt.rcParams['image.cmap'] = 'gray'  # use grayscale output rather than a (potentially misleading) color heatmap


# * Load `caffe`.

# In[3]:

# The caffe module needs to be on the Python path;
#  we'll add it here explicitly.
import sys

if not caffepath.endswith('/'):
    caffepath = caffepath + '/'
if not inputpath.endswith('/'):
    inputpath = inputpath + '/'
# if not inputpath_test.endswith('/'):
#     inputpath_test = inputpath_test + '/'
if not outputpath.endswith('/'):
    outputpath = outputpath + '/'

caffe_root = caffepath
sys.path.insert(0, caffe_root + 'python')

import caffe


# * If needed, download the reference model ("CaffeNet", a variant of AlexNet).

# In[4]:

import os
if os.path.isfile(caffe_root + 'models/bvlc_reference_caffenet/bvlc_reference_caffenet.caffemodel'):
    print('CaffeNet found.')
else:
    print('Downloading pre-trained CaffeNet model...')
    get_ipython().system('../scripts/download_model_binary.py ../models/bvlc_reference_caffenet')


# ### 2. Load net and set up input preprocessing
# 
# * Set Caffe to CPU mode and load the net from disk.

# In[5]:

caffe.set_mode_cpu()

model_def = caffe_root + 'models/bvlc_reference_caffenet/deploy.prototxt'
model_weights = caffe_root + 'models/bvlc_reference_caffenet/bvlc_reference_caffenet.caffemodel'

net = caffe.Net(model_def,      # defines the structure of the model
                model_weights,  # contains the trained weights
                caffe.TEST)     # use test mode (e.g., don't perform dropout)


# * Set up input preprocessing. (We'll use Caffe's `caffe.io.Transformer` to do this, but this step is independent of other parts of Caffe, so any custom preprocessing code may be used).
# 
#     Our default CaffeNet is configured to take images in BGR format. Values are expected to start in the range [0, 255] and then have the mean ImageNet pixel value subtracted from them. In addition, the channel dimension is expected as the first (_outermost_) dimension.
#     
#     As matplotlib will load images with values in the range [0, 1] in RGB format with the channel as the _innermost_ dimension, we are arranging for the needed transformations here.

# In[6]:

# load the mean ImageNet image (as distributed with Caffe) for subtraction
mu = np.load(caffe_root + 'python/caffe/imagenet/ilsvrc_2012_mean.npy')
mu = mu.mean(1).mean(1)  # average over pixels to obtain the mean (BGR) pixel values
print('mean-subtracted values:', zip('BGR', mu))

# create transformer for the input called 'data'
transformer = caffe.io.Transformer({'data': net.blobs['data'].data.shape})

transformer.set_transpose('data', (2,0,1))  # move image channels to outermost dimension
transformer.set_mean('data', mu)            # subtract the dataset-mean value in each channel
transformer.set_raw_scale('data', 255)      # rescale from [0, 1] to [0, 255]
transformer.set_channel_swap('data', (2,1,0))  # swap channels from RGB to BGR


# In[7]:

# set the size of the input (we can skip this if we're happy
#  with the default; we can also change it later, e.g., for different batch sizes)
net.blobs['data'].reshape(1,        # batch size
                          3,         # 3-channel (BGR) images
                          227, 227)  # image size is 227x227


# ### 3. Training Feature Extraction

# Note:
# + The more layers we extract, the better result we can get. 
# + Considering time efficiency, here we run layer Norm1 and Conv3 only. 
# + For more layers, please refer to Caffe_Features -> Feature_Extraction.ipynb

# In[8]:

from os import listdir
from os.path import isfile, join
name_list = [f for f in listdir(inputpath) if isfile(join(inputpath, f)) and f.endswith('.jpg')]
# name_list_test = [f for f in listdir(inputpath_test) if isfile(join(inputpath_test, f)) and f.endswith('.jpg')]


# * Layer norm1 dimensions: (1, 96, 27, 27) [69984 values]

# In[ ]:

#training
a = datetime.datetime.now()
i = 0
image = caffe.io.load_image(str(inputpath + name_list[i]))
net.blobs['data'].data[...] = transformer.preprocess('data', image)
net.forward()
feature1 = np.reshape(net.blobs['norm1'].data[0], 69984, order='C')
for name in name_list[1:]:
    image = caffe.io.load_image(str(inputpath + name))
    net.blobs['data'].data[...] = transformer.preprocess('data', image)
    net.forward()
    feature1 = np.vstack([feature1,np.reshape(net.blobs['norm1'].data[0], 69984, order='C')])
    #i += 1
b = datetime.datetime.now()
print(b-a)
print('Feature extraction finished.')


# * Layer conv3 dimensions: (1, 384, 13, 13) [64896 values]

# In[ ]:

#training
a = datetime.datetime.now()
i = 0
image = caffe.io.load_image(str(inputpath + name_list[i]))
net.blobs['data'].data[...] = transformer.preprocess('data', image)
net.forward()
feature3 = np.reshape(net.blobs['conv3'].data[0], 64896, order='C')
for name in name_list[1:]:
    image = caffe.io.load_image(str(inputpath + name))
    net.blobs['data'].data[...] = transformer.preprocess('data', image)
    net.forward()
    feature3 = np.vstack([feature3,np.reshape(net.blobs['conv3'].data[0], 64896, order='C')])
    #i += 1
b = datetime.datetime.now()
print(b-a)
print('Feature extraction finished.')


# In[ ]:

# data_norm1 = pd.DataFrame(feature1)
data_conv3 = pd.DataFrame(feature3)
# data_norm1_with_name = pd.concat([pd.DataFrame(name_list),pd.DataFrame(data_norm1)], axis=1)
# pd.DataFrame(data_norm1_with_name).to_csv(outputpath + 'test_norm1.csv', index=False)
data_conv3_with_name = pd.concat([pd.DataFrame(name_list),pd.DataFrame(data_conv3)], axis=1)
pd.DataFrame(data_conv3_with_name).to_csv(outputpath + 'test_features.csv', index=False)

