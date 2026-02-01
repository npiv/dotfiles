---
name: parse-obsidian-excalidraw-file
description: Parse Excalidraw Obsidian markdown files and convert to raw Excalidraw JSON. Use when you need to extract or convert Obsidian Excalidraw drawings.
---

# Excalidraw Obsidian Parser

Extract raw Excalidraw JSON from Obsidian Excalidraw plugin markdown files.

## What It Does

The Obsidian Excalidraw plugin stores drawings as LZ-String compressed Base64 data within markdown files. This tool:

1. Extracts the compressed data from the `## Drawing` section
2. Decompresses using LZ-String Base64 decompression
3. Outputs valid Excalidraw JSON that works with excalidraw.com

The output can be:
- Saved to a `.excalidraw` file and opened in Excalidraw
- Piped to tools like `jq` for analysis
- Used as input for other processing tools

## Quick Start

```bash
# Parse to stdout
bun run Tools/ParseObsidian.ts ~/path/to/drawing.md

# Save to file
bun run Tools/ParseObsidian.ts ~/path/to/drawing.md output.excalidraw
```

## Usage

```
bun run Tools/ParseObsidian.ts <input-file> [output-file]

Arguments:
  input-file    Path to Excalidraw Obsidian .md file
  output-file   Optional output path (default: stdout)

Options:
  --help, -h    Show help message
```

## Input Format

Expects Obsidian markdown files created by the Excalidraw plugin with:

- YAML frontmatter containing `excalidraw-plugin: parsed`
- `## Drawing` section with ` ```compressed-json` code block
- LZ-String Base64 compressed Excalidraw data

Example structure:
```markdown
---
excalidraw-plugin: parsed
tags: [excalidraw]
---

## Text Elements
...

%%
## Drawing
```compressed-json
N4KAkARALgngDgUwgLgAQQQDwMYEMA2AlgCYBOuA7hADT...
```
%%
```

## Output Format

Valid Excalidraw JSON that can be opened at excalidraw.com:

```json
{
  "type": "excalidraw",
  "version": 2,
  "source": "https://excalidraw.com",
  "elements": [...],
  "appState": {...},
  "files": {...}
}
```

## Examples

### Extract and Save

```bash
# Convert Obsidian file to Excalidraw format
bun run Tools/ParseObsidian.ts "My Diagram.md" diagram.excalidraw

# Open the result at excalidraw.com
open https://excalidraw.com
# Then drag diagram.excalidraw onto the page
```

### Analyze with jq

```bash
# Count total elements
bun run Tools/ParseObsidian.ts drawing.md | jq '.elements | length'

# Count text elements
bun run Tools/ParseObsidian.ts drawing.md | jq '[.elements[] | select(.type=="text")] | length'

# List all element types
bun run Tools/ParseObsidian.ts drawing.md | jq '[.elements[].type] | unique'

# Extract all text content
bun run Tools/ParseObsidian.ts drawing.md | jq -r '.elements[] | select(.type=="text") | .text'
```

### Preview Structure

```bash
# See first element
bun run Tools/ParseObsidian.ts drawing.md | jq '.elements[0]'

# Check version and source
bun run Tools/ParseObsidian.ts drawing.md | jq '{type, version, source}'

# Count embedded files
bun run Tools/ParseObsidian.ts drawing.md | jq '.files | length'
```

## Troubleshooting

### Error: Not a valid Excalidraw Obsidian file

**Cause**: The file doesn't have `excalidraw-plugin: parsed` in the YAML frontmatter.

**Solution**: Make sure the file was created by the Obsidian Excalidraw plugin. This tool only works with Obsidian Excalidraw plugin files.

### Error: Failed to decompress

**Cause**: The compressed data is corrupted or in an unexpected format.

**Solutions**:
1. Try opening the file in Obsidian
2. Use Command Palette: "Decompress current Excalidraw file"
3. Save the file again in Obsidian
4. Try parsing the newly saved version

### Error: No ## Drawing section found

**Cause**: The file may be in a legacy format or the Drawing section is missing.

**Solution**: Open the file in Obsidian. The plugin should automatically update it to the current format when you open or edit it.

### Output doesn't render correctly in Excalidraw

**Cause**: The JSON structure may be valid but contain unsupported features.

**Solutions**:
1. Check the Excalidraw version compatibility
2. Try opening the original file in Obsidian first to verify it works there
3. Check for any console errors at excalidraw.com

## Technical Details

### Compression Format

- **Algorithm**: LZ-String
- **Encoding**: Base64
- **Library**: [lz-string](https://www.npmjs.com/package/lz-string) NPM package
- **Function**: `decompressFromBase64()`

### File Structure

The Obsidian Excalidraw plugin stores files with:

1. **YAML frontmatter** - Metadata and plugin info
2. **Text Elements section** - Searchable text content with IDs
3. **Embedded Files section** - References to images (optional)
4. **Drawing section** - Compressed Excalidraw JSON data

The Drawing section is wrapped in `%%` comment markers (hidden in Obsidian reading view) and contains the actual diagram data as multi-line Base64 LZ-String compressed text.

### References

- [Obsidian Excalidraw Plugin](https://github.com/zsviczian/obsidian-excalidraw-plugin)
- [LZ-String Library](https://pieroxy.net/blog/pages/lz-string/index.html)
- [Excalidraw](https://excalidraw.com)

## Installation

The tool requires the `lz-string` dependency, which should already be installed if you're using this skill.

If needed, install it manually:

```bash
cd /Users/npiv/code/data/skills/excalidraw-obsidian
npm install lz-string
```

## Use Cases

### Documentation Workflow

1. Create diagrams in Obsidian (great for notes integration)
2. Parse to `.excalidraw` format
3. Share `.excalidraw` files with team members who don't use Obsidian
4. Open and edit at excalidraw.com

### Automation

```bash
# Process all Excalidraw files in a directory
for file in ~/Documents/MyNotes/Drawings/*.md; do
  output="${file%.md}.excalidraw"
  bun run Tools/ParseObsidian.ts "$file" "$output"
done
```

### Content Analysis

```bash
# Extract all diagram text for full-text search
for file in *.md; do
  echo "=== $file ==="
  bun run Tools/ParseObsidian.ts "$file" | jq -r '.elements[] | select(.type=="text") | .text'
done
```

### Version Control

Parse Excalidraw Obsidian files to standard JSON format for better diff viewing in git:

```bash
# Convert for comparison
bun run Tools/ParseObsidian.ts old-version.md old.json
bun run Tools/ParseObsidian.ts new-version.md new.json
diff old.json new.json
```
