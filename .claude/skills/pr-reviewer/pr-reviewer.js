#!/usr/bin/env node

/**
 * PR Reviewer - Claude Code Skill Integration
 * Orchestrates multi-PR reviews with Claude AI analysis
 */

const { spawn } = require('child_process');
const fs = require('fs');
const path = require('path');

// Configuration
const SKILL_DIR = __dirname;
const CONFIG_PATH = path.join(SKILL_DIR, '..', 'pr-reviewer.json');
const SCRIPT_PATH = path.join(SKILL_DIR, 'pr-reviewer.sh');

/**
 * Load configuration
 */
function loadConfig() {
    try {
        if (fs.existsSync(CONFIG_PATH)) {
            return JSON.parse(fs.readFileSync(CONFIG_PATH, 'utf8'));
        }
    } catch (err) {
        console.error('Failed to load config:', err.message);
    }
    return null;
}

/**
 * Execute the bash script to fetch PR data
 */
function executeFetchScript(args) {
    return new Promise((resolve, reject) => {
        const proc = spawn(SCRIPT_PATH, args, {
            stdio: ['inherit', 'pipe', 'pipe']
        });

        let stdout = '';
        let stderr = '';

        proc.stdout.on('data', (data) => {
            stdout += data.toString();
        });

        proc.stderr.on('data', (data) => {
            stderr += data.toString();
            // Also output to console for user visibility
            process.stderr.write(data);
        });

        proc.on('close', (code) => {
            if (code === 0) {
                resolve(stdout);
            } else {
                reject(new Error(`Script failed with code ${code}: ${stderr}`));
            }
        });
    });
}

/**
 * Parse command line arguments
 */
function parseArgs(argv) {
    const args = {
        prUrls: [],
        focus: null,
        context: null,
        output: 'markdown'
    };

    for (let i = 2; i < argv.length; i++) {
        const arg = argv[i];

        if (arg === '--focus' && i + 1 < argv.length) {
            args.focus = argv[++i];
        } else if (arg === '--context' && i + 1 < argv.length) {
            args.context = argv[++i];
        } else if (arg === '--output' && i + 1 < argv.length) {
            args.output = argv[++i];
        } else if (arg.startsWith('http')) {
            args.prUrls.push(arg);
        }
    }

    return args;
}

/**
 * Validate arguments
 */
function validateArgs(args, config) {
    if (args.prUrls.length === 0) {
        throw new Error('No PR URLs provided');
    }

    const maxPRs = config?.maxPRs || 10;
    if (args.prUrls.length > maxPRs) {
        throw new Error(`Maximum ${maxPRs} PRs allowed, got ${args.prUrls.length}`);
    }

    const validFormats = ['markdown', 'json', 'summary'];
    if (!validFormats.includes(args.output)) {
        throw new Error(`Invalid output format: ${args.output}. Must be one of: ${validFormats.join(', ')}`);
    }

    return true;
}

/**
 * Main execution
 */
async function main() {
    try {
        const config = loadConfig();
        const args = parseArgs(process.argv);

        // Validate arguments
        validateArgs(args, config);

        // Build script arguments
        const scriptArgs = [];

        if (args.focus) {
            scriptArgs.push('--focus', args.focus);
        }

        if (args.context) {
            scriptArgs.push('--context', args.context);
        }

        scriptArgs.push('--output', args.output);
        scriptArgs.push(...args.prUrls);

        // Execute the fetch script
        console.error('[INFO] Fetching PR data...');
        const promptOutput = await executeFetchScript(scriptArgs);

        // Output the prompt for Claude to process
        console.log(promptOutput);

        console.error('\n[SUCCESS] PR data fetched successfully');
        console.error('[INFO] Claude will now analyze the PRs...');

    } catch (err) {
        console.error('[ERROR]', err.message);
        process.exit(1);
    }
}

// Run if called directly
if (require.main === module) {
    main();
}

module.exports = { loadConfig, parseArgs, validateArgs };
