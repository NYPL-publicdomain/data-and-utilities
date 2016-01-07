#!/bin/bash

# A series of jq commands that breaks out 14 different relational tables from
# items/*.ndjson. jq can be found at: https://stedolan.github.io/jq/

SOURCEDIR=../../../items/
NDJSON=$SOURCEDIR/*.ndjson
TARGETDIR=.

# Basic item info
ITEMS=$TARGETDIR/items.csv

echo "databaseID,UUID,title,dateStart,dateEnd,identifierBNumber,identifierAccessionNumber,identifierCallNumber,identifierISBN,identifierISSN,identifierInterviewID,identifierPostcardID,identifierLCCN,identifierOCLCRLIN,collectionUUID,containerUUID,collectionTitle,containerTitle,parentHierarchy,numberOfCaptures,digitalCollectionsURL" > $ITEMS

cat $NDJSON | jq -r '[.databaseID, .UUID, .title, .dateStart, .dateEnd, .identifierBNumber, .identifierAccessionNumber, .identifierCallNumber, .identifierISBN, .identifierISSN, .identifierInterviewID, .identifierPostcardID, .identifierLCCN, .identifierOCLCRLIN, .collectionUUID, .containerUUID, .collectionTitle, .containerTitle, .parentHierarchy, .numberOfCaptures, .digitalCollectionsURL] | @csv' >> $ITEMS

# Alternate Titles
ALTTITLES=$TARGETDIR/alternativeTitle.csv

echo "databaseID,alternativeTitle" > $ALTTITLES

cat $NDJSON | jq -r 'select((.alternativeTitle | length) >= 1) |  {databaseID: .databaseID, alternativeTitle: .alternativeTitle[]} | [.databaseID, .alternativeTitle] | @csv' >> $ALTTITLES

# Contributors
CONTRIBUTORS=$TARGETDIR/contributors.csv

echo "contributorName,contributorType,contributorURI" > $CONTRIBUTORS

cat $NDJSON | jq -r '.contributor[] | [.contributorName, .contributorType, .contributorURI] | @csv' | sort | uniq >> $CONTRIBUTORS

# Contributor roles
CONTRIBUTORROLES=$TARGETDIR/contributorRoles.csv

echo "databaseID,contributorName,contributorRole" > $CONTRIBUTORROLES

cat $NDJSON | jq -r '{databaseID: .databaseID, contributor: .contributor[]} | {databaseID: .databaseID, contributorName: .contributor.contributorName, contributorRole: .contributor.contributorRole[]} | [.databaseID, .contributorName, .contributorRole] | @csv' >> $CONTRIBUTORROLES

# Dates
DATES=$TARGETDIR/date.csv

echo "databaseID,date" > $DATES

cat $NDJSON | jq -r 'select((.date | length) >= 1) |  {databaseID: .databaseID, date: .date[]} | [.databaseID, .date] | @csv' >> $DATES

# languages
LANGUAGES=$TARGETDIR/language.csv

echo "databaseID,language" > $LANGUAGES

cat $NDJSON | jq -r 'select((.language | length) >= 1) |  {databaseID: .databaseID, language: .language[]} | [.databaseID, .language] | @csv' >> $LANGUAGES

# Notes
NOTES=$TARGETDIR/note.csv

echo "databaseID,noteType,noteText" > $NOTES

cat $NDJSON | jq -r 'select((.note | length) >= 1) | {databaseID: .databaseID, note: .note[]} | {databaseID: .databaseID, type: .note.type, text: .note.text} | [.databaseID, .type, .text] | @csv' >> $NOTES

# Topical Subjects
TOPSUBJECTS=$TARGETDIR/topicalSubject.csv

echo "databaseID,topicalSubjectText,topicalSubjectURI" > $TOPSUBJECTS

cat $NDJSON | jq -r 'select((.subjectTopical | length) >= 1) | {databaseID: .databaseID, subjectTopical: .subjectTopical[]} | {databaseID: .databaseID, text: .subjectTopical.text, uri: .subjectTopical.URI} | [.databaseID, .text, .URI] | @csv' >> $TOPSUBJECTS

# Name Subjects
NAMESUBJECTS=$TARGETDIR/nameSubject.csv

echo "databaseID,nameSubjectText,nameSubjectURI" > $NAMESUBJECTS

cat $NDJSON | jq -r 'select((.subjectName | length) >= 1) | {databaseID: .databaseID, subjectName: .subjectName[]} | {databaseID: .databaseID, text: .subjectName.text, uri: .subjectName.URI} | [.databaseID, .text, .URI] | @csv' >> $NAMESUBJECTS

# Geographic Subjects
GEOSUBJECTS=$TARGETDIR/geographicSubject.csv

echo "databaseID,geographicSubjectText,geographicSubjectURI" > $GEOSUBJECTS

cat $NDJSON | jq -r 'select((.subjectGeographic | length) >= 1) | {databaseID: .databaseID, subjectGeographic: .subjectGeographic[]} | {databaseID: .databaseID, text: .subjectGeographic.text, uri: .subjectGeographic.URI} | [.databaseID, .text, .URI] | @csv' >> $GEOSUBJECTS

# Temporal Subjects
TEMPSUBJECTS=$TARGETDIR/titleSubject.csv

echo "databaseID,titleSubjectText,titleSubjectURI" > $TEMPSUBJECTS

cat $NDJSON | jq -r 'select((.subjectTemporal | length) >= 1) | {databaseID: .databaseID, subjectTemporal: .subjectTemporal[]} | {databaseID: .databaseID, text: .subjectTemporal.text, uri: .subjectTemporal.URI} | [.databaseID, .text, .URI] | @csv' >> $TEMPSUBJECTS

# Title Subjects
TITLESUBJECTS=$TARGETDIR/titleSubject.csv

echo "databaseID,titleSubjectText,titleSubjectURI" > $TITLESUBJECTS

cat $NDJSON | jq -r 'select((.subjectTitle | length) >= 1) | {databaseID: .databaseID, subjectTitle: .subjectTitle[]} | {databaseID: .databaseID, text: .subjectTitle.text, uri: .subjectTitle.URI} | [.databaseID, .text, .URI] | @csv' >> $TITLESUBJECTS

# Resource Type
RESOURCE=$TARGETDIR/resourceType.csv

echo "databaseID,resourceType" > $RESOURCE

cat $NDJSON | jq -r 'select((.resourceType | length) >= 1) |  {databaseID: .databaseID, resourceType: .resourceType[]} | [.databaseID, .resourceType] | @csv' >> $RESOURCE

# Title Subjects
GENRE=$TARGETDIR/genre.csv

echo "databaseID,genreText,genreURI" > $GENRE

cat $NDJSON | jq -r 'select((.genre | length) >= 1) | {databaseID: .databaseID, genre: .genre[]} | {databaseID: .databaseID, text: .genre.text, uri: .genre.URI} | [.databaseID, .text, .URI] | @csv' >> $GENRE

# Captures
CAPTURE=$TARGETDIR/captures.csv

echo "databaseID,captures" > $CAPTURE

cat $NDJSON | jq -r 'select((.captures | length) >= 1) |  {databaseID: .databaseID, captures: .captures[]} | [.databaseID, .captures] | @csv' >> $CAPTURE
