#!/usr/bin/python

import requests
import urllib
import os.path
import string
import sys
import re

# A basic script to help you download all the assets related to an item, e.g., all the pages in a public domain book or all the sheets of a map, etc.
# Just plug in the UUID for the item that you find on the Digital Collections item page

#Aside from the modules above, you'll need to get an API key for the NYPL metadata API
#API key available here: http://api.repo.nypl.org/sign_up

#Paste the API token you got via email
token = 'INSERT_API_TOKEN'

#Set UUID for the item you want to get the captures of
uuid = 'INSERT_UUID'

#Setting the derivative type -- these are the possible deriv type values:
    # b - Center cropped thumbnail .jpeg (100x100 pixels)
    # f - Cropped .jpeg (140 pixels tall with variable width)
    # t - Cropped .gif (150 pixels on the long side)
    # r - Cropped .jpeg (300 pixels on the long side)
    # w - Cropped .jpeg (760 pixels on the long side)
    # q - Cropped .jpeg (1600 pixels on the long side) N.B. Exists only for public domain assets
    # v - Cropped .jpeg (2560 pixels on the long side) N.B. Exists only for public domain assets
    # g - a "full-size" .jpeg derivative N.B. Exists only for public domain assets
#Set the deriv type that you want to pull here
deriv_type = "q".lower()

######

# Setting up some baselines here
api_base = 'http://api.repo.nypl.org/api/v1/'
img_url_base = "http://images.nypl.org/index.php?id="
captures = []

#functions to get captures for a given UUID depending on whether it's a capture, item, or a container/collection
def getCaptures(uuid):
    url = api_base + 'items/' + uuid + '?withTitles=yes&per_page=100'
    call = requests.get(url, headers={'Authorization ':'Token token=' + token})
    return call.json()

def getItem(uuid):
	url = api_base + 'items/mods/' + uuid + '?per_page=100'
	call = requests.get(url, headers={'Authorization':'Token token=' + token}) 
	return call.json()

def getContainer(uuid):
	url = api_base + '/collections/' + uuid + '?per_page=100'
	call = requests.get(url, headers={'Authorization':'Token token=' + token}) 
	return call.json()

captureResponse = getCaptures(uuid)
itemResponse = getItem(uuid)
containerResponse = getContainer(uuid)

isContainer = int(containerResponse['nyplAPI']['response']['numItems'])
number_of_captures = int(captureResponse['nyplAPI']['response']['numResults'])

#######

#Let's get started!

#Make sure it's a valid UUID
if re.search(r'([^a-f0-9-])', uuid) or len(uuid) != 36:
	sys.exit("That doesn't look like a correct UUID -- try again!")
else:
	print "OK, that ID is well formed, looking it up now..."

#Check to make sure we don't accidentally have a container or a collection UUID here
if isContainer > 0 and number_of_captures > 0:
	sys.exit("This is a container, this script is meant to pull images from single items only.")
#If we're good to go, either get the number of capture IDs, or go to the item UUID and get the # of captures there
else:
	print "Yep, this is a usable UUID, let's see what we can do with it..."
	if number_of_captures > 0: 
		print "%s captures total" % (number_of_captures)
		print uuid
	else:
		print "No captures in the API response! Trying to see if this is a capture UUID, not an item UUID..."
		uuid = getItem(uuid)['nyplAPI']['response']['mods']['identifier'][-1]['$']
		captureBase = api_base + 'items/' + uuid + '?withTitles=yes&per_page=200'
		itemResponse = getCaptures(uuid)
		number_of_captures = int(itemResponse['nyplAPI']['response']['numResults'])
		print "Correct item UUID is "+uuid
		print "Item UUID has %s capture(s) total" % (number_of_captures)

#Check to see if the requested derivs exist for that item ID (applies mostly to conditional derivs q,v, and g which only exist for public domain items)
high_res_captures = getCaptures(uuid)['nyplAPI']['response']['capture'][0]['imageLinks']['imageLink']

if ('t=' + deriv_type) in str(high_res_captures):
	print "Good news! This item has the type of captures you've requested..."
else:
	sys.exit("The %s derivs for this item are missing; if you're looking for high-res derivs, make sure this is a public domain item?" % deriv_type)

#OK, enough checking, let's get the actual captures!
for i in range(number_of_captures):
	captureID = itemResponse['nyplAPI']['response']['capture'][i]['imageID']
	captures.append(captureID)

#Grab the item title, and do some cleanup to make it usable as a folder name
table = string.maketrans("","")
title = str(itemResponse['nyplAPI']['response']['capture'][0]['title']).translate(table, string.punctuation).replace("  "," ").replace(" ","_")
title = title[:65].rpartition('_')[0]
print "folder title will be '"+title+"'"

#Create folder based on the item title
if not os.path.exists(title):
    os.makedirs(title)

# #Create the kind of deriv in the item-title folder
for i in range(number_of_captures):
	if not os.path.isfile(title+'/'+str(captures[i])+deriv_type+'.jpg'):
		urllib.urlretrieve(img_url_base+str(captures[i])+'&t='+deriv_type,title+'/'+str(captures[i])+deriv_type+'.jpg')
		print captures[i], deriv_type, i+1, "of", number_of_captures
		i+=1
	else:
		print "file %s as %s deriv type already exists" % (captures[i], deriv_type)
		i+=1