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

echo "databaseID,UUID,title,dateStart,dateEnd,identifierBNumber,identifierAccessionNumber,identifierCallNumber,identifierISBN,identifierISSN,identifierInterviewID,identifierPostcardID,identifierLCCN,identifierOCLCRLIN,collectionUUID,containerUUID,collectionTitle,containerTitle,parentHierarchy,numberOfCaptures,digitalCollectionsURL" > $ITEMS

cat $ITEMJSON | jq -r '[.databaseID, .UUID, .title, .dateStart, .dateEnd, .identifierBNumber, .identifierAccessionNumber, .identifierCallNumber, .identifierISBN, .identifierISSN, .identifierInterviewID, .identifierPostcardID, .identifierLCCN, .identifierOCLCRLIN, .collectionUUID, .containerUUID, .collectionTitle, .containerTitle, .parentHierarchy, .numberOfCaptures, .digitalCollectionsURL] | @csv' >> $ITEMS

# Alternate Titles
ALTTITLES=$TARGETDIR/items/alternativeTitle.csv

echo "databaseID,alternativeTitle" > $ALTTITLES

cat $ITEMJSON | jq -r 'select((.alternativeTitle | length) >= 1) |  {databaseID: .databaseID, alternativeTitle: .alternativeTitle[]} | [.databaseID, .alternativeTitle] | @csv' >> $ALTTITLES

# Contributor roles
CONTRIBUTORROLES=$TARGETDIR/items/contributorRoles.csv

echo "databaseID,contributorName,contributorType,contributorURI,contributorRole" > $CONTRIBUTORROLES

cat $ITEMJSON | jq -r '{databaseID: .databaseID, contributor: .contributor[]} | {databaseID: .databaseID, contributorName: .contributor.contributorName, contributorType: .contributor.contributorType, contributorURI: .contributor.contributorURI, contributorRole: .contributor.contributorRole[0]?} | [.databaseID, .contributorName, .contributorType, .contributorURI, .contributorRole] | @csv' >> $CONTRIBUTORROLES

# Dates
DATES=$TARGETDIR/items/date.csv

echo "databaseID,date" > $DATES

cat $ITEMJSON | jq -r 'select((.date | length) >= 1) |  {databaseID: .databaseID, date: .date[]} | [.databaseID, .date] | @csv' >> $DATES

# languages
LANGUAGES=$TARGETDIR/items/language.csv

echo "databaseID,language" > $LANGUAGES

cat $ITEMJSON | jq -r 'select((.language | length) >= 1) |  {databaseID: .databaseID, language: .language[]} | [.databaseID, .language] | @csv' >> $LANGUAGES

# Notes
NOTES=$TARGETDIR/items/note.csv

echo "databaseID,noteType,noteText" > $NOTES

cat $ITEMJSON | jq -r 'select((.note | length) >= 1) | {databaseID: .databaseID, note: .note[]} | {databaseID: .databaseID, type: .note.type, text: .note.text} | [.databaseID, .type, .text] | @csv' >> $NOTES

# Topical Subjects
TOPSUBJECTS=$TARGETDIR/items/topicalSubject.csv

echo "databaseID,topicalSubjectText,topicalSubjectURI" > $TOPSUBJECTS

cat $ITEMJSON | jq -r 'select((.subjectTopical | length) >= 1) | {databaseID: .databaseID, subjectTopical: .subjectTopical[]} | {databaseID: .databaseID, text: .subjectTopical.text, uri: .subjectTopical.URI} | [.databaseID, .text, .URI] | @csv' >> $TOPSUBJECTS

# Name Subjects
NAMESUBJECTS=$TARGETDIR/items/nameSubject.csv

echo "databaseID,nameSubjectText,nameSubjectURI" > $NAMESUBJECTS

cat $ITEMJSON | jq -r 'select((.subjectName | length) >= 1) | {databaseID: .databaseID, subjectName: .subjectName[]} | {databaseID: .databaseID, text: .subjectName.text, uri: .subjectName.URI} | [.databaseID, .text, .URI] | @csv' >> $NAMESUBJECTS

# Geographic Subjects
GEOSUBJECTS=$TARGETDIR/items/geographicSubject.csv

echo "databaseID,geographicSubjectText,geographicSubjectURI" > $GEOSUBJECTS

cat $ITEMJSON | jq -r 'select((.subjectGeographic | length) >= 1) | {databaseID: .databaseID, subjectGeographic: .subjectGeographic[]} | {databaseID: .databaseID, text: .subjectGeographic.text, uri: .subjectGeographic.URI} | [.databaseID, .text, .URI] | @csv' >> $GEOSUBJECTS

# Temporal Subjects
TEMPSUBJECTS=$TARGETDIR/items/titleSubject.csv

echo "databaseID,titleSubjectText,titleSubjectURI" > $TEMPSUBJECTS

cat $ITEMJSON | jq -r 'select((.subjectTemporal | length) >= 1) | {databaseID: .databaseID, subjectTemporal: .subjectTemporal[]} | {databaseID: .databaseID, text: .subjectTemporal.text, uri: .subjectTemporal.URI} | [.databaseID, .text, .URI] | @csv' >> $TEMPSUBJECTS

# Title Subjects
TITLESUBJECTS=$TARGETDIR/items/titleSubject.csv

echo "databaseID,titleSubjectText,titleSubjectURI" > $TITLESUBJECTS

cat $ITEMJSON | jq -r 'select((.subjectTitle | length) >= 1) | {databaseID: .databaseID, subjectTitle: .subjectTitle[]} | {databaseID: .databaseID, text: .subjectTitle.text, uri: .subjectTitle.URI} | [.databaseID, .text, .URI] | @csv' >> $TITLESUBJECTS

# Resource Type
RESOURCE=$TARGETDIR/items/resourceType.csv

echo "databaseID,resourceType" > $RESOURCE

cat $ITEMJSON | jq -r 'select((.resourceType | length) >= 1) |  {databaseID: .databaseID, resourceType: .resourceType[]} | [.databaseID, .resourceType] | @csv' >> $RESOURCE

# Genre Subjects
GENRE=$TARGETDIR/items/genre.csv

echo "databaseID,genreText,genreURI" > $GENRE

cat $ITEMJSON | jq -r 'select((.genre | length) >= 1) | {databaseID: .databaseID, genre: .genre[]} | {databaseID: .databaseID, text: .genre.text, uri: .genre.URI} | [.databaseID, .text, .URI] | @csv' >> $GENRE

# Captures
CAPTURE=$TARGETDIR/items/captures.csv

echo "databaseID,captures" > $CAPTURE

cat $ITEMJSON | jq -r 'select((.captures | length) >= 1) |  {databaseID: .databaseID, captures: .captures[]} | [.databaseID, .captures] | @csv' >> $CAPTURE

# Collections info

COLLS=$TARGETDIR/collections/collections.csv

echo "databaseID,UUID,title,dateStart,dateEnd,identifierBNumber,identifierAccessionNumber,identifierCallNumber,identifierISBN,identifierISSN,identifierInterviewID,identifierPostcardID,identifierLCCN,identifierOCLCRLIN,numberOfItems,digitalCollectionsURL" > $COLLS

cat $COLLJSON | jq -r '[.databaseID, .UUID, .title, .dateStart, .dateEnd, .identifierBNumber, .identifierAccessionNumber, .identifierCallNumber, .identifierISBN, .identifierISSN, .identifierInterviewID, .identifierPostcardID, .identifierLCCN, .identifierOCLCRLIN, .numberOfItems, .ddigitalCollectionsURL] | @csv' >> $COLLS

# Alternative title
COLLALTTITLES=$TARGETDIR/collections/alternativeTitle.csv

echo "databaseID,alternativeTitle" > $COLLALTTITLES

cat $COLLJSON | jq -r 'select((.alternativeTitle | length) >= 1) |  {databaseID: .databaseID, alternativeTitle: .alternativeTitle[]} | [.databaseID, .alternativeTitle] | @csv' >> $COLLALTTITLES

# Contributor roles
CONTRIBUTORROLES=$TARGETDIR/collections/contributorRoles.csv

echo "databaseID,contributorName,contributorType,contributorURI,contributorRole" > $CONTRIBUTORROLES

cat $COLLJSON | jq -r '{databaseID: .databaseID, contributor: .contributor[]} | {databaseID: .databaseID, contributorName: .contributor.contributorName, contributorType: .contributor.contributorType, contributorURI: .contributor.contributorURI, contributorRole: .contributor.contributorRole[0]?} | [.databaseID, .contributorName, .contributorType, .contributorURI, .contributorRole] | @csv' >> $CONTRIBUTORROLES

# Dates
DATES=$TARGETDIR/collections/date.csv

echo "databaseID,date" > $DATES

cat $COLLJSON | jq -r 'select((.date | length) >= 1) |  {databaseID: .databaseID, date: .date[]} | [.databaseID, .date] | @csv' >> $DATES

# languages
LANGUAGES=$TARGETDIR/collections/language.csv

echo "databaseID,language" > $LANGUAGES

cat $COLLJSON | jq -r 'select((.language | length) >= 1) |  {databaseID: .databaseID, language: .language[]} | [.databaseID, .language] | @csv' >> $LANGUAGES

# Notes
NOTES=$TARGETDIR/collections/note.csv

echo "databaseID,noteType,noteText" > $NOTES

cat $COLLJSON | jq -r 'select((.note | length) >= 1) | {databaseID: .databaseID, note: .note[]} | {databaseID: .databaseID, type: .note.type, text: .note.text} | [.databaseID, .type, .text] | @csv' >> $NOTES

# Topical Subjects
TOPSUBJECTS=$TARGETDIR/collections/topicalSubject.csv

echo "databaseID,topicalSubjectText,topicalSubjectURI" > $TOPSUBJECTS

cat $COLLJSON | jq -r 'select((.subjectTopical | length) >= 1) | {databaseID: .databaseID, subjectTopical: .subjectTopical[]} | {databaseID: .databaseID, text: .subjectTopical.text, uri: .subjectTopical.URI} | [.databaseID, .text, .URI] | @csv' >> $TOPSUBJECTS

# Name Subjects
NAMESUBJECTS=$TARGETDIR/collections/nameSubject.csv

echo "databaseID,nameSubjectText,nameSubjectURI" > $NAMESUBJECTS

cat $COLLJSON | jq -r 'select((.subjectName | length) >= 1) | {databaseID: .databaseID, subjectName: .subjectName[]} | {databaseID: .databaseID, text: .subjectName.text, uri: .subjectName.URI} | [.databaseID, .text, .URI] | @csv' >> $NAMESUBJECTS

# Geographic Subjects
GEOSUBJECTS=$TARGETDIR/collections/geographicSubject.csv

echo "databaseID,geographicSubjectText,geographicSubjectURI" > $GEOSUBJECTS

cat $COLLJSON | jq -r 'select((.subjectGeographic | length) >= 1) | {databaseID: .databaseID, subjectGeographic: .subjectGeographic[]} | {databaseID: .databaseID, text: .subjectGeographic.text, uri: .subjectGeographic.URI} | [.databaseID, .text, .URI] | @csv' >> $GEOSUBJECTS

# Temporal Subjects
TEMPSUBJECTS=$TARGETDIR/collections/titleSubject.csv

echo "databaseID,titleSubjectText,titleSubjectURI" > $TEMPSUBJECTS

cat $COLLJSON | jq -r 'select((.subjectTemporal | length) >= 1) | {databaseID: .databaseID, subjectTemporal: .subjectTemporal[]} | {databaseID: .databaseID, text: .subjectTemporal.text, uri: .subjectTemporal.URI} | [.databaseID, .text, .URI] | @csv' >> $TEMPSUBJECTS

# Title Subjects
TITLESUBJECTS=$TARGETDIR/collections/titleSubject.csv

echo "databaseID,titleSubjectText,titleSubjectURI" > $TITLESUBJECTS

cat $COLLJSON | jq -r 'select((.subjectTitle | length) >= 1) | {databaseID: .databaseID, subjectTitle: .subjectTitle[]} | {databaseID: .databaseID, text: .subjectTitle.text, uri: .subjectTitle.URI} | [.databaseID, .text, .URI] | @csv' >> $TITLESUBJECTS

# Resource Type
RESOURCE=$TARGETDIR/collections/resourceType.csv

echo "databaseID,resourceType" > $RESOURCE

cat $COLLJSON | jq -r 'select((.resourceType | length) >= 1) |  {databaseID: .databaseID, resourceType: .resourceType[]} | [.databaseID, .resourceType] | @csv' >> $RESOURCE

# Genre Subjects
GENRE=$TARGETDIR/collections/genre.csv

echo "databaseID,genreText,genreURI" > $GENRE

cat $COLLJSON | jq -r 'select((.genre | length) >= 1) | {databaseID: .databaseID, genre: .genre[]} | {databaseID: .databaseID, text: .genre.text, uri: .genre.URI} | [.databaseID, .text, .URI] | @csv' >> $GENRE
