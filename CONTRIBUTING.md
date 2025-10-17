# Contributing

Contributions are welcome! This document provides guidelines for contributing to the Aseprite Pixel Art Plugin.

## Reporting Issues

Use the GitHub issue tracker to report bugs or suggest features:
- **Bugs**: Include plugin version, Aseprite version, OS, steps to reproduce
- **Features**: Describe the use case and proposed solution

## Submitting Changes

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/your-feature`)
3. Make your changes
4. Run tests: `./bin/test-plugin.sh`
5. Commit with conventional commit format: `feat(scope): description`
6. Push and create a pull request

## Development Setup

### Prerequisites
- Aseprite v1.3.0+
- Go 1.23+ (for building pixel-mcp binaries)
- Bash (for test scripts)
- Python 3 (for JSON validation)

### Local Development
```bash
# Clone repositories
git clone https://github.com/willibrandon/pixel-plugin-plugin.git
git clone https://github.com/willibrandon/pixel-mcp.git

# Build pixel-mcp
cd pixel-mcp
make release
cp bin/* ../pixel-plugin-plugin/bin/

# Test plugin
cd ../pixel-plugin-plugin
./bin/test-plugin.sh
```

## Project Structure

```
pixel-plugin-plugin/
├── .claude-plugin/       # Plugin metadata
├── skills/               # Model-invoked Skills
├── commands/             # User-invoked slash commands
├── bin/                  # MCP server binaries and test scripts
├── config/               # Configuration templates
└── docs/                 # Documentation
```

## Coding Guidelines

### Skills (Markdown + YAML)
- Must have SKILL.md with valid YAML frontmatter
- Include: name, description, allowed-tools
- Provide clear instructions and examples

### Commands (Markdown + YAML)
- Must have valid YAML frontmatter
- Include: description, argument-hint, allowed-tools
- Document usage and examples

### Commit Format
Follow [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>(<scope>): <subject>

<optional body>
```

**Types**: feat, fix, docs, test, chore, refactor
**Scopes**: skills, commands, mcp, config, docs, testing

## Testing

Run the full test suite before submitting:
```bash
./bin/test-plugin.sh
```

Individual test suites:
- `./bin/validate-skills.sh` - Skills validation
- `./bin/validate-commands.sh` - Commands validation
- `./bin/test-mcp.sh` - MCP integration test

## Questions?

Check existing [issues](https://github.com/willibrandon/pixel-plugin-plugin/issues) or open a new one.

Thank you for contributing!
