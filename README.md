# Digital Collections Public Domain Item Data and Tools

Did you know that nearly one-third of the items in our Digital Collections are in the public domain -- that is, they have been designated as having no known U.S. copyright restrictions? This means that everyone has the freedom to enjoy and reuse these materials in almost limitless ways. To help you explore, visualize, and repurpose these items, we've gathered all of their metadata into a single data release. (This data is a snapshot as of 12/30/15; see the [NYPL Digital Collections Metadata API](http://api.repo.nypl.org/) for updated information and for data about the non-public domain portions of our Digital Collections.)

This dataset is organized by [Items](#items) and [Collections](#collections) in both CSV and JSON formats. Our descriptive metadata is normally stored in the MODS schema (which is what you'll find in our Digital Collections API), but for this release we've simplified and flattened the metadata structure for CSV to make it easier to navigate with spreadsheet tools. The JSON versions include a bit more metadata, including URIs for many names and subjects and links to the full-size images comprising each item. 

NYPL has been digitizing collections since 1999, so our metadata reflects an evolution of standards, practices, and workflows. We are actively refining our metadata creation and quality control processes and exploring ways to improve the consistency and accuracy of our legacy metadata, but in the meantime, you may find some idiosyncracies and curiosities in our data. If you'd like to bring certain issues to our attention, we welcome your feedback through our [Digital Collections](http://digitalcollections.nypl.org) feedback form.

NYPL's bibliographic metadata records provided via this repository are distributed under a [Creative Commons CC0 1.0 Universal Public Domain Dedication ("CCO 1.0 Dedication")](http://creativecommons.org/publicdomain/zero/1.0/). 

- [Items](#items)
- [Collections](#collections)
- [Code Examples](#code-examples)


## Items

Items are distinct intellectual or bibliographic entities in Digital Collections. They can be photographs, full books or illustrations from books, journals, letters, pamphlets, [skull fragments](http://digitalcollections.nypl.org/items/579bab40-98c5-0131-01ad-58d385a7bbd0), [cuneiform tablets](http://digitalcollections.nypl.org/search/index?utf8=%E2%9C%93&keywords=cuneiform), and much more. Most items belong to collections, but there are some (usually books) that stand alone. Items are made up of one or more images (or "captures").  

Below are the metadata fields you'll find in the CSV and JSON files that describe our public domain items. In the CSV file, arrays of strings are represented as a single pipe-delimited string, like "Wollrabe, Amalie | Helmerding, Carl, 1822-1899". 

| Field | Description | CSV | JSON | Value |
| ----- | ----------- | --- | ---- | ----- |
| UUID | The unique identifier for the item. This is always present. | UUID | UUID | string |
| Database ID | The item's identifier from our database. This is always present. | Database ID | databaseID | integer |
| Title | The primary title of the item. This should always be present. | Title | title | string |
| Alternative title | Any additional or alternative titles for the item. | Alternative Title | alternativeTitle | array of strings |
| Contributor | A list of people or organziations who contributed to the creation of the item. An item may have zero or more contributors. | Contributor | contributor | array of strings (CSV) / array of objects (JSON)|
| Contributor name | (JSON) The name of the contributor. | - | contributor.contributorName | string |
| Contributor type | (JSON) The type of contributor name. This is usually 'personal' for individuals or 'corporate' for groups or organizations. | - | contributor.contributorType | string |
| Contributor role | (JSON) The role(s) the contributor played in the creation of the item, if available. | - | contributorRole | array of strings |
| Contributor URI | (JSON) The [VIAF](http://viaf.org/) URI for the contributor, if available. | - | contributor.contributorURI | string |
| Date | The date the item was originally created or published. Zero or more dates may be recorded. Many dates are encoded in YYYY-MM-DD format, but others are in free text format, like "ca. 1890", "1760-1770?" or "1920s". | Date | date | array of strings |
| Date start | The earliest date recorded for the item. This could be the earliest of multiple single dates or the start date of a date range. | Date Start | dateStart | string |
| Date end | The latest date recorded for the item. This could be the latest of multiple single dates or the end date of a date range. | Date End | dateEnd | string |
| Language | The language of the item. An item may have zero or more languages. | Language | language | array of strings |
| Description | A summary or description of the contents of the item, if available. | Description | description | string |
| Note | A list of notes associated with the item. Each note in the list is prefaced by a label denoting the note type, like "General Note: " | Note | note | array of strings |
| Topical subject | A list of topical subjects. Most terms are taken from [LCSH](http://id.loc.gov/authorities/subjects.html) or [LCTGM](http://id.loc.gov/vocabulary/graphicMaterials.html). Complex subject headings are usually broken down into individual subjects. | Subject Topical | subjectTopical | array of strings (CSV) / array of objects (JSON) |
| Topical subject text | (JSON) The text of the topical subject. | - | subjectTopical.text | string |
| Topical subject URI | (JSON) A URI for the topical subject, if available. | - | subjectTopical.URI | string |
| Name subject | A list of people or organizations described or depicted in the contents of the item. Most terms come from the [LC Name Authority File](http://id.loc.gov/authorities/names.html). | Subject Name | subjectName | array of strings (CSV) / array of objects (JSON) |
| Name subject text | (JSON) The name of the subject. | - | subjectName.text | string |
| Name subject URI | (JSON) A URI for the name subject, if available. | - | subjectName.URI | string |
| Geographic subject | A list of places described or depicted in the contents of the item. Most terms come from [LCNAF](http://id.loc.gov/authorities/names.html) and [LCSH](http://id.loc.gov/search/?q=memberOf:http://id.loc.gov/authorities/subjects/collection_GeographicSubdivisions). | Subject Geographic | subjectGeographic | array of strings (CSV) / array of objects (JSON) |
| Geographic subject text | (JSON) The name of the place. | - | subjectGeographic.text | string |
| Geographic subject URI | (JSON) A URI for the geographic subject, if available. | - | subjectGeographic.URI | string |
| Temporal subject | A list of time periods related to the contents of the item. Many terms come from [LCSH](http://id.loc.gov/search/?q=memberOf:http://id.loc.gov/authorities/subjects/collection_TemporalSubdivisions). | Subject Temporal | subjectTemporal | array of strings (CSV) / array of objects (JSON) |
| Temporal subject text | (JSON) The text of the time period. | - | subjectTemporal.text | string |
| Temporal subject URI | (JSON) A URI for the temporal subject, if available. | - | subjectTemporal.URI | string |
| Title subject | A list of titles described or depicted in the contents of the item. Most terms come from [LCNAF](http://id.loc.gov/authorities/names.html). | Subject Title | subjectTitle | array of strings (CSV) / array of objects (JSON) |
| Title subject text | (JSON) The text of the title. | - | subjectTitle.text | string |
| Title subject URI | (JSON) A URI for the title subject, if available. | - | subjectTitle.URI | string |
| Type of resource | A list of broad resource types categorizing the content of the resource. Terms are drawn from the following [list](https://www.loc.gov/standards/mods/userguide/typeofresource.html): (text , still image, moving image, cartographic, notated music, sound recording, three dimensional object, mixed material). | Resource Type | resourceType | array of strings |
| Genre | A list of terms that describe the nature of the content or function of the resource at a greater level of specificity than Type of Resource. This field is currently very uncontrolled, with some terms representing physical form and many items without genre terms at all. Most terms are taken from [LCTGM](http://id.loc.gov/vocabulary/graphicMaterials.html), with some coming from [AAT](http://www.getty.edu/research/tools/vocabularies/aat/), [LCSH](http://id.loc.gov/authorities/subjects.html), and [LCGFT](http://id.loc.gov/authorities/genreForms.html). | Genre | genre | array of strings (CSV) / array of objects (JSON) |
| Genre text | (JSON) The text of the genre. | - | genre.text | string |
| Genre URI | (JSON) The URI of the genre, if available. | - | genre.URI | string |
| Identifier - Bnumber | The catalog identifier, if the item is represented in the NYPL catalog. | Identifier BNumber | identifierBNumber | string |
| Identifier - Accession number | The accession number of the item, if available. | Identifier Accession Number | identifierAccessionNumber | string |
| Identifier - Call number | The call number of the physical item, if available. | Identifier Call Number | identifierCallNumber | string |
| Identifier - ISBN | The ISBN of the item, if available. | Identifier ISBN | identifierISBN | string |
| Identifier - ISSN | The ISSN of the item, if available. | Identifier ISSN | identifierISSN | string |
| Identifier - Interview ID | The interview id of interview items, if available. | Identifier Interview ID | identifierInterviewID | string |
| Identifier - Postcard ID | The publisher series number of the postcard item, if available. | Identifier Postcard ID | identifierPostcardID | string |
| Identifier - LCCN | The LCCN of the item, if available. | Identifier LCCN | identifierLCCN | string |
| Identifier - OCLC/RLIN | The OCLC or RLIN number of the item, if available. | Identifier OCLC/RLIN | identifierOCLCRLIN | string |
| Physical description - Extent | The number and dimensions of the physical item, if available. | Physical Description Extent | physicalDescriptionExtent | array of strings | 
| Physical description - Form | A list of terms describing the physical format or medium of the item. | Physical Description Form | physicalDescriptionForm | array of strings |
| Publisher | The publisher of the item content. | Publisher | publisher | array of strings |
| Place of publication | The place(s) where the item was created or published. | Place Of Publication | placeOfPublication | array of strings |
| Collection UUID | The UUID of the item's parent collection, if applicable. | Collection UUID | collectionUUID | string |
| Container UUID | The UUID of the item's immediate parent container, if applicable. Use this identifier to find an item's parent collection metadata in the Collections data. | Container UUID | containerUUID | string |
| Collection title | The title of the item's parent collection, if applicable. | Collection Title | collectionTitle | string |
| Container Title | The title of the item's immediate parent container, if applicable. | ContainerTitle | containerTitle | string |
| Parent hierarchy | The hierarchy of the item's direct ancestors, from collection to item. | Parent Hierarchy | parentHierarchy | string |
| Number of captures | The number of images comprising the item. | Number of Captures | numberOfCaptures | integer |
| First image | (CSV) A link to the full-size image of the item's first capture. | First Image | - | string |
| Captures | (JSON) A list of links to the full-size jpgs for an item's captures. | - | captures | array of strings |
| Digital Collections URL | A link to the item in [Digital Collections](http://digitalcollections.nypl.org). | Digital Collections URL | digtalCollectionsURL | string |

Example item (JSON version):

```JSON
{
  "UUID": "17159270-c556-012f-af61-58d385a7bc34",
  "databaseID": 3384249,
  "title": "Norway and Sweden, 1895 [part 1].",
  "alternativeTitle": [],
  "contributor": [
    {
      "contributor": "Vinkhuijzen, Hendrik Jacobus",
      "contributorType": "personal",
      "contributorRole": [
        "Collector"
      ],
      "contributorURI": null
    }
  ],
  "date": [],
  "dateStart": null,
  "dateEnd": null,
  "language": [
    "English"
  ],
  "description": [],
  "note": [],
  "subjectTopical": [
    {
      "text": "Military uniforms",
      "URI": "http://id.loc.gov/authorities/subjects/sh85139693"
    },
    {
      "text": "History",
      "URI": "http://id.loc.gov/authorities/subjects/sh85061212"
    }
  ],
  "subjectName": [],
  "subjectGeographic": [],
  "subjectTemporal": [],
  "subjectTitle": [],
  "resourceType": [
    "still image"
  ],
  "genre": [],
  "identifierBNumber": null,
  "identifierAccessionNumber": null,
  "identifierCallNumber": null,
  "identifierISBN": null,
  "identifierISSN": null,
  "identifierInterviewID": null,
  "identifierPostcardID": null,
  "identifierLCCN": null,
  "identifierOCLCRLIN": null,
  "physicalDescriptionExtent": [],
  "physicalDescriptionForm": [],
  "publisher": [],
  "placeOfPublication": [],
  "collectionUUID": "51894d20-c52f-012f-657d-58d385a7bc34",
  "containerUUID": "11eb5c20-c556-012f-f8bb-58d385a7bc34",
  "collectionTitle": "Prints and drawings collected by H.J. Vinkhuijzen",
  "containerTitle": "Norway and Sweden, 1895 [part 1].",
  "parentHierarchy": "Prints and drawings collected by H.J. Vinkhuijzen / Norway and Sweden. / Norway and Sweden, 1895 [part 1].",
  "numberOfCaptures": 1,
  "captures": [
    "http://images.nypl.org/index.php?id=437185&t=g"
  ],
  "digitalCollectionsURL": "http://digitalcollections.nypl.org/items/17159270-c556-012f-af61-58d385a7bc34"
}
```


## Collections

Collections in Digital Collections usually represent physical collections at NYPL. These can be the personal papers of an individual or organization, like the [United States Sanitary Commission Records](http://digitalcollections.nypl.org/collections/united-states-sanitary-commission-records#/?tab=about), artifacts belonging to a prolific collector, like the [Thomas Addis Emmet Collection](http://digitalcollections.nypl.org/collections/thomas-addis-emmet-collection-1483-1876-bulk-1700-1800#/?tab=about), items collected around a certain subject or genre, like [Prints Depicting Dance](Prints depicting dance
) or [Maps of North America](http://digitalcollections.nypl.org/collections/maps-of-north-america#/?tab=about), or works of art the library holds of a particular artist, like Berenice Abbott's [Changing New York](http://digitalcollections.nypl.org/collections/changing-new-york#/?tab=about). Sometimes a "collection" can be a book or or object that has its own distinct intellectual items described further within, like [Apartment Houses of the Metropolis](http://digitalcollections.nypl.org/collections/apartment-houses-of-the-metropolis#/?tab=about).   

Metadata included in the collections files follows the same format as for items, with a few exceptions. Instead of 'Number of captures', 'First image', and 'Captures', the collections data includes the following field:

| Field | Description | CSV | JSON | Value |
| ----- | ----------- | --- | ---- | ----- |
| Number of Items | The number of public domain items contained in the collection. | Number of Items | numberOfItems | integer |

The collections data also does not include 'Parent hierarchy', 'Collection UUID', 'Container UUID', 'Collection title', and 'Container title'. Each collection's own UUID and title are represented in 'UUID', and 'Title'. 


Example collection (JSON version):

```JSON
{
  "UUID": "954eecd0-c5bf-012f-9413-58d385a7bc34",
  "databaseID": 25812,
  "title": "Samuel J. Tilden papers, 1794-1886, bulk (1835-1876).",
  "alternativeTitle": [],
  "contributor": [
    {
      "contributor": "Tilden, Samuel J. (Samuel Jones) (1814-1886)",
      "contributorType": "personal",
      "contributorRole": [
        "Author"
      ],
      "contributorURI": "http://viaf.org/viaf/28125745"
    }
  ],
  "date": [
    1794
  ],
  "dateStart": 1794,
  "dateEnd": 1886,
  "language": [],
  "description": [],
  "note": [
    {
      "type": "ownership",
      "text": "1903 Tilden, Samuel J. - Estate & Trust Gift and purchase"
    },
    {
      "type": "biographical/historical",
      "text": "Samuel Jones Tilden (1814-1886) was an attorney, prominentDemocrat, governor of New York in 1874-1875, and U.S. presidential candidate in 1876."
    },
    {
      "type": "content",
      "text": "The Tilden papers are comprised of correspondence, political and legal files, financial documents, writings, speeches, and personal papers documenting the political and legal career of Samuel J. Tilden. Material dates from 1785 - 1929 (bulk 1832 - 1886)."
    },
    {
      "type": "ownership",
      "text": "MSS 86M75"
    }
  ],
  "subjectTopical": [],
  "subjectName": [
    {
      "text": "New York Public Library",
      "URI": null
    },
    {
      "text": "Tammany Hall",
      "URI": null
    },
    {
      "text": "Tilden, Samuel J. (Samuel Jones), 1814-1886",
      "URI": null
    }
  ],
  "subjectGeographic": [],
  "subjectTemporal": [],
  "subjectTitle": [],
  "resourceType": [
    "mixed material"
  ],
  "genre": [
    {
      "text": "Documents",
      "URI": "http://id.loc.gov/vocabulary/graphicMaterials/tgm003185"
    },
    {
      "text": "Correspondence",
      "URI": "http://id.loc.gov/vocabulary/graphicMaterials/tgm002590"
    },
    {
      "text": "personal papers",
      "URI": ""
    }
  ],
  "identifierBNumber": "b11652246",
  "identifierAccessionNumber": null,
  "identifierCallNumber": "MssCol 2993",
  "identifierISBN": null,
  "identifierISSN": null,
  "identifierInterviewID": null,
  "identifierPostcardID": null,
  "identifierLCCN": null,
  "identifierOCLCRLIN": "NYPW92-A241",
  "physicalDescriptionExtent": [
    "49.4 linear feet (99 boxes, 13 v.)"
  ],
  "physicalDescriptionForm": [],
  "publisher": [],
  "placeOfPublication": [],
  "numberOfItems": 1561,
  "digitalCollectionsURL": "http://digitalcollections.nypl.org/collections/954eecd0-c5bf-012f-9413-58d385a7bc34"
}
```

## Code Examples
We've included a few example scripts and utilities to potentially help you get started digging into the data made available in this repository.

- [all_items.js](https://github.com/NYPL-publicdomain/data-and-utilities/blob/master/code_examples/data_work/node/all_items.js) -- A Node.js script that outputs all the possible data elements for the items included in the `json` streams in this repository, to give you an idea of what the [various elements described above](#items) might contain.

- [all_items.py](https://github.com/NYPL-publicdomain/data-and-utilities/blob/master/code_examples/data_work/python/all_items.py) -- A python script that outputs all the possible data elements for the items included in the `json` streams in this repository, to give you an idea of what the [various elements described above](#items) might contain.

- [download_images.py](https://github.com/NYPL-publicdomain/data-and-utilities/blob/master/code_examples/utilities/download_images.py) -- A(n ugly) python script that could be used to download images of a [Digital Collections](http://digitalcollections.nypl.org) item given the UUID of any multi-capture item. Requires an [NYPL Digital Collections Metadata API](http://api.repo.nypl.org/) token. 

- [API Client](https://github.com/NYPL-publicdomain/api-client) -- A Node.js module to access the [NYPL Digital Collections Metadata API](http://api.repo.nypl.org/) and return all captures for any given item, container, or collection UUID. Requires an API token.
