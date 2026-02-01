# Anki-Connect Overview

## Table of Contents
- Purpose and server behavior
- Request and response format
- Versioning and compatibility
- Authentication
- Sample requests

## Purpose and server behavior

Anki-Connect enables external applications to communicate with Anki over a simple HTTP API. Its capabilities include executing queries against the user's card deck, automatically creating new cards, and more. Anki-Connect is compatible with the latest stable (2.1.x) releases of Anki; older versions (2.0.x and below) are no longer supported.

Anki-Connect exposes internal Anki features to external applications via an easy to use API. After being installed, this plugin will start an HTTP server on port 8765 whenever Anki is launched. Other applications (including browser extensions) can then communicate with it via HTTP requests.

By default, Anki-Connect will only bind the HTTP server to the 127.0.0.1 IP address, so that you will only be able to access it from the same host on which it is running. If you need to access it over a network, you can change the binding address in the configuration. Go to Tools->Add-ons->AnkiConnect->Config and change the "webBindAddress" value. For example, you can set it to 0.0.0.0 in order to bind it to all network interfaces on your host. This also requires a restart for Anki.

## Request and response format

Every request consists of a JSON-encoded object containing an action, a version, contextual params, and a key value used for authentication (which is optional and can be omitted by default). Anki-Connect will respond with an object containing two fields: result and error. The result field contains the return value of the executed API, and the error field is a description of any exception thrown during API execution (the value null is used if execution completed successfully).

Sample successful response:

```json
{"result": ["Default", "Filtered Deck 1"], "error": null}
```

Samples of failed responses:

```json
{"result": null, "error": "unsupported action"}
```

```json
{"result": null, "error": "guiBrowse() got an unexpected keyword argument 'foobar'"}
```

## Versioning and compatibility

For compatibility with clients designed to work with older versions of Anki-Connect, failing to provide a version field in the request will make the version default to 4. Furthermore, when the provided version is level 4 or below, the API response will only contain the value of the result; no error field is available for error handling.

## Authentication

Anki-Connect supports requiring authentication in order to make API requests. This support is disabled by default, but can be enabled by setting the apiKey field of Anki-Config's settings (Tools->Add-ons->AnkiConnect->Config) to a desired string. If you have done so, you should see the requestPermission API request return true for requireApiKey. You then must include an additional parameter called key in any further API request bodies, whose value must match the configured API key.

## Sample requests

Curl:

```bash
curl localhost:8765 -X POST -d '{"action": "deckNames", "version": 6}'
```

Powershell:

```powershell
(Invoke-RestMethod -Uri http://localhost:8765 -Method Post -Body '{"action": "deckNames", "version": 6}').result
```

Python:

```python
import json
import urllib.request

def request(action, **params):
    return {'action': action, 'params': params, 'version': 6}

def invoke(action, **params):
    requestJson = json.dumps(request(action, **params)).encode('utf-8')
    response = json.load(urllib.request.urlopen(urllib.request.Request('http://127.0.0.1:8765', requestJson)))
    if len(response) != 2:
        raise Exception('response has an unexpected number of fields')
    if 'error' not in response:
        raise Exception('response is missing required error field')
    if 'result' not in response:
        raise Exception('response is missing required result field')
    if response['error'] is not None:
        raise Exception(response['error'])
    return response['result']

invoke('createDeck', deck='test1')
result = invoke('deckNames')
print('got list of decks: {}'.format(result))
```

JavaScript:

```javascript
function invoke(action, version, params={}) {
    return new Promise((resolve, reject) => {
        const xhr = new XMLHttpRequest();
        xhr.addEventListener('error', () => reject('failed to issue request'));
        xhr.addEventListener('load', () => {
            try {
                const response = JSON.parse(xhr.responseText);
                if (Object.getOwnPropertyNames(response).length != 2) {
                    throw 'response has an unexpected number of fields';
                }
                if (!response.hasOwnProperty('error')) {
                    throw 'response is missing required error field';
                }
                if (!response.hasOwnProperty('result')) {
                    throw 'response is missing required result field';
                }
                if (response.error) {
                    throw response.error;
                }
                resolve(response.result);
            } catch (e) {
                reject(e);
            }
        });

        xhr.open('POST', 'http://127.0.0.1:8765');
        xhr.send(JSON.stringify({action, version, params}));
    });
}

await invoke('createDeck', 6, {deck: 'test1'});
const result = await invoke('deckNames', 6);
console.log(`got list of decks: ${result}`);
```
