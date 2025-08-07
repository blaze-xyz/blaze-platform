#!/usr/bin/env node

/**
 * n8n Workflow Deployment Script
 *
 * This script deploys workflows to your n8n instance via the REST API.
 *
 * Usage:
 *   node deploy-workflow.js                    # Deploy the bug investigation workflow
 *   node deploy-workflow.js list               # List existing workflows
 *   node deploy-workflow.js deploy <file>      # Deploy a specific workflow file
 *
 * Environment Variables:
 *   N8N_API_KEY   - Your n8n API key (required)
 *   N8N_API_URL   - Your n8n instance URL (default: https://n8n.blaze.money)
 */

const fs = require("fs");
const path = require("path");

// Configuration
const N8N_API_URL = process.env.N8N_API_URL || "https://n8n.blaze.money";
const N8N_API_KEY = process.env.N8N_API_KEY;

if (!N8N_API_KEY) {
  console.error("❌ Error: N8N_API_KEY environment variable is required");
  console.error("   Get your API key from: " + N8N_API_URL + "/settings/api");
  console.error('   Then run: export N8N_API_KEY="your-key-here"');
  process.exit(1);
}

// Default workflow (bug investigation)
const DEFAULT_WORKFLOW_PATH =
  "../docs/agentic-workflows/n8n-workflows/bug-investigation-template.json";

/**
 * Load workflow from JSON file
 */
function loadWorkflow(filePath) {
  try {
    const fullPath = path.resolve(__dirname, filePath);
    const workflowData = JSON.parse(fs.readFileSync(fullPath, "utf8"));
    return workflowData;
  } catch (error) {
    console.error(`❌ Error loading workflow from ${filePath}:`, error.message);
    throw error;
  }
}

/**
 * Deploy a workflow to n8n
 */
async function deployWorkflow(workflowData) {
  try {
    console.log(`🚀 Deploying workflow "${workflowData.name}" to n8n...`);

    const response = await fetch(`${N8N_API_URL}/api/v1/workflows`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-N8N-API-KEY": N8N_API_KEY,
      },
      body: JSON.stringify(workflowData),
    });

    if (!response.ok) {
      const errorText = await response.text();
      throw new Error(
        `HTTP error! status: ${response.status}, message: ${errorText}`
      );
    }

    const result = await response.json();
    console.log("✅ Workflow deployed successfully!");
    console.log("   Workflow ID:", result.id);
    console.log("   Workflow Name:", result.name);
    console.log("   Workflow URL:", `${N8N_API_URL}/workflow/${result.id}`);

    return result;
  } catch (error) {
    console.error("❌ Error deploying workflow:", error.message);
    throw error;
  }
}

/**
 * List all workflows in n8n
 */
async function listWorkflows() {
  try {
    console.log("📋 Fetching workflows from n8n...");

    const response = await fetch(`${N8N_API_URL}/api/v1/workflows`, {
      headers: {
        "X-N8N-API-KEY": N8N_API_KEY,
      },
    });

    if (!response.ok) {
      const errorText = await response.text();
      throw new Error(
        `HTTP error! status: ${response.status}, message: ${errorText}`
      );
    }

    const workflows = await response.json();

    if (workflows.data && workflows.data.length > 0) {
      console.log("\n📋 Existing workflows:");
      workflows.data.forEach((workflow) => {
        console.log(`   • ${workflow.name}`);
        console.log(`     ID: ${workflow.id}`);
        console.log(`     Active: ${workflow.active ? "✅" : "❌"}`);
        console.log(`     URL: ${N8N_API_URL}/workflow/${workflow.id}`);
        console.log("");
      });
    } else {
      console.log("📭 No workflows found in your n8n instance");
    }

    return workflows;
  } catch (error) {
    console.error("❌ Error listing workflows:", error.message);
    throw error;
  }
}

/**
 * Activate/deactivate a workflow
 */
async function toggleWorkflow(workflowId, activate = true) {
  try {
    const action = activate ? "activate" : "deactivate";
    console.log(`🔄 ${action}ing workflow ${workflowId}...`);

    const response = await fetch(
      `${N8N_API_URL}/api/v1/workflows/${workflowId}/${action}`,
      {
        method: "POST",
        headers: {
          "X-N8N-API-KEY": N8N_API_KEY,
        },
      }
    );

    if (!response.ok) {
      const errorText = await response.text();
      throw new Error(
        `HTTP error! status: ${response.status}, message: ${errorText}`
      );
    }

    console.log(`✅ Workflow ${workflowId} ${action}d successfully!`);
    return true;
  } catch (error) {
    console.error(
      `❌ Error ${activate ? "activating" : "deactivating"} workflow:`,
      error.message
    );
    throw error;
  }
}

/**
 * Show usage information
 */
function showUsage() {
  console.log(`
Usage: node deploy-workflow.js [command] [options]

Commands:
  deploy [file]    Deploy a workflow (default: bug investigation template)
  list             List all existing workflows
  activate <id>    Activate a workflow by ID
  deactivate <id>  Deactivate a workflow by ID
  help             Show this help message

Examples:
  node deploy-workflow.js
  node deploy-workflow.js deploy ../docs/agentic-workflows/n8n-workflows/my-workflow.json
  node deploy-workflow.js list
  node deploy-workflow.js activate 123
  
Environment Variables:
  N8N_API_KEY      Your n8n API key (required)
  N8N_API_URL      Your n8n instance URL (default: https://n8n.blaze.money)
`);
}

/**
 * Main execution
 */
async function main() {
  const command = process.argv[2] || "deploy";
  const arg = process.argv[3];

  try {
    switch (command) {
      case "deploy":
        const workflowPath = arg || DEFAULT_WORKFLOW_PATH;
        const workflowData = loadWorkflow(workflowPath);
        await deployWorkflow(workflowData);
        break;

      case "list":
        await listWorkflows();
        break;

      case "activate":
        if (!arg) {
          console.error("❌ Error: Workflow ID required for activate command");
          process.exit(1);
        }
        await toggleWorkflow(arg, true);
        break;

      case "deactivate":
        if (!arg) {
          console.error(
            "❌ Error: Workflow ID required for deactivate command"
          );
          process.exit(1);
        }
        await toggleWorkflow(arg, false);
        break;

      case "help":
      case "--help":
      case "-h":
        showUsage();
        break;

      default:
        console.error(`❌ Unknown command: ${command}`);
        showUsage();
        process.exit(1);
    }
  } catch (error) {
    console.error("💥 Script failed:", error.message);
    process.exit(1);
  }
}

// Run if called directly
if (require.main === module) {
  main();
}

module.exports = {
  deployWorkflow,
  listWorkflows,
  toggleWorkflow,
  loadWorkflow,
};
