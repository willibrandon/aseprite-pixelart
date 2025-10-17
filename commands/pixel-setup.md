---
description: Configure aseprite-mcp server and verify Aseprite installation
argument-hint: [aseprite-path]
allowed-tools: Read, Write, Bash
---

## /pixel-setup - Plugin Configuration

Configure the aseprite-mcp server and verify Aseprite installation.

### Usage

```
/pixel-setup [aseprite-path]
```

### Arguments

**aseprite-path** (optional): Path to Aseprite executable
- If not provided, attempts auto-detection
- If detection fails, prompts user for path

### What This Command Does

1. **Detects Aseprite installation**
   - Searches common installation paths for current platform
   - macOS: `/Applications/Aseprite.app/Contents/MacOS/aseprite`
   - Linux: `/usr/bin/aseprite`, `/usr/local/bin/aseprite`
   - Windows: `C:\Program Files\Aseprite\Aseprite.exe`

2. **Creates configuration file**
   - Generates `~/.config/aseprite-mcp/config.json` (macOS/Linux)
   - Generates `%APPDATA%\aseprite-mcp\config.json` (Windows)
   - Sets `aseprite_path` in configuration

3. **Validates configuration**
   - Tests that Aseprite executable exists and is executable
   - Verifies aseprite-mcp can communicate with Aseprite
   - Reports version information

4. **Tests MCP server**
   - Runs health check on aseprite-mcp server
   - Confirms tools are accessible
   - Reports success or errors

### Examples

```
/pixel-setup
→ Auto-detects Aseprite installation and configures

/pixel-setup /Applications/Aseprite.app/Contents/MacOS/aseprite
→ Uses specified path for macOS

/pixel-setup "C:\Program Files\Aseprite\Aseprite.exe"
→ Uses specified path for Windows

/pixel-setup /usr/local/bin/aseprite
→ Uses specified path for Linux
```

### Auto-Detection Paths

**macOS:**
- `/Applications/Aseprite.app/Contents/MacOS/aseprite`
- `$HOME/Applications/Aseprite.app/Contents/MacOS/aseprite`
- `/usr/local/bin/aseprite`
- `$HOME/.local/bin/aseprite`

**Linux:**
- `/usr/bin/aseprite`
- `/usr/local/bin/aseprite`
- `$HOME/.local/bin/aseprite`
- `$HOME/bin/aseprite`
- `/opt/aseprite/bin/aseprite`
- `/snap/bin/aseprite`

**Windows:**
- `C:\Program Files\Aseprite\Aseprite.exe`
- `C:\Program Files (x86)\Aseprite\Aseprite.exe`
- `%LOCALAPPDATA%\Aseprite\Aseprite.exe`
- `%USERPROFILE%\AppData\Local\Aseprite\Aseprite.exe`

### Configuration File Format

**Location:**
- macOS/Linux: `~/.config/aseprite-mcp/config.json`
- Windows: `%APPDATA%\aseprite-mcp\config.json`

**Contents:**
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

**Required Field:**
- `aseprite_path`: Path to Aseprite executable (only required field)

**Optional Fields:**
- `temp_dir`: Temporary directory for MCP operations (default: system temp)
- `timeout`: Command timeout in seconds (default: 30)
- `log_level`: Logging level: "debug", "info", "warn", "error" (default: "info")
- `log_file`: Path to log file (default: "" = no file logging)
- `enable_timing`: Log operation timings for performance analysis (default: false)

### Implementation

**Step 1: Auto-Detection**
1. Check if aseprite-path argument provided
2. If not, run detection script: `config/detect-aseprite.sh`
3. Detection script checks common paths for current OS
4. If found, use detected path; if not, prompt user for path

**Step 2: Validate Path**
1. Check if file exists at specified path
2. Check if file is executable
3. Optionally run `aseprite --version` to verify

**Step 3: Create Configuration**
1. Determine config directory based on OS
2. Create directory if it doesn't exist: `mkdir -p ~/.config/aseprite-mcp`
3. Write config.json with aseprite_path and defaults
4. Set appropriate permissions (readable/writable by user)

**Step 4: Test MCP Server**
1. Run health check: `${CLAUDE_PLUGIN_ROOT}/bin/aseprite-mcp --health`
2. Capture output and check for success
3. Report Aseprite version and MCP status

**Step 5: Report Results**
1. Display configuration summary
2. Show config file location
3. Show Aseprite path
4. Confirm MCP server is ready
5. Provide next steps or troubleshooting if failed

### Success Output

```
✓ Aseprite detected at: /Applications/Aseprite.app/Contents/MacOS/aseprite
✓ Configuration created: ~/.config/aseprite-mcp/config.json
✓ Aseprite version: v1.3.2
✓ MCP server ready

Plugin setup complete! You can now create pixel art with commands like:
  /pixel-new
  /pixel-palette set nes
```

### Error Handling

**Aseprite not found:**
```
✗ Aseprite not found in common installation paths

Please install Aseprite from: https://www.aseprite.org/
Or specify the path manually: /pixel-setup /path/to/aseprite
```

**Invalid path provided:**
```
✗ Aseprite not found at: /invalid/path

Please check the path and try again, or run /pixel-setup without arguments for auto-detection.
```

**Permission errors:**
```
✗ Cannot create configuration directory: ~/.config/aseprite-mcp
  Permission denied

Please check directory permissions or run with appropriate privileges.
```

**MCP server health check failed:**
```
✗ MCP server health check failed
  Error: [error details]

Please check that:
  1. Aseprite path is correct
  2. Aseprite is executable
  3. aseprite-mcp binary has execute permissions
```

### Troubleshooting Tips

Include in output if errors occur:

1. **Verify Aseprite is installed**: https://www.aseprite.org/
2. **Check aseprite-mcp binary permissions**: `chmod +x ${CLAUDE_PLUGIN_ROOT}/bin/aseprite-mcp`
3. **Manually edit config**: Edit `~/.config/aseprite-mcp/config.json`
4. **Test Aseprite directly**: Run `aseprite --version` in terminal
5. **Check logs**: Set `log_file` in config for debugging

### Platform-Specific Notes

**macOS:**
- Aseprite.app is a bundle; executable is inside Contents/MacOS/
- May need to grant Terminal/Claude Code permissions in System Preferences
- If downloaded from website, may need to allow in Security & Privacy

**Linux:**
- Installed via package manager: usually in /usr/bin/
- Compiled from source: often in /usr/local/bin/
- AppImage: specify full path to .AppImage file
- Snap: usually in /snap/bin/

**Windows:**
- Use quotes around path if it contains spaces
- Backslashes in path are okay, or use forward slashes
- May need to run as Administrator for some installation paths

### Configuration Tips

**For development:**
- Set `log_level` to "debug" for detailed output
- Set `log_file` to save logs for troubleshooting
- Enable `enable_timing` to see operation performance

**For production:**
- Keep `log_level` at "info" (default)
- Leave `log_file` empty unless debugging
- Disable `enable_timing` (default)

**For slow systems:**
- Increase `timeout` to 60 or more seconds
- Check that Aseprite runs quickly from command line

### Notes

- Setup only needs to be run once
- Re-run if Aseprite installation path changes
- Configuration persists across Claude Code sessions
- Can manually edit config.json if needed
- Health check verifies MCP server can communicate with Aseprite
- All subsequent commands depend on this configuration

### Next Steps After Setup

Once setup is complete:

1. **Create your first sprite:**
   ```
   /pixel-new 64x64
   ```

2. **Try natural language:**
   ```
   "Create a 32x32 pixel art character"
   ```

3. **Explore palette presets:**
   ```
   /pixel-palette set nes
   ```

4. **Export your work:**
   ```
   /pixel-export png sprite.png scale=4
   ```

5. **Get help:**
   ```
   /pixel-help
   ```
