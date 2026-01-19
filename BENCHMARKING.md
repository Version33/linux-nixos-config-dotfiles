# Phoronix Benchmarking Shell

This NixOS flake provides an isolated development shell environment for system benchmarking with all required dependencies pre-installed.

## Overview

The benchmarking shell has been **removed from the system configuration** and replaced with an on-demand Nix development shell. This approach:

- Keeps your system clean (no permanent benchmarking tools)
- Provides all dependencies without manual installation
- Isolates benchmarking environment from system packages
- Saves disk space when not benchmarking

## Quick Start

### 1. Enter the Benchmarking Shell

```bash
cd ~/nixos
nix develop .#benchmark
```

This will:
- Download and cache all required dependencies
- Set up proper library paths (LD_LIBRARY_PATH, PKG_CONFIG_PATH)
- Display a welcome message with common commands

### 2. Run Your First Benchmark

Inside the shell, run:

```bash
phoronix-test-suite benchmark pts/creator
```

Follow the prompts to:
- Accept test installation
- Configure test options
- Run the benchmark suite
- Save results with a custom name

### 3. View Results

Results are automatically saved to:
```
~/.phoronix-test-suite/test-results/
```

## Common Commands

### Discovering Tests

```bash
# List all available benchmark suites
phoronix-test-suite list-available-suites

# List all individual tests
phoronix-test-suite list-all-tests

# Search for specific tests
phoronix-test-suite list-available-tests | grep -i "keyword"

# Get detailed info about a test/suite
phoronix-test-suite info pts/creator
```

### Running Benchmarks

```bash
# Run a complete benchmark suite
phoronix-test-suite benchmark pts/creator

# Run a single test
phoronix-test-suite benchmark pts/blender

# Run multiple tests
phoronix-test-suite benchmark pts/blender pts/ffmpeg pts/x264

# Batch mode (non-interactive)
phoronix-test-suite batch-benchmark pts/creator
```

### Managing Tests

```bash
# List installed tests
phoronix-test-suite list-installed-tests

# List cached/downloaded tests
phoronix-test-suite list-cached-tests

# Remove specific test
phoronix-test-suite remove-test pts/blender

# Clean all test cache
phoronix-test-suite remove-all-tests
```

### Working with Results

```bash
# List all saved results
phoronix-test-suite list-saved-results

# Show results
phoronix-test-suite show-result RESULT_NAME

# Compare two results
phoronix-test-suite compare-results RESULT1 RESULT2

# Export results to different formats
phoronix-test-suite result-file-to-pdf RESULT_NAME
phoronix-test-suite result-file-to-json RESULT_NAME
phoronix-test-suite result-file-to-csv RESULT_NAME
phoronix-test-suite result-file-to-html RESULT_NAME

# Upload results to OpenBenchmarking.org
phoronix-test-suite upload-result RESULT_NAME
```

## Popular Benchmark Suites

### Content Creation (pts/creator)
Comprehensive suite for content creators:
- Blender rendering
- FFmpeg encoding
- ImageMagick operations
- Various multimedia workloads

```bash
phoronix-test-suite benchmark pts/creator
```

### Gaming Performance (pts/gaming)
Gaming-related benchmarks:
- Graphics rendering
- Physics simulations
- Game engine tests

```bash
phoronix-test-suite benchmark pts/gaming
```

### CPU Tests (pts/cpu)
CPU-focused benchmarks:
- Compression (7-Zip, zstd)
- Compilation
- Scientific computing
- Cryptography

```bash
phoronix-test-suite benchmark pts/cpu
```

### Graphics Tests (pts/graphics)
GPU and graphics benchmarks:
- OpenGL/Vulkan rendering
- Ray tracing
- GPU compute

```bash
phoronix-test-suite benchmark pts/graphics
```

### Storage I/O (pts/disk)
Disk performance tests:
- Sequential read/write
- Random I/O
- Database workloads

```bash
phoronix-test-suite benchmark pts/disk
```

### Memory Tests (pts/memory)
RAM benchmarks:
- Bandwidth
- Latency
- Cache performance

```bash
phoronix-test-suite benchmark pts/memory
```

## Individual Test Examples

### Blender Rendering
```bash
phoronix-test-suite benchmark pts/blender
```

### Video Encoding (FFmpeg)
```bash
phoronix-test-suite benchmark pts/ffmpeg
```

### Compilation Speed
```bash
phoronix-test-suite benchmark pts/build-linux-kernel
```

### 7-Zip Compression
```bash
phoronix-test-suite benchmark pts/compress-7zip
```

### Stress Testing
```bash
phoronix-test-suite benchmark pts/stress-ng
```

## Advanced Usage

### Custom Test Configuration

Edit test options before running:
```bash
phoronix-test-suite batch-setup
```

### System Information

View system details:
```bash
phoronix-test-suite system-info
phoronix-test-suite system-sensors
```

### Performance Monitoring

Monitor during tests:
```bash
phoronix-test-suite monitor pts/creator
```

### Batch Testing with Config File

Create `~/.phoronix-test-suite/batch.config`:
```
SaveResults=TRUE
OpenBrowser=FALSE
UploadResults=FALSE
PromptForTestDescription=FALSE
RunAllTestCombinations=TRUE
```

Then run:
```bash
phoronix-test-suite batch-benchmark pts/creator
```

## Included Dependencies

The benchmark shell includes all necessary dependencies:

### Graphics & Rendering
- OpenGL (Mesa, GLEW)
- OpenCL (ICD loader, headers)
- SDL 1.x and 2.x
- X.Org development libraries

### Image Processing
- JPEG, TIFF, PNG libraries
- OpenEXR, OpenCV
- Freetype

### Build Tools
- CMake, Meson, SCons, Make
- Autoconf, Automake, M4
- Libtool, pkg-config
- GCC C/C++ compiler
- Rust (rustc, cargo)
- NASM, YASM assemblers

### Development Libraries
- Boost C++
- Qt5
- libxml2, TinyXML
- HDF5
- SWIG

### Audio Libraries
- Vorbis, FFTW, PortAudio

### Python
- Python 3 with NumPy

### Archive & Compression Tools
- unzip, zip, gnutar
- gzip, bzip2, xz
- 7-Zip, zlib

### System Utilities
- curl, wget, git
- patch, which, file
- coreutils, findutils
- GNU sed, grep, awk
- bison, flex, diffutils

## System Configuration Changes

### What Changed

1. **Removed**: `modules/development/benchmarking.nix` (system-wide package)
2. **Added**: `flake-parts/benchmark-shell.nix` (dev shell)
3. **Updated**: `modules/default.nix` (removed benchmarking module import)
4. **Updated**: `flake.nix` (added benchmark shell import)

### Applying Changes

To apply the system configuration changes (remove phoronix-test-suite from system):

```bash
cd ~/nixos
just switch
```

Or manually:
```bash
sudo nixos-rebuild switch --flake .#k0or
```

### Reverting (if needed)

If you want the old behavior (system-wide installation), you can:

1. Restore `modules/development/benchmarking.nix`
2. Add it back to `modules/default.nix`
3. Run `just switch`

## Troubleshooting

### Missing Dependencies Error

If tests fail with missing dependencies:

1. Ensure you're inside the benchmark shell:
   ```bash
   nix develop .#benchmark
   ```

2. Check library paths are set:
   ```bash
   echo $LD_LIBRARY_PATH
   echo $PKG_CONFIG_PATH
   ```

3. If you see errors like:
   - `unzip: command not found` - Exit and re-enter the shell (already fixed)
   - `autoconf: command not found` - Exit and re-enter the shell (already fixed)
   - `requires autoconf 2.59 or above` - Exit and re-enter the shell (autoconf 2.72 included)

4. After updating the benchmark shell, you must **exit and re-enter** for changes to take effect:
   ```bash
   exit                          # Exit old shell
   nix develop .#benchmark       # Enter updated shell
   ```

### Test Download Fails

```bash
# Clear download cache
phoronix-test-suite remove-cached-tests

# Try downloading again
phoronix-test-suite benchmark pts/TEST_NAME
```

### Disk Space Issues

Phoronix tests can be large. Clean up with:

```bash
# Remove all test files
phoronix-test-suite remove-all-tests

# Remove old results
phoronix-test-suite remove-result OLD_RESULT_NAME
```

### OpenCL Tests Failing

For AMD GPU OpenCL support, ensure `rocm-opencl-runtime` is in your system packages:

```nix
# In your NixOS configuration
environment.systemPackages = with pkgs; [
  rocm-opencl-runtime
];
```

## Tips & Best Practices

### Before Benchmarking

1. **Close unnecessary applications** to reduce system load
2. **Disable CPU frequency scaling** for consistent results:
   ```bash
   # Check current governor
   cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
   
   # Set to performance (requires root)
   echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
   ```

3. **Monitor temperatures** to avoid thermal throttling
4. **Use consistent power settings** (disable laptop power saving)

### During Benchmarking

- Don't interrupt tests (they can take hours)
- Monitor system resources with `htop` in another terminal
- Keep the system well-ventilated

### After Benchmarking

- Save results with descriptive names
- Compare before/after system changes
- Share results on OpenBenchmarking.org (optional)

## Useful Resources

- **Official Documentation**: https://github.com/phoronix-test-suite/phoronix-test-suite/
- **OpenBenchmarking**: https://openbenchmarking.org/
- **Test Profiles**: https://github.com/phoronix-test-suite/test-profiles
- **Community Forum**: https://www.phoronix.com/forums/

## Exit the Shell

When done benchmarking:

```bash
exit
```

All test data and results remain in `~/.phoronix-test-suite/` for future sessions.
