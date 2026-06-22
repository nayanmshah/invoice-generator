# JSON File Writing Must Be Atomic

- You MUST use `safeWriteJson(filePath: string, data: any): Promise<void>` from `src/utils/safeWriteJson.ts` instead of `JSON.stringify` with file-write operations
- For **plain text** (YAML, markdown, etc.) use `safeWriteText(filePath, content)` from `src/utils/safeWriteText.ts` — same inter-process locking and atomic write pattern as `safeWriteJson`
- `safeWriteJson` will create parent directories if necessary, so do not call `mkdir` prior to `safeWriteJson`
- `safeWriteJson` prevents data corruption via atomic writes with locking and streams the write to minimize memory footprint
- Test files are exempt from this rule
- New helpers must have unit tests; run coverage with `pnpm exec vitest run --coverage` in `src/` for touched files
