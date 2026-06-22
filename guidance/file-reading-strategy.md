# File Reading Strategy for Large Documents

The IDE enforces line limits on file reads. To work effectively with large files (architecture.md, development-plan.md, refined-prd.md), use **search-first** and **targeted reading** instead of full-file reads.

## When to Use This Strategy

- Files exceed ~250–2000 lines (platform-dependent)
- You need specific sections (e.g., Sprint 1 tasks, folder structure, API endpoints)
- Full read would truncate or miss relevant content

## Approach

### 1. Search First

Before reading a large file, use semantic search or grep to locate relevant content:

- **Semantic search:** "Where is Sprint 1 defined in development-plan?" or "What is the folder structure in architecture?"
- **Grep:** Search for section headers, keywords, or identifiers (e.g., `## Sprint 1`, `2.3. Folder Structure`, `GET /api/`)

### 2. Targeted Reads

Once you know where content lives, read only the needed range using `offset` and `limit`:

- Read a specific section by line range (e.g., lines 100–250 for Sprint 1)
- Read multiple targeted chunks instead of one full-file read
- For small files (<250 lines), full read is fine

### 3. Iterate as Needed

- If the first read doesn't contain what you need, search again with refined terms
- For architecture.md: tech stack, modules, folder structure, API design
- For development-plan.md: sprint tasks, acceptance criteria, folder structure, prototype paths
- For refined-prd.md: use cases, entities, domain glossary, non-functional expectations

## Example Workflow

1. **Task:** Implement Sprint 1 from development-plan.md (file is 500 lines)
2. **Search:** `Grep` for "Sprint 1" or "## 3. Sprint 1" → find line range
3. **Read:** Use `offset` and `limit` to read only that section
4. **Supplement:** If folder structure is needed, search for "2.3. Folder Structure" and read that range

## Files This Applies To

| File                | Key Sections to Search For                                            |
| ------------------- | --------------------------------------------------------------------- |
| architecture.md     | Technology Stack, Module Identification, Folder Structure, API design |
| development-plan.md | Sprint N, Folder Structure, Acceptance Criteria, prototype paths      |
| refined-prd.md      | Use Cases, Entities, Domain Glossary, Non-Functional Expectations     |
