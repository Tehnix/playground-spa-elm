/**
 * The index pre-processor is used to insert environmental variables into the index,
 * so it's ready to use for the Elm application.
 *
 * All variables are read from
 */
const fs = require("fs");

const { STAGE } = process.env;

// We always use .env.development, unless the stage is production or staging.
let dotenvPath = "./.env.development";
if (STAGE === "production" || STAGE === "staging") {
  dotenvPath = "./.env";
}
require("dotenv").config({ path: dotenvPath });

/**
 * These are your replacements that are set up in index.unprocessed.html, and will
 * get their values from here. Note that currently it's assumed that all these will
 * be valid when thrown into quotes, e.g. "development" is generated from the value
 * development.
 */
const REPLACEMENTS = [
  { target: "process.env.API_URL", value: process.env.API_URL },
  { target: "process.env.STAGE", value: process.env.STAGE },
  { target: "process.env.I18N_PROJECT", value: process.env.I18N_PROJECT },
  { target: "process.env.I18N_URL", value: process.env.I18N_URL },
  { target: "process.env.AUTH_URL", value: process.env.AUTH_URL },
  { target: "process.env.AUTH_CLIENT_ID", value: process.env.AUTH_CLIENT_ID },
  { target: "ASSETS_PATH", value: process.env.ASSETS_PATH, raw: true }
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
    if (replacement.raw && replacement.raw === true) {
      processedIndex = processedIndex.replace(re, `${replacement.value}`);
    } else {
      processedIndex = processedIndex.replace(re, `"${replacement.value}"`);
    }
  });
  return processedIndex;
};

/**
 * Write the index file to disk at `dist/index.html`.
 */
const writeIndex = index => {
  fs.writeFileSync("./dist/index.html", index);
};

/**
 * Validate the we have no more process.env's left in our
 * processed index file.
 */
const validateIndex = index => {
  const lines = index.split("\n");
  const invalidLines = [];
  // Gather all invalid lines.
  lines.map((line, i) => {
    if (line.indexOf("process.env") !== -1) {
      invalidLines.push({ line, lineNo: i });
    }
  });

  // Neatly report to the user which lines were invalid, with their line number
  // and contents.
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
