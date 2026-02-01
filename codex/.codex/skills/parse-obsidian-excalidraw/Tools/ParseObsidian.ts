#!/usr/bin/env bun

/**
 * ParseObsidian - Excalidraw Obsidian File Parser
 *
 * Extracts and decompresses Excalidraw JSON from Obsidian markdown files.
 * The Obsidian Excalidraw plugin stores drawings as LZ-String compressed
 * Base64 data within markdown. This tool extracts and converts it to
 * standard Excalidraw JSON format.
 *
 * Usage:
 *   bun run ParseObsidian.ts <input-file> [output-file]
 *   bun run ParseObsidian.ts --help
 */

import { readFile, writeFile } from "node:fs/promises";
import { resolve, basename } from "node:path";
import { decompressFromBase64 } from "lz-string";

// ============================================================================
// Types
// ============================================================================

interface ExcalidrawData {
  type: string;
  version: number;
  source: string;
  elements: any[];
  appState: any;
  files: any;
}

// ============================================================================
// Error Handling
// ============================================================================

class ParseError extends Error {
  constructor(message: string, public exitCode: number = 1) {
    super(message);
    this.name = "ParseError";
  }
}

// ============================================================================
// Core Functions
// ============================================================================

/**
 * Read and validate an Excalidraw Obsidian markdown file
 */
async function readObsidianFile(path: string): Promise<string> {
  try {
    const content = await readFile(path, "utf-8");

    // Validate it's an Excalidraw Obsidian file by checking frontmatter
    if (!content.includes("excalidraw-plugin: parsed")) {
      throw new ParseError(
        "Not a valid Excalidraw Obsidian file. Missing 'excalidraw-plugin: parsed' in frontmatter."
      );
    }

    return content;
  } catch (error) {
    if (error instanceof ParseError) {
      throw error;
    }
    if ((error as any).code === "ENOENT") {
      throw new ParseError(`Input file not found: ${path}`);
    }
    throw new ParseError(`Failed to read file: ${(error as Error).message}`);
  }
}

/**
 * Extract compressed data from the ## Drawing section
 */
function extractCompressedData(content: string): string {
  // Match everything between ## Drawing section markers
  const match = content.match(/## Drawing\n```compressed-json\n([\s\S]*?)\n```/);

  if (!match || !match[1]) {
    throw new ParseError(
      "No ## Drawing section found. This file may be corrupted or in an unsupported format."
    );
  }

  // Remove all newlines to get continuous Base64 string
  const compressed = match[1].replace(/\n/g, "");

  if (!compressed || compressed.length === 0) {
    throw new ParseError("Drawing section is empty.");
  }

  return compressed;
}

/**
 * Decompress LZ-String Base64 encoded data
 */
function decompressData(compressed: string): string {
  const decompressed = decompressFromBase64(compressed);

  if (!decompressed) {
    throw new ParseError(
      "Failed to decompress data. The file may be corrupted. " +
      "Try opening in Obsidian and using 'Decompress current Excalidraw file' from the command palette."
    );
  }

  return decompressed;
}

/**
 * Parse and validate Excalidraw JSON
 */
function parseAndValidate(jsonString: string): ExcalidrawData {
  try {
    const data = JSON.parse(jsonString);

    // Basic validation of Excalidraw structure
    if (!data.type || !data.elements || !Array.isArray(data.elements)) {
      throw new ParseError(
        "Invalid Excalidraw data structure. Missing required fields (type, elements)."
      );
    }

    return data;
  } catch (error) {
    if (error instanceof ParseError) {
      throw error;
    }
    throw new ParseError(
      `Invalid JSON after decompression: ${(error as Error).message}`
    );
  }
}

/**
 * Write output to file or stdout
 */
async function writeOutput(data: ExcalidrawData, outputPath?: string): Promise<void> {
  const formatted = JSON.stringify(data, null, 2);

  if (outputPath) {
    try {
      await writeFile(outputPath, formatted, "utf-8");
      console.error(`✓ Successfully parsed and saved to: ${outputPath}`);
      console.error(`  Elements: ${data.elements.length}`);
      console.error(`  Version: ${data.version}`);
    } catch (error) {
      throw new ParseError(
        `Failed to write output file: ${(error as Error).message}`
      );
    }
  } else {
    // Write to stdout for piping
    console.log(formatted);
  }
}

// ============================================================================
// CLI Interface
// ============================================================================

function showHelp(): void {
  console.log(`
ParseObsidian - Extract Excalidraw JSON from Obsidian files

USAGE:
  bun run ParseObsidian.ts <input-file> [output-file]
  bun run ParseObsidian.ts --help

ARGUMENTS:
  input-file   Path to Excalidraw Obsidian .md file
  output-file  Optional output path (default: stdout)

EXAMPLES:
  # Print to stdout
  bun run ParseObsidian.ts drawing.md

  # Save to file
  bun run ParseObsidian.ts drawing.md output.excalidraw

  # Pipe to jq for analysis
  bun run ParseObsidian.ts drawing.md | jq '.elements | length'

  # Count text elements
  bun run ParseObsidian.ts drawing.md | jq '[.elements[] | select(.type=="text")] | length'

ABOUT:
  The Obsidian Excalidraw plugin stores drawings as LZ-String compressed
  Base64 data within markdown files. This tool extracts and decompresses
  that data into standard Excalidraw JSON format that works with excalidraw.com.

FILE FORMAT:
  Input files must have:
  - YAML frontmatter with 'excalidraw-plugin: parsed'
  - ## Drawing section with compressed-json code block
  - LZ-String Base64 compressed data

OUTPUT FORMAT:
  Standard Excalidraw JSON:
  {
    "type": "excalidraw",
    "version": 2,
    "source": "https://excalidraw.com",
    "elements": [...],
    "appState": {...},
    "files": {...}
  }

TROUBLESHOOTING:
  Error: Not a valid Excalidraw Obsidian file
    → Make sure the file was created by the Obsidian Excalidraw plugin

  Error: Failed to decompress
    → File may be corrupted. Try opening in Obsidian and using
      Command Palette: "Decompress current Excalidraw file"

  Error: No ## Drawing section found
    → File may be in legacy format. Open in Obsidian to update.
`);
}

// ============================================================================
// Main
// ============================================================================

async function main(): Promise<void> {
  const args = process.argv.slice(2);

  // Handle help flag
  if (args.includes("--help") || args.includes("-h") || args.length === 0) {
    showHelp();
    process.exit(0);
  }

  // Parse arguments
  const inputPath = resolve(args[0]);
  const outputPath = args[1] ? resolve(args[1]) : undefined;

  try {
    // Process the file
    const content = await readObsidianFile(inputPath);
    const compressed = extractCompressedData(content);
    const decompressed = decompressData(compressed);
    const data = parseAndValidate(decompressed);
    await writeOutput(data, outputPath);

  } catch (error) {
    if (error instanceof ParseError) {
      console.error(`✗ Error: ${error.message}`);
      process.exit(error.exitCode);
    }
    // Unexpected errors
    console.error(`✗ Unexpected error: ${(error as Error).message}`);
    console.error((error as Error).stack);
    process.exit(1);
  }
}

main();
