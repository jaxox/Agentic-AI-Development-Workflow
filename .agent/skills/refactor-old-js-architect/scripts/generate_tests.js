#!/usr/bin/env node

const fs = require('fs');
const path = require('path');

const targetFile = process.argv[2];

if (!targetFile) {
    console.log("Usage: node generate_tests.js <target_js_file>");
    process.exit(1);
}

const basename = path.basename(targetFile, '.js');
const testFile = path.join(path.dirname(targetFile), `${basename}.test.js`);

if (fs.existsSync(testFile)) {
    console.log(`Test file already exists: ${testFile}`);
    process.exit(0);
}

const template = `
const ${basename} = require('./${basename}');

describe('${basename} module', () => {
    // Generated baseline test
    test('should exist', () => {
        expect(${basename}).toBeDefined();
    });

    // TODO: Add specific function tests here
    // test('example function', () => {
    //     expect(${basename}.example()).toBe(true);
    // });
});
`;

fs.writeFileSync(testFile, template);
console.log(`Generated test skeleton: ${testFile}`);
