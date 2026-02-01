# Excalidraw Obsidian File Format

## Overview

Obsidian Excalidraw plugin files are markdown documents with a special structure that combines:
- Human-readable metadata and text content
- Machine-readable compressed diagram data
- References to embedded images

This dual format allows the files to be:
- Searchable in Obsidian (via the Text Elements section)
- Version-controlled with readable diffs
- Editable in the Excalidraw UI within Obsidian

## File Structure

### Complete Structure Example

```markdown
---
excalidraw-plugin: parsed
tags: [excalidraw]
---
==⚠  Switch to EXCALIDRAW VIEW in the MORE OPTIONS menu of this document. ⚠==

## Text Elements
Label Text ^uniqueID
Another Label ^anotherID

## Embedded Files
hash: [[Image.png]]

%%
## Drawing
```compressed-json
N4KAkARALgngDgUwgLgAQQQDwMYEMA2AlgCYBOuA7hADT...
[multi-line Base64 data continues]
```
%%
```

### Section Breakdown

#### 1. YAML Frontmatter (Lines 1-6)

```yaml
---
excalidraw-plugin: parsed
tags: [excalidraw]
---
```

**Purpose**: Metadata for Obsidian and the Excalidraw plugin

**Key Fields**:
- `excalidraw-plugin: parsed` - Identifies this as an Excalidraw file and indicates parsing status
  - Possible values: `parsed`, `raw`
  - `parsed` means the compressed format is being used
- `tags` - Standard Obsidian tags (optional)
- Other custom frontmatter can be added

**Validation**: Our parser checks for `excalidraw-plugin: parsed` to verify the file format.

#### 2. Warning Message (Line 7)

```markdown
==⚠  Switch to EXCALIDRAW VIEW in the MORE OPTIONS menu of this document. ⚠==
```

**Purpose**:
- Alerts users viewing the markdown that they should switch to Excalidraw view
- Hidden in Obsidian's reading view
- Displayed when viewing the raw markdown

**Note**: This line is not required for parsing and can vary between plugin versions.

#### 3. Text Elements Section (Lines ~10-400)

```markdown
## Text Elements
Needs ^kprsXilD

Significance ^MBLwoVrm

Acceptance ^MLKnI5fw
```

**Purpose**:
- Makes diagram text searchable in Obsidian
- Provides human-readable preview of diagram content
- Each text element has a unique ID (format: `^` + random alphanumeric)

**Structure**:
- One text element per line or paragraph
- ID follows the text on the same line
- Empty lines between elements are optional
- Multiline text is preserved

**ID Format**: `^[a-zA-Z0-9]{8}` (8 characters after the caret)

**Relationship to JSON**: These IDs correspond to element IDs in the compressed JSON data, allowing the plugin to sync between the markdown view and the drawing.

#### 4. Embedded Files Section (Optional, Lines ~395-398)

```markdown
## Embedded Files
3cb070fa700fb49926cee6298e2d76fe03424dce: [[Pasted Image 20260112091641_552.png]]
6abebc7cef62a8220af22465d80e0778cc9e04a6: [[Pasted Image 20260112091739_797.png]]
```

**Purpose**:
- References to images embedded in the drawing
- Links images in Obsidian vault to their usage in the diagram

**Structure**:
- Hash (SHA256 or similar) : Obsidian wikilink to image
- Hash corresponds to file IDs in the compressed JSON

**Note**: This section is only present if the drawing contains embedded images.

#### 5. Drawing Section (Lines ~400-end)

```markdown
%%
## Drawing
```compressed-json
N4KAkARALgngDgUwgLgAQQQDwMYEMA2AlgCYBOuA7hADTgQBuCpAzoQPYB2KqATLZMzYBXUtiRoIACyhQ4zZAHoFAc0JRJQgEYA6bGwC2CgF7N6hbEcK4OCtptbErHALRY8RMpWdx8Q1TdIEfARcZgRmBShcZQUebQBGAE5tAAYaOiCEfQQOKGZuAG1wMFAwMogSbggAYQApBAAzGAB5BABrNoB9ABkANgArAFZ+7uUEABUAR0J0sshYRCrA7CiO
[multi-line Base64 continues for many lines]
```
%%
```

**Purpose**: Contains the actual Excalidraw diagram data

**Markers**:
- `%%` - Obsidian comment markers (hides content in reading view)
- `## Drawing` - Section header
- ` ```compressed-json` - Code block with language identifier
- ` ``` ` - Closing code block marker
- `%%` - Closing comment marker

**Data Format**:
- LZ-String compressed data
- Base64 encoded
- Split across multiple lines (typically 256 characters per line)
- Line breaks are for readability and git diff friendliness

**Processing**:
1. Extract content between ` ```compressed-json` and ` ``` `
2. Remove all newline characters to get continuous Base64 string
3. Decompress using `decompressFromBase64()` from lz-string
4. Parse as JSON to get Excalidraw data

## Compression Details

### Algorithm: LZ-String

**Library**: [lz-string](https://pieroxy.net/blog/pages/lz-string/index.html)

**Why LZ-String**:
- JavaScript-native compression (works in browser)
- Good compression ratio for JSON data
- Fast compression/decompression
- Base64 encoding for safe text storage

**NPM Package**: `lz-string` version ^1.5.0

**Compression Function**: `compressToBase64(jsonString)`
**Decompression Function**: `decompressFromBase64(compressedString)`

### Base64 Encoding

**Character Set**: Standard Base64 alphabet
- `A-Z`, `a-z`, `0-9`, `+`, `/`
- Padding: `=` (typically at end)

**Typical Start**: Compressed Excalidraw data usually starts with `N4KA...`

**Line Wrapping**:
- Lines are typically ~256 characters
- This creates readable diffs in git
- All newlines must be removed before decompression

### Decompression Process

```typescript
import { decompressFromBase64 } from 'lz-string';

// 1. Extract from markdown
const match = content.match(/## Drawing\n```compressed-json\n([\s\S]*?)\n```/);
const multiLineBase64 = match[1];

// 2. Remove newlines
const base64String = multiLineBase64.replace(/\n/g, '');

// 3. Decompress
const jsonString = decompressFromBase64(base64String);

// 4. Parse
const excalidrawData = JSON.parse(jsonString);
```

## Excalidraw JSON Structure

After decompression, the data is standard Excalidraw JSON:

```json
{
  "type": "excalidraw",
  "version": 2,
  "source": "https://excalidraw.com",
  "elements": [
    {
      "type": "rectangle",
      "version": 1,
      "id": "elementId123",
      "x": 100,
      "y": 100,
      "width": 200,
      "height": 100,
      "angle": 0,
      "strokeColor": "#1e1e1e",
      "backgroundColor": "transparent",
      "fillStyle": "hachure",
      "strokeWidth": 1,
      "roughness": 1,
      // ... many more properties
    },
    {
      "type": "text",
      "id": "kprsXilD",  // Matches ^kprsXilD in Text Elements section
      "text": "Needs",
      "fontSize": 20,
      // ... text properties
    }
    // ... more elements
  ],
  "appState": {
    "gridSize": null,
    "viewBackgroundColor": "#ffffff"
  },
  "files": {
    "3cb070fa700fb49926cee6298e2d76fe03424dce": {
      "mimeType": "image/png",
      "id": "3cb070fa700fb49926cee6298e2d76fe03424dce",
      "dataURL": "data:image/png;base64,...",
      "created": 1631234567890
    }
  }
}
```

### Key Fields

- **type**: Always "excalidraw"
- **version**: Excalidraw format version (currently 2)
- **source**: URL indicating where the file was created
- **elements**: Array of drawing elements (rectangles, text, arrows, etc.)
- **appState**: Application state (view settings, etc.)
- **files**: Embedded images keyed by hash

## Format Evolution

### Legacy Format

Older versions of the plugin used different storage methods:
- Uncompressed JSON in a code block
- Different frontmatter values
- Different section structures

### Current Format (`parsed`)

The current format indicated by `excalidraw-plugin: parsed`:
- Uses LZ-String compression
- Structured Text Elements section
- Hidden Drawing section with `%%` markers
- Optimized for both human and machine reading

### Migration

The Obsidian Excalidraw plugin automatically updates legacy formats when:
- Opening a file in Excalidraw view
- Editing a diagram
- Using "Decompress current Excalidraw file" command

## File Validation

To validate an Excalidraw Obsidian file:

1. **Check frontmatter**: Must contain `excalidraw-plugin: parsed`
2. **Check Drawing section**: Must have `## Drawing` followed by ` ```compressed-json`
3. **Validate Base64**: Should be valid Base64 characters
4. **Test decompression**: Should decompress without errors
5. **Validate JSON**: Decompressed data should be valid JSON
6. **Check structure**: JSON should have required Excalidraw fields

## Common Issues

### Issue: Decompression fails

**Causes**:
- Corrupted Base64 data
- Incomplete copy/paste
- Manual editing of Drawing section
- Plugin version mismatch

**Solutions**:
- Open in Obsidian and use "Decompress" command
- Re-export from original source
- Check for missing characters

### Issue: Missing Drawing section

**Causes**:
- File in legacy format
- Manually created file
- Incomplete file save

**Solutions**:
- Open in Obsidian to trigger auto-update
- Re-create the drawing

### Issue: Text elements don't match

**Causes**:
- Manual editing of Text Elements section
- Sync issues between sections

**Note**: The Text Elements section is generated from the Drawing data. Manual edits won't affect the actual diagram.

## Tools & Libraries

### Parsing
- **lz-string** (NPM): Decompression
- **Node.js**: File I/O
- **Bun**: Runtime for our tool

### Validation
- **jq**: JSON querying and validation
- **Excalidraw.com**: Visual validation

### Integration
- **Obsidian**: Native editing
- **Git**: Version control (human-readable diffs via Text Elements)

## References

- [Obsidian Excalidraw Plugin GitHub](https://github.com/zsviczian/obsidian-excalidraw-plugin)
- [Plugin Documentation](https://zsviczian.github.io/obsidian-excalidraw-plugin/)
- [File Format Details](https://deepwiki.com/zsviczian/obsidian-excalidraw-plugin/3.1-file-formats-and-conversion)
- [LZ-String Library](https://pieroxy.net/blog/pages/lz-string/index.html)
- [Excalidraw](https://excalidraw.com)
