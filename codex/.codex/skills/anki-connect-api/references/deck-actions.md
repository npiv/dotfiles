# Deck Actions

## Table of Contents
- deckNames
- deckNamesAndIds
- getDecks
- createDeck
- changeDeck

## deckNames

Gets the complete list of deck names for the current user.

Sample request:

```json
{
    "action": "deckNames",
    "version": 6
}
```

Sample result:

```json
{
    "result": ["Default"],
    "error": null
}
```

## deckNamesAndIds

Gets the complete list of deck names and their respective IDs for the current user.

Sample request:

```json
{
    "action": "deckNamesAndIds",
    "version": 6
}
```

Sample result:

```json
{
    "result": {"Default": 1},
    "error": null
}
```

## getDecks

Accepts an array of card IDs and returns an object with each deck name as a key, and its value an array of the given cards which belong to it.

Sample request:

```json
{
    "action": "getDecks",
    "version": 6,
    "params": {
        "cards": [1502298036657, 1502298033753, 1502032366472]
    }
}
```

Sample result:

```json
{
    "result": {
        "Default": [1502032366472],
        "Japanese::JLPT N3": [1502298036657, 1502298033753]
    },
    "error": null
}
```

## createDeck

Create a new empty deck. Will not overwrite a deck that exists with the same name.

Sample request:

```json
{
    "action": "createDeck",
    "version": 6,
    "params": {
        "deck": "Japanese::Tokyo"
    }
}
```

Sample result:

```json
{
    "result": 1519323742721,
    "error": null
}
```

## changeDeck

Moves cards with the given IDs to a different deck, creating the deck if it doesn't exist yet.

Sample request:

```json
{
    "action": "changeDeck",
    "version": 6,
    "params": {
        "cards": [1502098034045, 1502098034048, 1502298033753],
        "deck": "Japanese::JLPT N3"
    }
}
```

Sample result:

```json
{
    "result": null,
    "error": null
}
```
