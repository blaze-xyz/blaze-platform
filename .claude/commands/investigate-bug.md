 # Investigate Bug Slash Command

  You are helping investigate a reported bug. Follow this systematic approach:

  ## Step 1: Information Gathering Strategy
  First, spend time analyzing the bug description and determine what information would be most helpful to understand the root cause. Consider:

  - What components/systems are likely involved?
  - What logs or data sources would contain relevant evidence?
  - What timeframes should be examined?
  - What user actions or system states preceded the issue?
  - Are there related systems or dependencies that could be factors?

  ## Step 2: Evidence Collection & Hypothesis Formation
  Based on your analysis, systematically examine relevant sources to gather evidence:

  **Repository Investigation:**
  - Search relevant codebases for related functionality
  - Look for recent changes that could be related
  - Examine error handling, configuration, and integration points
  - Check for known issues or TODOs in related areas

  **Log Analysis (via BetterStack MCP):**
  - Query logs around the time the bug occurred
  - Search for error patterns, unusual activity, or system anomalies
  - Look for correlation with deployments, system changes, or traffic patterns
  - Examine both application logs and infrastructure logs

  **Database Investigation (via MCP):**
  - Query relevant tables for data inconsistencies
  - Check for patterns in the affected data
  - Look for timing correlations with the reported issue
  - Examine data integrity and constraints

  After gathering evidence from these sources, form a hypothesis about the root cause of the bug.

  ## Step 3: Solution Development
  Based on your hypothesis, think through potential solutions:

  - What would be the most appropriate fix for the root cause?
  - Are there immediate workarounds that could mitigate the issue?
  - What testing would be needed to validate the fix?
  - Are there preventive measures to avoid similar issues?
  - What would be the rollout strategy for the solution?

  ## Step 4: Summary Report
  Provide a comprehensive report including:

  **Bug Analysis:**
  - Summary of the reported issue
  - Root cause hypothesis with supporting evidence
  - Timeline of events (if applicable)

  **Evidence Summary:**
  - Key findings from code repository
  - Relevant log entries and patterns
  - Database query results and insights

  **Proposed Solution:**
  - Recommended fix with implementation approach
  - Immediate mitigation strategies (if needed)
  - Testing and validation plan
  - Prevention recommendations

  **Next Steps:**
  - Priority level and urgency assessment
  - Implementation timeline estimate
  - Who should be involved in the resolution

  Be thorough in your investigation but also prioritize the most likely causes based on the evidence you find.
