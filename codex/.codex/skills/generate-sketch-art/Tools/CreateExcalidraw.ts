#!/usr/bin/env bun

/**
 * CreateExcalidraw.ts
 * Creates actual .excalidraw JSON files programmatically
 */

import { writeFileSync } from 'fs';
import { resolve } from 'path';

// Color palette
const COLORS = {
  background: '#0a0a0f',
  paiBlue: '#4a90d9',
  cyan: '#22d3ee',
  white: '#e5e7eb',
  lineWork: '#94a3b8',
  surface: '#1a1a2e',
};

interface ExcalidrawElement {
  type: string;
  version: number;
  versionNonce: number;
  isDeleted: boolean;
  id: string;
  fillStyle: string;
  strokeWidth: number;
  strokeStyle: string;
  roughness: number;
  opacity: number;
  angle: number;
  x: number;
  y: number;
  strokeColor: string;
  backgroundColor: string;
  width: number;
  height: number;
  seed: number;
  groupIds: string[];
  frameId: null;
  roundness: { type: number } | null;
  boundElements: null;
  updated: number;
  link: null;
  locked: boolean;
  fontSize?: number;
  fontFamily?: number;
  text?: string;
  textAlign?: string;
  verticalAlign?: string;
  containerId?: null;
  originalText?: string;
  lineHeight?: number;
  baseline?: number;
  points?: number[][];
  lastCommittedPoint?: null;
  startBinding?: null;
  endBinding?: null;
  startArrowhead?: null;
  endArrowhead?: string;
}

function generateId(): string {
  return Math.random().toString(36).substring(2, 15) + Math.random().toString(36).substring(2, 15);
}

function createRectangle(
  x: number,
  y: number,
  width: number,
  height: number,
  strokeColor: string = COLORS.white,
  backgroundColor: string = 'transparent'
): ExcalidrawElement {
  return {
    type: 'rectangle',
    version: 1,
    versionNonce: Math.floor(Math.random() * 1000000000),
    isDeleted: false,
    id: generateId(),
    fillStyle: 'solid',
    strokeWidth: 2,
    strokeStyle: 'solid',
    roughness: 1,
    opacity: 100,
    angle: 0,
    x,
    y,
    strokeColor,
    backgroundColor,
    width,
    height,
    seed: Math.floor(Math.random() * 1000000000),
    groupIds: [],
    frameId: null,
    roundness: { type: 3 },
    boundElements: null,
    updated: Date.now(),
    link: null,
    locked: false,
  };
}

function createText(
  x: number,
  y: number,
  text: string,
  fontSize: number = 20,
  color: string = COLORS.white
): ExcalidrawElement {
  return {
    type: 'text',
    version: 1,
    versionNonce: Math.floor(Math.random() * 1000000000),
    isDeleted: false,
    id: generateId(),
    fillStyle: 'solid',
    strokeWidth: 2,
    strokeStyle: 'solid',
    roughness: 1,
    opacity: 100,
    angle: 0,
    x,
    y,
    strokeColor: color,
    backgroundColor: 'transparent',
    width: text.length * fontSize * 0.6,
    height: fontSize * 1.2,
    seed: Math.floor(Math.random() * 1000000000),
    groupIds: [],
    frameId: null,
    roundness: null,
    boundElements: null,
    updated: Date.now(),
    link: null,
    locked: false,
    fontSize,
    fontFamily: 1,
    text,
    textAlign: 'left',
    verticalAlign: 'top',
    containerId: null,
    originalText: text,
    lineHeight: 1.25,
    baseline: fontSize,
  };
}

function createArrow(
  startX: number,
  startY: number,
  endX: number,
  endY: number,
  color: string = COLORS.cyan
): ExcalidrawElement {
  return {
    type: 'arrow',
    version: 1,
    versionNonce: Math.floor(Math.random() * 1000000000),
    isDeleted: false,
    id: generateId(),
    fillStyle: 'solid',
    strokeWidth: 2,
    strokeStyle: 'solid',
    roughness: 1,
    opacity: 100,
    angle: 0,
    x: startX,
    y: startY,
    strokeColor: color,
    backgroundColor: 'transparent',
    width: endX - startX,
    height: endY - startY,
    seed: Math.floor(Math.random() * 1000000000),
    groupIds: [],
    frameId: null,
    roundness: { type: 2 },
    boundElements: null,
    updated: Date.now(),
    link: null,
    locked: false,
    startBinding: null,
    endBinding: null,
    lastCommittedPoint: null,
    startArrowhead: null,
    endArrowhead: 'arrow',
    points: [
      [0, 0],
      [endX - startX, endY - startY],
    ],
  };
}

// Create delegation infographic
function createDelegationInfographic(): any {
  const elements: ExcalidrawElement[] = [];

  // Title
  elements.push(createText(50, 50, 'The Delegation Moment', 32, COLORS.white));
  elements.push(createText(50, 90, 'From overwhelm to flow in three steps', 16, COLORS.lineWork));

  // Step 1: The Struggle
  const step1X = 100;
  const step1Y = 200;
  elements.push(createRectangle(step1X, step1Y, 200, 180, COLORS.white, COLORS.surface));
  elements.push(createText(step1X + 50, step1Y + 20, 'Manual Mode', 18, COLORS.white));
  elements.push(createText(step1X + 20, step1Y + 60, '🤯', 40, COLORS.white));
  elements.push(createText(step1X + 20, step1Y + 120, 'Hours of work', 14, COLORS.lineWork));
  elements.push(createText(step1X + 20, step1Y + 145, 'ahead...', 14, COLORS.lineWork));

  // Arrow 1
  elements.push(createArrow(step1X + 200, step1Y + 90, step1X + 320, step1Y + 90, COLORS.cyan));
  elements.push(createText(step1X + 230, step1Y + 60, 'Realization', 14, COLORS.cyan));

  // Step 2: The Shift
  const step2X = 420;
  const step2Y = 200;
  elements.push(createRectangle(step2X, step2Y, 200, 180, COLORS.white, COLORS.surface));
  elements.push(createText(step2X + 30, step2Y + 20, 'Remember AI', 18, COLORS.white));
  elements.push(createText(step2X + 20, step2Y + 60, '💡', 40, COLORS.white));
  elements.push(createText(step2X + 20, step2Y + 120, '"Wait... I have', 14, COLORS.paiBlue));
  elements.push(createText(step2X + 20, step2Y + 145, 'Data!"', 14, COLORS.paiBlue));

  // Arrow 2
  elements.push(createArrow(step2X + 200, step2Y + 90, step2X + 320, step2Y + 90, COLORS.cyan));
  elements.push(createText(step2X + 240, step2Y + 60, 'Delegate', 14, COLORS.cyan));

  // Step 3: The Outcome
  const step3X = 740;
  const step3Y = 200;
  elements.push(createRectangle(step3X, step3Y, 200, 180, COLORS.white, COLORS.surface));
  elements.push(createText(step3X + 20, step3Y + 20, 'Automated Mode', 18, COLORS.white));
  elements.push(createText(step3X + 20, step3Y + 60, '✨', 40, COLORS.white));
  elements.push(createText(step3X + 20, step3Y + 120, 'Minutes,', 14, COLORS.lineWork));
  elements.push(createText(step3X + 20, step3Y + 145, 'done well', 14, COLORS.lineWork));

  // Insights
  elements.push(createText(700, 450, '*Stop doing what can be delegated*', 16, COLORS.paiBlue));
  elements.push(createText(300, 450, '*Your AI never gets tired*', 16, COLORS.paiBlue));
  elements.push(createText(100, 450, '*Focus on what matters*', 16, COLORS.paiBlue));

  return {
    type: 'excalidraw',
    version: 2,
    source: 'https://excalidraw.com',
    elements,
    appState: {
      gridSize: null,
      viewBackgroundColor: COLORS.background,
    },
    files: {},
  };
}

// CLI
const args = process.argv.slice(2);
const output = args[0] || resolve(process.env.HOME!, 'Downloads', 'delegation.excalidraw');

const diagram = createDelegationInfographic();
writeFileSync(output, JSON.stringify(diagram, null, 2));

console.log(`✅ Excalidraw file created: ${output}`);
console.log(`📂 Open it at https://excalidraw.com`);
