#!/bin/bash

# A series of jq commands that breaks out 14 different relational tables from
# items/*.ndjson. jq can be found at: https://stedolan.github.io/jq/

ITEMDIR=../../../items
COLLDIR=../../../collections

COLLJSON=$COLLDIR/*.ndjson
ITEMJSON=$ITEMDIR/*.ndjson
TARGETDIR=.

mkdir $TARGETDIR/items $TARGETDIR/collections

# Basic item info
ITEMS=$TARGETDIR/items/items.csv
echo "writing $ITEMS"

echo "databaseID,UUID,title,dateStart,dateEnd,identifierBNumber,identifierAccessionNumber,identifierCallNumber,identifierISBN,identifierISSN,identifierInterviewID,identifierPostcardID,identifierLCCN,identifierOCLCRLIN,collectionUUID,containerUUID,collectionTitle,containerTitle,parentHierarchy,numberOfCaptures,digitalCollectionsURL" > $ITEMS

cat $ITEMJSON | jq -r '[.databaseID, .UUID, .title, .dateStart, .dateEnd, .identifierBNumber, .identifierAccessionNumber, .identifierCallNumber, .identifierISBN, .identifierISSN, .identifierInterviewID, .identifierPostcardID, .identifierLCCN, .identifierOCLCRLIN, .collectionUUID, .containerUUID, .collectionTitle, .containerTitle, .parentHierarchy, .numberOfCaptures, .digitalCollectionsURL] | @csv' >> $ITEMS

# Alternate Titles
ALTTITLES=$TARGETDIR/items/alternativeTitle.csv
echo "writing $ALTTITLES"

echo "databaseID,alternativeTitle" > $ALTTITLES

cat $ITEMJSON | jq -r 'select((.alternativeTitle | length) >= 1) |  {databaseID: .databaseID, alternativeTitle: .alternativeTitle[]} | [.databaseID, .alternativeTitle] | @csv' >> $ALTTITLES

# Contributor roles
CONTRIBUTORROLES=$TARGETDIR/items/contributorRoles.csv
echo "writing $CONTRIBUTORROLES"

echo "databaseID,contributorName,contributorType,contributorURI,contributorRole" > $CONTRIBUTORROLES

cat $ITEMJSON | jq -r '{databaseID: .databaseID, contributor: .contributor[]} | {databaseID: .databaseID, contributorName: .contributor.contributorName, contributorType: .contributor.contributorType, contributorURI: .contributor.contributorURI, contributorRole: .contributor.contributorRole[0]?} | [.databaseID, .contributorName, .contributorType, .contributorURI, .contributorRole] | @csv' >> $CONTRIBUTORROLES

# Dates
DATES=$TARGETDIR/items/date.csv
echo "writing $DATES"

echo "databaseID,date" > $DATES

cat $ITEMJSON | jq -r 'select((.date | length) >= 1) |  {databaseID: .databaseID, date: .date[]} | [.databaseID, .date] | @csv' >> $DATES

# languages
LANGUAGES=$TARGETDIR/items/language.csv
echo "writing $LANGUAGES"

echo "databaseID,language" > $LANGUAGES

cat $ITEMJSON | jq -r 'select((.language | length) >= 1) |  {databaseID: .databaseID, language: .language[]} | [.databaseID, .language] | @csv' >> $LANGUAGES

# Notes
NOTES=$TARGETDIR/items/note.csv
echo "writing $NOTES"

echo "databaseID,noteType,noteText" > $NOTES

cat $ITEMJSON | jq -r 'select((.note | length) >= 1) | {databaseID: .databaseID, note: .note[]} | {databaseID: .databaseID, type: .note.type, text: .note.text} | [.databaseID, .type, .text] | @csv' >> $NOTES

# Topical Subjects
TOPSUBJECTS=$TARGETDIR/items/topicalSubject.csv
echo "writing $TOPSUBJECTS"

echo "databaseID,topicalSubjectText,topicalSubjectURI" > $TOPSUBJECTS

cat $ITEMJSON | jq -r 'select((.subjectTopical | length) >= 1) | {databaseID: .databaseID, subjectTopical: .subjectTopical[]} | {databaseID: .databaseID, text: .subjectTopical.text, uri: .subjectTopical.URI} | [.databaseID, .text, .uri] | @csv' >> $TOPSUBJECTS

# Name Subjects
NAMESUBJECTS=$TARGETDIR/items/nameSubject.csv
echo "writing $NAMESUBJECTS"

echo "databaseID,nameSubjectText,nameSubjectURI" > $NAMESUBJECTS

cat $ITEMJSON | jq -r 'select((.subjectName | length) >= 1) | {databaseID: .databaseID, subjectName: .subjectName[]} | {databaseID: .databaseID, text: .subjectName.text, uri: .subjectName.URI} | [.databaseID, .text, .uri] | @csv' >> $NAMESUBJECTS

# Geographic Subjects
GEOSUBJECTS=$TARGETDIR/items/geographicSubject.csv
echo "writing $GEOSUBJECTS"

echo "databaseID,geographicSubjectText,geographicSubjectURI" > $GEOSUBJECTS

cat $ITEMJSON | jq -r 'select((.subjectGeographic | length) >= 1) | {databaseID: .databaseID, subjectGeographic: .subjectGeographic[]} | {databaseID: .databaseID, text: .subjectGeographic.text, uri: .subjectGeographic.URI} | [.databaseID, .text, .uri] | @csv' >> $GEOSUBJECTS

# Temporal Subjects
TEMPSUBJECTS=$TARGETDIR/items/temporalSubject.csv
echo "writing $TEMPSUBJECTS"

echo "databaseID,temporalSubjectText,temporalSubjectURI" > $TEMPSUBJECTS

cat $ITEMJSON | jq -r 'select((.subjectTemporal | length) >= 1) | {databaseID: .databaseID, subjectTemporal: .subjectTemporal[]} | {databaseID: .databaseID, text: .subjectTemporal.text, uri: .subjectTemporal.URI} | [.databaseID, .text, .uri] | @csv' >> $TEMPSUBJECTS

# Title Subjects
TITLESUBJECTS=$TARGETDIR/items/titleSubject.csv
echo "writing $TITLESUBJECTS"

echo "databaseID,titleSubjectText,titleSubjectURI" > $TITLESUBJECTS

cat $ITEMJSON | jq -r 'select((.subjectTitle | length) >= 1) | {databaseID: .databaseID, subjectTitle: .subjectTitle[]} | {databaseID: .databaseID, text: .subjectTitle.text, uri: .subjectTitle.URI} | [.databaseID, .text, .uri] | @csv' >> $TITLESUBJECTS

# Resource Type
RESOURCE=$TARGETDIR/items/resourceType.csv
echo "writing $RESOURCE"

echo "databaseID,resourceType" > $RESOURCE

cat $ITEMJSON | jq -r 'select((.resourceType | length) >= 1) |  {databaseID: .databaseID, resourceType: .resourceType[]} | [.databaseID, .resourceType] | @csv' >> $RESOURCE

# Genre Subjects
GENRE=$TARGETDIR/items/genre.csv
echo "writing $GENRE"

echo "databaseID,genreText,genreURI" > $GENRE

cat $ITEMJSON | jq -r 'select((.genre | length) >= 1) | {databaseID: .databaseID, genre: .genre[]} | {databaseID: .databaseID, text: .genre.text, uri: .genre.URI} | [.databaseID, .text, .uri] | @csv' >> $GENRE

# Captures
CAPTURE=$TARGETDIR/items/captures.csv
echo "writing $CAPTURE"

echo "databaseID,captures" > $CAPTURE

cat $ITEMJSON | jq -r 'select((.captures | length) >= 1) |  {databaseID: .databaseID, captures: .captures[]} | [.databaseID, .captures] | @csv' >> $CAPTURE

# Collections info

COLLS=$TARGETDIR/collections/collections.csv
echo "writing $COLLS"

echo "databaseID,UUID,title,dateStart,dateEnd,identifierBNumber,identifierAccessionNumber,identifierCallNumber,identifierISBN,identifierISSN,identifierInterviewID,identifierPostcardID,identifierLCCN,identifierOCLCRLIN,numberOfItems,digitalCollectionsURL" > $COLLS

cat $COLLJSON | jq -r '[.databaseID, .UUID, .title, .dateStart, .dateEnd, .identifierBNumber, .identifierAccessionNumber, .identifierCallNumber, .identifierISBN, .identifierISSN, .identifierInterviewID, .identifierPostcardID, .identifierLCCN, .identifierOCLCRLIN, .numberOfItems, .digitalCollectionsURL] | @csv' >> $COLLS

# Alternative title
COLLALTTITLES=$TARGETDIR/collections/alternativeTitle.csv
echo "writing $COLLALTTITLES"

echo "databaseID,alternativeTitle" > $COLLALTTITLES

cat $COLLJSON | jq -r 'select((.alternativeTitle | length) >= 1) |  {databaseID: .databaseID, alternativeTitle: .alternativeTitle[]} | [.databaseID, .alternativeTitle] | @csv' >> $COLLALTTITLES

# Contributor roles
CONTRIBUTORROLES=$TARGETDIR/collections/contributorRoles.csv
echo "writing $CONTRIBUTORROLES"

echo "databaseID,contributorName,contributorType,contributorURI,contributorRole" > $CONTRIBUTORROLES

cat $COLLJSON | jq -r '{databaseID: .databaseID, contributor: .contributor[]} | {databaseID: .databaseID, contributorName: .contributor.contributorName, contributorType: .contributor.contributorType, contributorURI: .contributor.contributorURI, contributorRole: .contributor.contributorRole[0]?} | [.databaseID, .contributorName, .contributorType, .contributorURI, .contributorRole] | @csv' >> $CONTRIBUTORROLES

# Dates
DATES=$TARGETDIR/collections/date.csv
echo "writing $DATES"

echo "databaseID,date" > $DATES

cat $COLLJSON | jq -r 'select((.date | length) >= 1) |  {databaseID: .databaseID, date: .date[]} | [.databaseID, .date] | @csv' >> $DATES

# languages
LANGUAGES=$TARGETDIR/collections/language.csv
echo "writing $LANGUAGES"

echo "databaseID,language" > $LANGUAGES

cat $COLLJSON | jq -r 'select((.language | length) >= 1) |  {databaseID: .databaseID, language: .language[]} | [.databaseID, .language] | @csv' >> $LANGUAGES

# Description
DESC=$TARGETDIR/collections/description.csv
echo "writing $DESC"

echo "databaseID,description" > $DESC

cat $COLLJSON | jq -r 'select((.description | length) >= 1) | {databaseID: .databaseID, description: .description[]} | [.databaseID, .description] | @csv' >> $DESC

# Notes
NOTES=$TARGETDIR/collections/note.csv
echo "writing $NOTES"

echo "databaseID,noteType,noteText" > $NOTES

cat $COLLJSON | jq -r 'select((.note | length) >= 1) | {databaseID: .databaseID, note: .note[]} | {databaseID: .databaseID, type: .note.type, text: .note.text} | [.databaseID, .type, .text] | @csv' >> $NOTES

# Topical Subjects
TOPSUBJECTS=$TARGETDIR/collections/topicalSubject.csv
echo "writing $TOPSUBJECTS"

echo "databaseID,topicalSubjectText,topicalSubjectURI" > $TOPSUBJECTS

cat $COLLJSON | jq -r 'select((.subjectTopical | length) >= 1) | {databaseID: .databaseID, subjectTopical: .subjectTopical[]} | {databaseID: .databaseID, text: .subjectTopical.text, uri: .subjectTopical.URI} | [.databaseID, .text, .uri] | @csv' >> $TOPSUBJECTS

# Name Subjects
NAMESUBJECTS=$TARGETDIR/collections/nameSubject.csv
echo "writing $NAMESUBJECTS"

echo "databaseID,nameSubjectText,nameSubjectURI" > $NAMESUBJECTS

cat $COLLJSON | jq -r 'select((.subjectName | length) >= 1) | {databaseID: .databaseID, subjectName: .subjectName[]} | {databaseID: .databaseID, text: .subjectName.text, uri: .subjectName.URI} | [.databaseID, .text, .uri] | @csv' >> $NAMESUBJECTS

# Geographic Subjects
GEOSUBJECTS=$TARGETDIR/collections/geographicSubject.csv
echo "writing $GEOSUBJECTS"

echo "databaseID,geographicSubjectText,geographicSubjectURI" > $GEOSUBJECTS

cat $COLLJSON | jq -r 'select((.subjectGeographic | length) >= 1) | {databaseID: .databaseID, subjectGeographic: .subjectGeographic[]} | {databaseID: .databaseID, text: .subjectGeographic.text, uri: .subjectGeographic.URI} | [.databaseID, .text, .uri] | @csv' >> $GEOSUBJECTS

# Temporal Subjects
TEMPSUBJECTS=$TARGETDIR/collections/temporalSubject.csv
echo "writing $TEMPSUBJECTS"

echo "databaseID,temporalSubjectText,temporalSubjectURI" > $TEMPSUBJECTS

cat $COLLJSON | jq -r 'select((.subjectTemporal | length) >= 1) | {databaseID: .databaseID, subjectTemporal: .subjectTemporal[]} | {databaseID: .databaseID, text: .subjectTemporal.text, uri: .subjectTemporal.URI} | [.databaseID, .text, .uri] | @csv' >> $TEMPSUBJECTS

# Title Subjects
TITLESUBJECTS=$TARGETDIR/collections/titleSubject.csv
echo "writing $TITLESUBJECTS"

echo "databaseID,titleSubjectText,titleSubjectURI" > $TITLESUBJECTS

cat $COLLJSON | jq -r 'select((.subjectTitle | length) >= 1) | {databaseID: .databaseID, subjectTitle: .subjectTitle[]} | {databaseID: .databaseID, text: .subjectTitle.text, uri: .subjectTitle.URI} | [.databaseID, .text, .uri] | @csv' >> $TITLESUBJECTS

# Resource Type
RESOURCE=$TARGETDIR/collections/resourceType.csv
echo "writing $RESOURCE"

echo "databaseID,resourceType" > $RESOURCE

cat $COLLJSON | jq -r 'select((.resourceType | length) >= 1) |  {databaseID: .databaseID, resourceType: .resourceType[]} | [.databaseID, .resourceType] | @csv' >> $RESOURCE

# Genre Subjects
GENRE=$TARGETDIR/collections/genre.csv
echo "writing $GENRE"

echo "databaseID,genreText,genreURI" > $GENRE

cat $COLLJSON | jq -r 'select((.genre | length) >= 1) | {databaseID: .databaseID, genre: .genre[]} | {databaseID: .databaseID, text: .genre.text, uri: .genre.URI} | [.databaseID, .text, .uri] | @csv' >> $GENRE

# physicalDescriptionExtent
PDE=$TARGETDIR/collections/physicalDescriptionExtent.csv
echo "writing $PDE"

echo "databaseID,physicalDescriptionExtent" > $PDE

cat $COLLJSON | jq -r 'select((.physicalDescriptionExtent | length) >= 1) |  {databaseID: .databaseID, physicalDescriptionExtent: .physicalDescriptionExtent[]} | [.databaseID, .physicalDescriptionExtent] | @csv' >> $PDE

# physicalDescriptionForm
PDF=$TARGETDIR/collections/physicalDescriptionForm.csv
echo "writing $PDF"

echo "databaseID,physicalDescriptionForm" > $PDF

cat $COLLJSON | jq -r 'select((.physicalDescriptionForm | length) >= 1) |  {databaseID: .databaseID, physicalDescriptionForm: .physicalDescriptionForm[]} | [.databaseID, .physicalDescriptionForm] | @csv' >> $PDF

# publisher
PUB=$TARGETDIR/collections/publisher.csv
echo "writing $PUB"

echo "databaseID,publisher" > $PUB

cat $COLLJSON | jq -r 'select((.publisher | length) >= 1) |  {databaseID: .databaseID, publisher: .publisher[]} | [.databaseID, .publisher] | @csv' >> $PUB

# placeOfPublication
POP=$TARGETDIR/collections/placeOfPublication.csv
echo "writing $POP"

echo "databaseID,placeOfPublication" > $POP

cat $COLLJSON | jq -r 'select((.placeOfPublication | length) >= 1) |  {databaseID: .databaseID, placeOfPublication: .placeOfPublication[]} | [.databaseID, .placeOfPublication] | @csv' >> $POP
