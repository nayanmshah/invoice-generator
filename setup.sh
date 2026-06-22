#!/usr/bin/env bash
set -euo pipefail

# Nayan SDLC — Claude Code Plugin Setup
# ========================================
# This script sets up the Nayan SDLC plugin for Claude Code.
# It supports two installation methods:
#   1. Plugin mode (recommended) — loads via --plugin-dir flag
#   2. Standalone mode — copies into .claude/ directory of a target project
#
# Usage:
#   ./setup.sh                    # Show help
#   ./setup.sh plugin             # Configure as Claude Code plugin (recommended)
#   ./setup.sh standalone [path]  # Copy to target project's .claude/ directory
#   ./setup.sh verify             # Verify installation

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGIN_NAME="nayan"

print_header() {
    echo ""
    echo "╔══════════════════════════════════════════════════════╗"
    echo "║        Nayan SDLC — Claude Code Plugin Setup       ║"
    echo "╚══════════════════════════════════════════════════════╝"
    echo ""
}

print_usage() {
    print_header
    echo "Usage: $0 <command> [options]"
    echo ""
    echo "Commands:"
    echo "  plugin              Configure as a Claude Code plugin (recommended)"
    echo "                      Prints the CLI flag to use when starting Claude Code."
    echo ""
    echo "  standalone [path]   Copy Nayan SDLC content into a project's .claude/ directory."
    echo "                      If [path] is omitted, uses the current working directory."
    echo ""
    echo "  verify              Verify the plugin installation by checking structure."
    echo ""
    echo "Examples:"
    echo "  $0 plugin"
    echo "  $0 standalone /path/to/my-project"
    echo "  $0 standalone"
    echo "  $0 verify"
    echo ""
    echo "After setup, start Claude Code with:"
    echo "  claude --plugin-dir \"$SCRIPT_DIR\""
    echo ""
    echo "Or in VS Code, add to settings.json:"
    echo "  \"claude-code.pluginDirs\": [\"$SCRIPT_DIR\"]"
    echo ""
}

cmd_plugin() {
    print_header
    echo "Plugin directory: $SCRIPT_DIR"
    echo ""

    # Verify plugin structure
    if [ ! -f "$SCRIPT_DIR/.claude-plugin/plugin.json" ]; then
        echo "ERROR: plugin.json not found at $SCRIPT_DIR/.claude-plugin/plugin.json"
        exit 1
    fi

    echo "Plugin structure verified."
    echo ""
    echo "To use Nayan SDLC with Claude Code, start with:"
    echo ""
    echo "  claude --plugin-dir \"$SCRIPT_DIR\""
    echo ""
    echo "Or add to your VS Code settings.json:"
    echo ""
    echo "  \"claude-code.pluginDirs\": [\"$SCRIPT_DIR\"]"
    echo ""
    echo "Once running, available commands (prefixed with nayan:):"
    echo "  /nayan:greenfield          — Start greenfield product development"
    echo "  /nayan:brownfield          — Start brownfield project"
    echo "  /nayan:commit              — Commit and push with descriptive message"
    echo "  /nayan:init                — Analyze codebase, create AGENTS.md"
    echo "  /nayan:release             — Create a new release"
    echo "  /nayan:nayan-translate    — Translate and localize strings"
    echo "  /nayan:nayan-resolve-conflicts — Resolve merge conflicts"
    echo "  /nayan:setup-sonarqube     — Set up SonarQube locally"
    echo "  /nayan:setup-qdrant        — Set up Qdrant locally"
    echo ""
    echo "Available agents (use with @agent-name or --agent):"
    echo "  orchestrator, ask, brainstorm, prd, architect, plan,"
    echo "  prototype, code, debug, qa, secure, deploy"
    echo ""
    echo "Default agent: orchestrator (set in settings.json)"
    echo ""
}

cmd_standalone() {
    local TARGET_DIR="${1:-.}"
    TARGET_DIR="$(cd "$TARGET_DIR" && pwd)"
    local CLAUDE_DIR="$TARGET_DIR/.claude"

    print_header
    echo "Target project: $TARGET_DIR"
    echo "Installing to: $CLAUDE_DIR"
    echo ""

    # Create .claude directory structure
    mkdir -p "$CLAUDE_DIR/commands"
    mkdir -p "$CLAUDE_DIR/skills"
    mkdir -p "$CLAUDE_DIR/agents"

    # Copy commands
    echo "Copying commands..."
    cp -r "$SCRIPT_DIR/commands/"* "$CLAUDE_DIR/commands/" 2>/dev/null || true

    # Copy skills
    echo "Copying skills..."
    cp -r "$SCRIPT_DIR/skills/"* "$CLAUDE_DIR/skills/" 2>/dev/null || true

    # Copy agents
    echo "Copying agents..."
    cp -r "$SCRIPT_DIR/agents/"* "$CLAUDE_DIR/agents/" 2>/dev/null || true

    # Copy guidance (as reference directory)
    echo "Copying guidance..."
    cp -r "$SCRIPT_DIR/guidance" "$CLAUDE_DIR/" 2>/dev/null || true

    # Copy rules and rules-* directories
    echo "Copying rules..."
    cp -r "$SCRIPT_DIR/rules" "$CLAUDE_DIR/" 2>/dev/null || true
    for rules_dir in "$SCRIPT_DIR"/rules-*/; do
        if [ -d "$rules_dir" ]; then
            cp -r "$rules_dir" "$CLAUDE_DIR/" 2>/dev/null || true
        fi
    done

    # Copy settings.json
    if [ -f "$SCRIPT_DIR/settings.json" ]; then
        echo "Copying settings.json..."
        cp "$SCRIPT_DIR/settings.json" "$CLAUDE_DIR/settings.json"
    fi

    # Copy or create CLAUDE.md at project root
    if [ -f "$TARGET_DIR/CLAUDE.md" ]; then
        echo ""
        echo "WARNING: $TARGET_DIR/CLAUDE.md already exists."
        echo "Nayan CLAUDE.md saved to $CLAUDE_DIR/CLAUDE.md instead."
        echo "Please merge manually if needed."
        cp "$SCRIPT_DIR/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md"
    else
        echo "Creating CLAUDE.md at project root..."
        cp "$SCRIPT_DIR/CLAUDE.md" "$TARGET_DIR/CLAUDE.md"
    fi

    echo ""
    echo "Installation complete!"
    echo ""
    echo "Available commands (no namespace prefix in standalone mode):"
    echo "  /greenfield, /brownfield, /commit, /init, /release,"
    echo "  /nayan-translate, /nayan-resolve-conflicts,"
    echo "  /setup-sonarqube, /setup-qdrant"
    echo ""
    echo "Available agents:"
    echo "  orchestrator, ask, brainstorm, prd, architect, plan,"
    echo "  prototype, code, debug, qa, secure, deploy"
    echo ""
}

cmd_verify() {
    print_header
    echo "Verifying Nayan SDLC plugin structure..."
    echo ""

    local errors=0

    # Check plugin manifest
    if [ -f "$SCRIPT_DIR/.claude-plugin/plugin.json" ]; then
        echo "  [OK] .claude-plugin/plugin.json"
    else
        echo "  [FAIL] .claude-plugin/plugin.json missing"
        errors=$((errors + 1))
    fi

    # Check CLAUDE.md
    if [ -f "$SCRIPT_DIR/CLAUDE.md" ]; then
        echo "  [OK] CLAUDE.md"
    else
        echo "  [FAIL] CLAUDE.md missing"
        errors=$((errors + 1))
    fi

    # Check commands
    local cmd_count
    cmd_count=$(ls -1 "$SCRIPT_DIR/commands/"*.md 2>/dev/null | wc -l | tr -d ' ')
    echo "  [OK] commands/ ($cmd_count commands)"

    # Check skills
    local skill_count
    skill_count=$(find "$SCRIPT_DIR/skills" -name "SKILL.md" 2>/dev/null | wc -l | tr -d ' ')
    echo "  [OK] skills/ ($skill_count skills)"

    # Check agents
    local agent_count
    agent_count=$(ls -1 "$SCRIPT_DIR/agents/"*.md 2>/dev/null | wc -l | tr -d ' ')
    echo "  [OK] agents/ ($agent_count agents)"

    # Check guidance
    local guidance_count
    guidance_count=$(ls -1 "$SCRIPT_DIR/guidance/"*.md 2>/dev/null | wc -l | tr -d ' ')
    echo "  [OK] guidance/ ($guidance_count documents)"

    # Check rules
    local rules_dir_count
    rules_dir_count=$(ls -d "$SCRIPT_DIR"/rules-*/ 2>/dev/null | wc -l | tr -d ' ')
    echo "  [OK] rules-*/ ($rules_dir_count rule directories)"

    # Check settings
    if [ -f "$SCRIPT_DIR/settings.json" ]; then
        echo "  [OK] settings.json"
    else
        echo "  [WARN] settings.json missing (optional)"
    fi

    echo ""
    if [ $errors -eq 0 ]; then
        echo "All checks passed! Plugin is ready to use."
        echo ""
        echo "Start Claude Code with:"
        echo "  claude --plugin-dir \"$SCRIPT_DIR\""
    else
        echo "$errors error(s) found. Please fix before using."
    fi
    echo ""
}

# Main
case "${1:-}" in
    plugin)
        cmd_plugin
        ;;
    standalone)
        cmd_standalone "${2:-}"
        ;;
    verify)
        cmd_verify
        ;;
    *)
        print_usage
        ;;
esac
