# Termbases
</br>

## Creating a termbase

A termbase can be created by making a `POST` request to the [`/termbases`](../../api/Public-API.v1-fv.html#/operations/CreateTermbase) endpoint.

You can create a termbase based on an existing termbase template by providing the `termbaseTemplateId`. This will create the termbase using the structure described by the template. For details about termbase templates, see [`Termbase Template`](../../docs/termbase/Termbase-templates.md). Postman example:


![Create Termbase With TemplateId](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/PublicAPI/CreateTermbaseWithTemplateId.gif?raw=true)


Request example: `POST /termbases`
```json
{
    "name": "Simple Termbase",
    "description": "A simple termbase",
    "copyright": "RWS",
    "location" : "60b0a03152a974047fd46fb0"
    "termbaseTemplateId": "your-termbase-template-id"
}
```

If, however, you wish to provide your own custom termbase structure, you can do so by supplying it via the `termbaseStructure` object in the request body. Postman example:


![Create Termbase With Structure](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/PublicAPI/CreateTermbaseWithStructure.gif?raw=true)

Request example: `POST /termbases`
```json
{
    "name": "Simple Termbase",
    "description": "A simple termbase",
    "copyright": "RWS",
    "location" : "60b0a03152a974047fd46fb0"
    "termbaseStructure": {
        "languages": [
            {
                "languageCode": "en-US"
            }
        ],
        "fields": [
            {
                "name": "Entry level field",
                "description": "A simple entry level field description.",
                "level": "entry",
                "allowCustomValues": true,
                "allowMultiple": true,
                "isMandatory": false
                "dataType": "picklist",
                "pickListValues": [
                    "picklist-value-1",
                    "picklist-value-2",
                    "picklist-value-3"
                ]
            }
        ]
    }
}
```


Response example:
```json
{
    "id": "6171694efb696c53e5ad726e",
    "name": "Simple Termbase",
    "location": {
        "id": "60b0a03152a974047fd46fb0",
        "name": "RWS"
    }
}
```
> Note: If both the `termbaseTemplateId` and the `termbaseStructure` are added in the request, the `termbaseStructure` takes precedence. In other words, the `termbaseTemplateId` is ignored.


## Updating a termbase
> You can update the fields for a termbase only if the termbase you want to update was not created using a termbase template or if it does not already have fields defined.

A termbase can be updated by making a `PUT` request to the [`/termbases/{termbaseId}`](../../api/Public-API.v1-fv.html#/operations/UpdateTermbase) endpoint and providing the `termbaseTemplateId`.

Request example: `PUT /termbases/616d0efa7a11677d6085b0be`
```json
{
    "name": "[UPDATED] Simple Termbase",
    "description": "A simple termbase",
    "copyright": "[UPDATED] RWS",
    "termbaseTemplateId" : "your-termbase-template-id" 
}
```

If, however, you wish to provide your own custom termbase structure, you can do so by supplying it via the `termbaseStructure` object in the request body. Postman example:


![Update Termbase With Structure](https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/PublicAPI/UpdateTermbaseWithStructure.gif?raw=true)

Request example: `PUT /termbases/616d0efa7a11677d6085b0be`
```json
{
    "name": "[UPDATED] Simple Termbase",
    "description": "A simple termbase",
    "copyright": "[UPDATED] RWS",
    "termbaseStructure": {
        "languages": [
            {
                "languageCode": "en-US"
            }
        ],
        "fields": [
            {
                "id": "616d0efa7a12676d603b71ad",
                "name": "[UPDATED] Entry level field",
                "description": "A simple entry level field description.",
                "level": "entry",
                "dataType": "text",
                "allowMultiple": true,
                "isMandatory": false
            }
        ]
    }
}
```
> Note: If both the `termbaseTemplateId` and the `termbaseStructure` are added in the request, the `termbaseStructure` takes precedence. In other words, the `termbaseTemplateId` is ignored.

> Note: If you perform an update using a termbase field without an `id`, the field will be added to the termbase.

## Retrieving a termbase

A termbase can be retrieved by making a `GET` request to the [`/termbases/{termbaseId}`](../../api/Public-API.v1-fv.html#/operations/GetTermbase) endpoint.

Request example: `GET /termbases/616d0efa7a11677d6085b0be`

Response example:
```json
{
    "id": "616d28597a11677d60862233",
    "name": "[UPDATED] Simple Termbase",
    "copyright": "[UPDATED] RWS",
    "location": {
        "id": "60b0a03152a974047fd46fb0",
        "name": "RWS"
    }
}
```
</br>

## Retrieving the list of termbases

You can retrieve the list of termbases by making a `GET` request to the [`/termbases`](../../api/Public-API.v1-fv.html#/operations/ListTermbase) endpoint.

Request example: `GET /termbases`

Response example:
```json
{
    "items": [
        {
            "id": "616d28597a11677d60862233",
            "name": "[UPDATED] Simple Termbase",
            "location": {
                "id": "60b0a03152a974047fd46fb0",
                "name": "RWS"
            }
        },
        {
            "id": "616d0efa7a11677d6085b0be",
            "name": "New Termbase",
            "location": {
                "id": "60b0a03152a974047fd46fb0",
                "name": "RWS"
            }
        }
    ],
    "itemCount": 2
}
```

> Note: Some properties are not available for this endpoint: `numberOfEntries`, `status`, `createdAt` and `lastModifiedAt`.

## Deleting termbases

A termbase can be deleted by making a `DELETE` request to the [`/termbases/{termbaseId}`](../../api/Public-API.v1-fv.html#/operations/DeleteTermbase) endpoint.

Request example: `DELETE /termbases/616d0efa7a11677d6085b0be`
