#!/usr/bin/env node
var fs = require('fs');

var allItems = []


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


			allItems.forEach(function(aItem){			

				//lets print each item here
				console.log(aItem)


			})






		})
	})
})











