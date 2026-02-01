# Media Actions

## Table of Contents
- storeMediaFile
- retrieveMediaFile
- getMediaFilesNames
- getMediaDirPath
- deleteMediaFile

## storeMediaFile

Stores a file with the specified base64-encoded contents inside the media folder. Alternatively you can specify a absolute file path, or a url from where the file shell be downloaded. If more than one of data, path and url are provided, the data field will be used first, then path, and finally url. To prevent Anki from removing files not used by any cards (for example, for configuration files), prefix the filename with an underscore. These files are still synchronized to AnkiWeb. Any existing file with the same name is deleted by default. Set deleteExisting to false to prevent that by letting Anki give the new file a non-conflicting name.

Sample request (relative path):

```json
{
    "action": "storeMediaFile",
    "version": 6,
    "params": {
        "filename": "_hello.txt",
        "data": "SGVsbG8sIHdvcmxkIQ=="
    }
}
```

Content of _hello.txt:

```
Hello world!
```

Sample result (relative path):

```json
{
    "result": "_hello.txt",
    "error": null
}
```

Sample request (absolute path):

```json
{
    "action": "storeMediaFile",
    "version": 6,
    "params": {
        "filename": "_hello.txt",
        "path": "/path/to/file"
    }
}
```

Sample result (absolute path):

```json
{
    "result": "_hello.txt",
    "error": null
}
```

Sample request (url):

```json
{
    "action": "storeMediaFile",
    "version": 6,
    "params": {
        "filename": "_hello.txt",
        "url": "https://url.to.file"
    }
}
```

Sample result (url):

```json
{
    "result": "_hello.txt",
    "error": null
}
```

## retrieveMediaFile

Retrieves the base64-encoded contents of the specified file, returning false if the file does not exist.

Sample request:

```json
{
    "action": "retrieveMediaFile",
    "version": 6,
    "params": {
        "filename": "_hello.txt"
    }
}
```

Sample result:

```json
{
    "result": "SGVsbG8sIHdvcmxkIQ==",
    "error": null
}
```

## getMediaFilesNames

Gets the names of media files matched the pattern. Returning all names by default.

Sample request:

```json
{
    "action": "getMediaFilesNames",
    "version": 6,
    "params": {
        "pattern": "_hell*.txt"
    }
}
```

Sample result:

```json
{
    "result": ["_hello.txt"],
    "error": null
}
```

## getMediaDirPath

Gets the full path to the collection.media folder of the currently opened profile.

Sample request:

```json
{
    "action": "getMediaDirPath",
    "version": 6
}
```

Sample result:

```json
{
    "result": "/home/user/.local/share/Anki2/Main/collection.media",
    "error": null
}
```

## deleteMediaFile

Deletes the specified file inside the media folder.

Sample request:

```json
{
    "action": "deleteMediaFile",
    "version": 6,
    "params": {
        "filename": "_hello.txt"
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
