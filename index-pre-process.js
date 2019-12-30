/**
 * The index pre-processor is used to insert environmental variables into the index,
 * so it's ready to use for the Elm application.
 *
 * All variables are read from
 */
const { STAGE } = process.env;
let dotenvPath = "./.env.development";
if (STAGE === "production" || STAGE === "staging") {
  dotenvPath = "./.env";
}
require("dotenv").config({ path: dotenvPath });
const fs = require("fs");

const REPLACEMENTS = [
  { target: "process.env.API_URL", value: process.env.API_URL },
  { target: "process.env.STAGE", value: process.env.STAGE }
];

/**
 * Process the unprocessed index file, at `index.unprocessed.html`, by
 * replacing all process.env.? with an actual value.
 */
const processIndex = () => {
  // Get the unprocessed HTML.
  const unprocessedIndex = fs
    .readFileSync("./index.unprocessed.html")
    .toString();

  // Replace our process.env with actual values.
  let processedIndex = unprocessedIndex;
  REPLACEMENTS.map(replacement => {
    const re = new RegExp(replacement.target, "g");
    processedIndex = processedIndex.replace(re, `"${replacement.value}"`);
  });
  return processedIndex;
};

/**
 * Write the index file to disk at `index.html`.
 */
const writeIndex = index => {
  fs.writeFileSync("./index.html", index);
};

/**
 * Validate the we have no more process.env's left in our
 * processed index file.
 */
const validateIndex = index => {
  const lines = index.split("\n");
  const invalidLines = [];
  lines.map((line, i) => {
    if (line.indexOf("process.env") !== -1) {
      invalidLines.push({ line, lineNo: i });
    }
  });
  if (invalidLines.length !== 0) {
    console.error("");
    console.error("✋ There are still unprocessed `process.env`s left!");
    console.error("");
    console.error("I found the following:");
    invalidLines.map(({ line, lineNo }) => {
      const paddedLinNo = `    ${lineNo}`.slice(-4);
      console.log(`  ${paddedLinNo} | ${line}`);
    });
    console.error("");
    console.error(
      "💁‍♀️ Remember to add handling for these in `index-pre-process.js`."
    );
    console.error("");
    process.exit(1);
  }
};

const index = processIndex();
validateIndex(index);
writeIndex(index);
