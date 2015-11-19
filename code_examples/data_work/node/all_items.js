#!/usr/bin/env node
var fs = require('fs');

var allItems = [];


//a little function to help us read the file since we have three of them
var readItems = function(filename,callback){
	console.log("Loading ",filename)
	fs.readFile(filename, function (err, data) {
		//split the file by line breaks and parse each line as a json object and insert it into our big array
		data.toString().split("\n").forEach(function(line){		
			if (line.length>0)
				allItems.push(JSON.parse(line));
		});
		callback();
	});
}



readItems('../../items/pd_items_1.json',function(){
	readItems('../../items/pd_items_2.json',function(){
		readItems('../../items/pd_items_3.json',function(){

			allItems.forEach(function(item){			

				//lets print everything possible in the item!

				//the title of the item, there can only be one title
				console.log(item['title']);


				// //the uuid is the unique identifier for the item
				// console.log(item['UUID']);

				// //the databaseID is another identifier for the item use in our database
				// console.log(item['databaseID']);



				// //there can be multiple 0 or more alternative titles
				// for (var altTitle in item['alternativeTitle']){
				// 	console.log(altTitle);
				// }


				// //contributor is a dictonary with these possible keys
				// item['contributor'].forEach(function(contributor){

				// 	//the name
				// 	console.log(contributor['contributor']);

				// 	//the type, person, corporation, etc
				// 	console.log(contributor['contributorType']);

				// 	//the role they had in this item, such as author,Printmaker, Illustrator etc.
				// 	contributor['contributorRole'].forEach(function(role){
				// 		console.log(role);
				// 	});						

				// 	//Their URI, a linked data identifier
				// 	console.log(contributor['contributorURI']);
				// });

				// //the dates associated with this item
				// item['date'].forEach(function(date){
				// 	console.log(date);
				// });

				// //the "start" year of this item
				// console.log(item['dateStart']);

				// //the "end" year of this item
				// console.log(item['dateEnd']);

				// //the languages for this item
				// item['language'].forEach(function(language){
				// 	console.log(language);
				// });

				// //the description for this item
				// item['description'].forEach(function(description){
				// 	console.log(description);
				// });

				// //the notes can have:
				// item['note'].forEach(function(note){

				// 	//the type of the note
				// 	console.log(note['type']);

				// 	//and the text of the note
				// 	console.log(note['text']);
				// });


				// //the subject headings of the item can have:
				// item['subjectTopical'].forEach(function(subjectTopical){

				// 	//the text of the subject
				// 	console.log(subjectTopical['text']);

				// 	//and the URI, or linked data identifier
				// 	console.log(subjectTopical['URI']);
				// });

				// item['subjectName'].forEach(function(subjectName){
				// 	console.log(subjectName['text']);
				// 	console.log(subjectName['URI']);
				// });

				// item['subjectGeographic'].forEach(function(subjectGeographic){
				// 	console.log(subjectGeographic['text']);
				// 	console.log(subjectGeographic['URI']);
				// });

				// item['subjectTemporal'].forEach(function(subjectTemporal){
				// 	console.log(subjectTemporal['text']);
				// 	console.log(subjectTemporal['URI']);
				// });

				// item['subjectTitle'].forEach(function(subjectTitle){
				// 	console.log(subjectTitle['text']);
				// 	console.log(subjectTitle['URI']);
				// });

				// //the resource types for the item
				// item['resourceType'].forEach(function(resourceType){
				// 	console.log(resourceType);
				// });

				// //the genres for the item
				// item['genre'].forEach(function(genre){
				// 	console.log(genre['text']);
				// 	console.log(genre['URI']);
				// });


				// //bNumber, our catalog number (catalog.nypl.org/record=b########)
				// console.log(item['identifierBNumber']);

				// //other identfiers
				// console.log(item['identifierAccessionNumber']);
				// console.log(item['identifierCallNumber']);
				// console.log(item['identifierISBN']);
				// console.log(item['identifierISSN']);
				// console.log(item['identifierInterviewID']);
				// console.log(item['identifierPostcardID']);
				// console.log(item['identifierLCCN']);
				// console.log(item['identifierOCLCRLIN']);


				// //the extents for the item
				// item['physicalDescriptionExtent'].forEach(function(physicalDescriptionExtent){
				// 	console.log(physicalDescriptionExtent);
				// });

				// //the form for the item
				// item['physicalDescriptionForm'].forEach(function(physicalDescriptionForm){
				// 	console.log(physicalDescriptionForm);
				// });

				// //the publishers for the item
				// item['publisher'].forEach(function(publisher){
				// 	console.log(publisher);
				// });

				// //the publisher locations for the item
				// item['placeOfPublication'].forEach(function(placeOfPublication){
				// 	console.log(placeOfPublication);
				// });

				// //the collection UUID, which has its data in the collections.json
				// console.log(item['collectionUUID']);

				// //the container UUID, which is a sub-collection grouping of items
				// console.log(item['containerUUID']);

				// //the collection title
				// console.log(item['collectionTitle']);

				// //the container title
				// console.log(item['containerTitle']);

				// //The hierarchy of where this item is found in the collection, collection followed by containers seperated with "/""
				// console.log(item['parentHierarchy']);

				// //the count of the nubmer of images or captures for this item
				// console.log(item['numberOfCaptures']);
				
				// //the the URLs for each capture
				// item['captures'].forEach(function(capture){
				// 	console.log(capture);
				// })

				// //the the URLs for this item on the NYPL website
				// console.log(item['digitalCollectionsURL']);


			})
		})
	})
})











