######################################################
# Helper function to extract text from movie posters #
######################################################



# To count number of charaters and output one string
def ImageSting_count(img_path):
	# Load required packages
	from PIL import Image, ImageEnhance, ImageFilter
	from pytesseract import image_to_string

	# Open image
	im = Image.open(img_path)
	# Apply filter to increase contrast
	im = im.filter(ImageFilter.MedianFilter())
	# Image enhancers
	enhancer = ImageEnhance.Contrast(im)
	im = enhancer.enhance(2)
	# Extract string
	text = pytesseract.image_to_string(im)
	count = len(text)
	return count, text
