# Multi-Version Build System

This repository now supports building three different versions of the Stamos OS image, each based on a different Fedora version:

## Version Matrix

| Tag | Fedora Version | Description |
|-----|----------------|-------------|
| `gts` | 42 | Greatest Tenable Stable - Battle-tested and stable |
| `stable` | 43 | Latest stable release - Recommended for most users |
| `unstable` | 44 | Next release - For testing and early adopters |

## GitHub Actions

The GitHub Actions workflow automatically builds all three versions on every push to main and daily at 10:05 AM UTC. Each version is tagged appropriately:

- `ghcr.io/your-username/stamos:gts` (Fedora 42)
- `ghcr.io/your-username/stamos:stable` (Fedora 43)
- `ghcr.io/your-username/stamos:unstable` (Fedora 44)

Additionally, each build gets:
- Version-specific tags: `gts.20241218`, `stable.20241218`, `unstable.20241218`
- Fedora version tags: `fedora42`, `fedora43`, `fedora44`
- Date tags: `fedora42.20241218`, `fedora43.20241218`, `fedora44.20241218`

## Local Building

### Quick Build Commands

```bash
# Build GTS version (Fedora 42)
just build-gts

# Build stable version (Fedora 43)
just build-stable

# Build unstable version (Fedora 44)
just build-unstable

# Build all versions
just build-all

# Build with custom name
just build-gts localhost/my-stamos
just build-stable localhost/my-stamos
```

### Manual Build Command

```bash
# Build specific version
just build [image-name] [tag] [fedora-version]

# Examples:
just build stamos gts 42
just build stamos stable 43
just build stamos unstable 44
just build localhost/my-custom latest 43
```

## Switching Between Versions

To switch between versions on a bootc system:

```bash
# Switch to GTS (Fedora 42)
sudo bootc switch ghcr.io/your-username/stamos:gts

# Switch to stable (Fedora 43)
sudo bootc switch ghcr.io/your-username/stamos:stable

# Switch to unstable (Fedora 44)
sudo bootc switch ghcr.io/your-username/stamos:unstable

# Then reboot
sudo systemctl reboot
```

## VM Image Building

You can also build VM images for each version:

```bash
# Build QCOW2 for GTS
just rebuild-qcow2 localhost/stamos gts 42

# Build QCOW2 for stable
just rebuild-qcow2 localhost/stamos stable 43

# Build QCOW2 for unstable
just rebuild-qcow2 localhost/stamos unstable 44

# Build and run VM for testing
just run-vm-qcow2 localhost/stamos stable
```

## Development Workflow

When making changes:

1. Test with a specific version:
   ```bash
   just build-unstable
   just run-vm-qcow2 localhost/stamos unstable
   ```

2. Once tested, the changes will automatically build all three versions in CI

3. Users can choose which version track they want to follow

## Version Support Policy

- **GTS (42)**: Updated with security fixes, minimal changes
- **Stable (43)**: Current mainline, receives regular updates
- **Unstable (44)**: Pre-release testing, may have breaking changes

When Fedora 45 is released:
1. Migrate 42 → 43 (GTS)
2. Migrate 43 → 44 (Stable)
3. Migrate 44 → 45 (Unstable)
4. Drop Fedora 42 support
