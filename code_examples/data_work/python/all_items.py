#!/usr/bin/env python3

import json

item_files = ['pd_items_1.json','pd_items_2.json','pd_items_3.json']
all_items = []


#load each file into one big list
for item_file in item_files:
	print("Loading",item_file)
	with open("../../items/" + item_file) as open_file:

		for line in open_file:

			all_items.append(json.loads(line))




for item in all_items:

	#lets print everything possible in the item!

	#the uuid is the unique identifier for the item
	print(item['UUID'])

	#the databaseID is another identifier for the item use in our database
	print(item['databaseID'])

	#the title of the item, there can only be one title
	print(item['title'])

	#there can be multiple 0 or more alternative titles
	for alt_title in item['alternativeTitle']:

		print(alt_title)

	#contributor is a dictonary with these possible keys
	for contributor in item['contributor']:

		#the name
		print(contributor['contributor'])

		#the type, person, corporation, etc
		print(contributor['contributorType'])

		#the role they had in this item, such as author,Printmaker, Illustrator etc.
		for role in contributor['contributorRole']:
			print(role)

		#Their URI, a linked data identifier
		print(contributor['contributorURI'])

	#the dates associated with this item
	for date in item['date']:
		print (date)

	#the "start" year of this item
	print(item['dateStart'])

	#the "end" year of this item
	print(item['dateEnd'])

	#the languages for this item
	for language in item['language']:
		print (language)

	#the description for this item
	for description in item['description']:
		print (description)

	#the notes can have:
	for note in item['note']:

		#the type of the note
		print(note['type'])

		#and the text of the note
		print(note['text'])


	#the subject headings of the item can have:
	for subject_topical in item['subjectTopical']:

		#the text of the subject
		print(subject_topical['text'])

		#and the URI, or linked data identifier
		print(subject_topical['URI'])


	for subject_name in item['subjectName']:
		print(subject_name['text'])
		print(subject_name['URI'])

	for subject_geographic in item['subjectGeographic']:
		print(subject_geographic['text'])
		print(subject_geographic['URI'])

	for subject_temporal in item['subjectTemporal']:
		print(subject_temporal['text'])
		print(subject_temporal['URI'])


	for subject_title in item['subjectTitle']:
		print(subject_title['text'])
		print(subject_title['URI'])

	#the resource types for the item
	for resource_type in item['resourceType']:
		print (resource_type)

	#the genres for the item
	for genre in item['genre']:
		print(genre['text'])
		print(genre['URI'])


	#bNumber, our catalog number (catalog.nypl.org/record=b########)
	print(item['identifierBNumber'])

	#other identfiers
	print(item['identifierAccessionNumber'])
	print(item['identifierCallNumber'])
	print(item['identifierISBN'])
	print(item['identifierISSN'])
	print(item['identifierInterviewID'])
	print(item['identifierPostcardID'])
	print(item['identifierLCCN'])
	print(item['identifierOCLCRLIN'])


	#the extents for the item
	for physical_description_extent in item['physicalDescriptionExtent']:
		print (physical_description_extent)

	#the form for the item
	for physical_description_form in item['physicalDescriptionForm']:
		print (physical_description_form)

	#the publishers for the item
	for publisher in item['publisher']:
		print (publisher)

	#the publisher locations for the item
	for place_of_publication in item['placeOfPublication']:
		print (place_of_publication)

	#the collection UUID, which has its data in the collections.json
	print(item['collectionUUID'])

	#the container UUID, which is a sub-collection grouping of items
	print(item['containerUUID'])

	#the collection title
	print(item['collectionTitle'])

	#the container title
	print(item['containerTitle'])

	#The hierarchy of where this item is found in the collection, collection followed by containers seperated with "/""
	print(item['parentHierarchy'])

	#the count of the nubmer of images or captures for this item
	print(item['numberOfCaptures'])
	
	#the the URLs for each capture
	for capture in item['captures']:
		print(capture)

	#the the URLs for this item on the NYPL website
	print(item['digitalCollectionsURL'])



