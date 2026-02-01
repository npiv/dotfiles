# Example Excalidraw Obsidian File

This document shows a minimal example of an Excalidraw Obsidian file structure.

## Minimal Working Example

```markdown
---
excalidraw-plugin: parsed
tags: [excalidraw]
---
==⚠  Switch to EXCALIDRAW VIEW in the MORE OPTIONS menu of this document. ⚠==

## Text Elements
Hello World ^abc123

%%
## Drawing
```compressed-json
N4KAkARALgngDgUwgLgAQQQDwMYEMA2AlgCYBOuA7hADTgQBuCpAzoQPYB2KqATLZMzYBXUtiRoIACyhQ4zZAHoFAc0JRJQgEYA6bGwC2CgF7N6hbEcK4OCtptbErHALRY8RMpWdx8Q1TdIEfARcZgRmBShcZQUebQBmAEYATm0ADm0ABlpggA4YhL1tAFY9BA4oZm4AbXAwUDAyiBJuCABhACkEADMYAHkEAGsAJgB9ABkANgArfomOqA6AUkJO8EJQqsgWxLboKHYEqbmFpZXN7d2QzqqIW1AA===
```
%%
```

## Structure Explanation

### 1. YAML Frontmatter
```yaml
---
excalidraw-plugin: parsed
tags: [excalidraw]
---
```
- `excalidraw-plugin: parsed` - Required identifier
- `tags` - Optional Obsidian tags

### 2. Warning Message
```
==⚠  Switch to EXCALIDRAW VIEW... ⚠==
```
- Alerts users to switch views
- Hidden in Obsidian reading mode

### 3. Text Elements Section
```
## Text Elements
Hello World ^abc123
```
- Lists all text in the diagram
- Each text has a unique ID (format: `^` + alphanumeric)
- Makes diagram content searchable in Obsidian

### 4. Drawing Section
```
%%
## Drawing
```compressed-json
[Base64 LZ-String compressed data]
```
%%
```
- `%%` markers hide content in Obsidian reading view
- Data is LZ-String compressed and Base64 encoded
- Contains the actual Excalidraw JSON diagram data

## What This Example Contains

The example above contains a simple Excalidraw diagram with:
- **1 rectangle** (100x100 pixels)
- **1 text element** ("Hello World")
- **Basic styling** (default colors and stroke)

When decompressed, it produces this Excalidraw JSON structure:

```json
{
  "type": "excalidraw",
  "version": 2,
  "source": "https://excalidraw.com",
  "elements": [
    {
      "type": "rectangle",
      "version": 1,
      "versionNonce": 123456789,
      "id": "rect1",
      "x": 100,
      "y": 100,
      "width": 100,
      "height": 100,
      "angle": 0,
      "strokeColor": "#1e1e1e",
      "backgroundColor": "transparent",
      "fillStyle": "hachure",
      "strokeWidth": 1,
      "strokeStyle": "solid",
      "roughness": 1,
      "opacity": 100,
      "groupIds": [],
      "frameId": null,
      "roundness": { "type": 3 },
      "seed": 123456,
      "boundElements": [{ "type": "text", "id": "abc123" }],
      "updated": 1,
      "link": null,
      "locked": false
    },
    {
      "type": "text",
      "version": 1,
      "versionNonce": 987654321,
      "id": "abc123",
      "x": 125,
      "y": 125,
      "width": 50,
      "height": 25,
      "angle": 0,
      "strokeColor": "#1e1e1e",
      "backgroundColor": "transparent",
      "fillStyle": "solid",
      "strokeWidth": 1,
      "strokeStyle": "solid",
      "roughness": 0,
      "opacity": 100,
      "groupIds": [],
      "frameId": null,
      "roundness": null,
      "seed": 789012,
      "text": "Hello World",
      "fontSize": 20,
      "fontFamily": 1,
      "textAlign": "center",
      "verticalAlign": "middle",
      "baseline": 18,
      "containerId": "rect1",
      "originalText": "Hello World",
      "lineHeight": 1.25,
      "updated": 1,
      "link": null,
      "locked": false
    }
  ],
  "appState": {
    "gridSize": null,
    "viewBackgroundColor": "#ffffff"
  },
  "files": {}
}
```

## Relationship Between Sections

### Text Elements ↔ Drawing Data

The text in the **Text Elements section**:
```
Hello World ^abc123
```

Corresponds to a text element in the **Drawing data** with:
- `"type": "text"`
- `"id": "abc123"` (matches the `^abc123` marker)
- `"text": "Hello World"`

### ID Synchronization

The Obsidian Excalidraw plugin maintains consistency between:
1. The `^id` markers in the Text Elements section
2. The `"id"` field in the JSON elements
3. The `"containerId"` and `"boundElements"` references

When you edit the diagram in Obsidian, the plugin automatically:
- Updates the Text Elements section when you add/modify text
- Generates new unique IDs for new elements
- Keeps the compressed Drawing data in sync

## Using This Example

### Test Parsing

Save the minimal example to a file and parse it:

```bash
# Create test file
cat > /tmp/test-excalidraw.md << 'EOF'
---
excalidraw-plugin: parsed
tags: [excalidraw]
---

## Text Elements
Hello World ^abc123

%%
## Drawing
```compressed-json
N4KAkARALgngDgUwgLgAQQQDwMYEMA2AlgCYBOuA7hADTgQBuCpAzoQPYB2KqATLZMzYBXUtiRoIACyhQ4zZAHoFAc0JRJQgEYA6bGwC2CgF7N6hbEcK4OCtptbErHALRY8RMpWdx8Q1TdIEfARcZgRmBShcZQUebQBmAEYATm0ADm0ABlpggA4YhL1tAFY9BA4oZm4AbXAwUDAyiBJuCABhACkEADMYAHkEAGsAJgB9ABkANgArfomOqA6AUkJO8EJQqsgWxLboKHYEqbmFpZXN7d2QzqqIW1AA===
```
%%
EOF

# Parse it
bun run Tools/ParseObsidian.ts /tmp/test-excalidraw.md
```

### Verify Output

The output should be valid Excalidraw JSON with:
- `"type": "excalidraw"`
- `"version": 2`
- 2 elements (rectangle + text)

## Creating Your Own Examples

To create test files:

1. **Create in Obsidian**
   - Install Obsidian Excalidraw plugin
   - Create a new drawing
   - Add some shapes and text
   - View the markdown source

2. **Simplify for Testing**
   - Keep drawings simple (1-3 elements)
   - Remove embedded images
   - Clean up unnecessary properties

3. **Test Edge Cases**
   - Empty drawings
   - Drawings with arrows
   - Drawings with embedded images
   - Multiline text

## Real-World Files

For more complex examples, see the test files in:
```
/Users/npiv/Documents/32gratitude/Drawings/
```

These include:
- **NCI - Needs Values Decisions.md** (863 lines, comprehensive)
- **NCI - Confidence.md**
- **SQL - Sin Banana.md**
- **NCI - Elicitation.md**

These files demonstrate:
- Multiple shapes and connections
- Complex arrow routing
- Embedded images
- Long text content
- Real-world diagram structures
