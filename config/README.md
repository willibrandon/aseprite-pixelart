# Configuration Guide

## Aseprite MCP Server Configuration

The aseprite-mcp server requires Aseprite to be installed and configured.

### Configuration Location

By default, aseprite-mcp looks for configuration at:
- **macOS/Linux**: `~/.config/aseprite-mcp/config.json`
- **Windows**: `%APPDATA%\aseprite-mcp\config.json`

### Configuration Format

The plugin includes a template at `config/aseprite-mcp-config.json`:

```json
{
  "aseprite_path": "/path/to/aseprite",
  "temp_dir": "/tmp/aseprite-mcp",
  "timeout": 30,
  "log_level": "info",
  "log_file": "",
  "enable_timing": false
}
```

### Required Configuration

The only required field is `aseprite_path`. All other fields have sensible defaults.

### Setup Methods

#### Option 1: Use /pixel-setup Command (Recommended)

The `/pixel-setup` command will guide you through configuration:

```
> /pixel-setup
```

This will:
1. Detect Aseprite installation automatically (if in common path)
2. Prompt for manual path if not found
3. Validate the path
4. Create configuration file
5. Test MCP server connectivity

#### Option 2: Manual Configuration

1. Create the config directory:
```bash
mkdir -p ~/.config/aseprite-mcp
```

2. Copy the template:
```bash
cp config/aseprite-mcp-config.json ~/.config/aseprite-mcp/config.json
```

3. Edit the config file and set `aseprite_path`:
```bash
# macOS example
"aseprite_path": "/Applications/Aseprite.app/Contents/MacOS/aseprite"

# Linux example
"aseprite_path": "/usr/bin/aseprite"

# Windows example
"aseprite_path": "C:\\Program Files\\Aseprite\\Aseprite.exe"
```

### Verifying Configuration

Test that aseprite-mcp can find Aseprite:

```bash
${CLAUDE_PLUGIN_ROOT}/bin/aseprite-mcp --health
```

Should output:
```
✓ Aseprite found at: /path/to/aseprite
✓ Configuration loaded
✓ MCP server ready
```

### Troubleshooting

**Error: "Aseprite not found"**
- Verify Aseprite is installed: https://www.aseprite.org/
- Check the path in your config file
- Ensure the path points to the executable, not the .app directory (on macOS)

**Error: "Permission denied"**
- Ensure aseprite-mcp binary is executable: `chmod +x bin/aseprite-mcp`
- Ensure Aseprite binary is executable

**Error: "Timeout"**
- Increase `timeout` value in config (default: 30 seconds)
- Check if Aseprite launches successfully manually

### Platform-Specific Paths

**macOS:**
```
/Applications/Aseprite.app/Contents/MacOS/aseprite
```

**Linux:**
```
/usr/bin/aseprite
/usr/local/bin/aseprite
~/.local/bin/aseprite
```

**Windows:**
```
C:\Program Files\Aseprite\Aseprite.exe
C:\Program Files (x86)\Aseprite\Aseprite.exe
```

### Advanced Configuration

**Enable Logging:**
```json
{
  "log_level": "debug",
  "log_file": "/tmp/aseprite-mcp.log"
}
```

**Enable Timing:**
```json
{
  "enable_timing": true
}
```

This will log operation timings for performance analysis.

**Custom Temp Directory:**
```json
{
  "temp_dir": "/custom/path/to/temp"
}
```

Ensure the directory exists and is writable.
