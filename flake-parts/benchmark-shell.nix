##############################################################################
# Benchmarking Development Shell
#
# Purpose: Isolated environment for system benchmarking with Phoronix Test Suite
# Features:
#   - Phoronix Test Suite with all dependencies pre-installed
#   - Graphics libraries (OpenGL, OpenCL, SDL)
#   - Image processing (JPEG, TIFF, PNG, OpenEXR, OpenCV)
#   - Build tools (CMake, Meson, SCons, Make, Libtool)
#   - Compilers and assemblers (GCC, Rust, NASM, YASM)
#   - Audio libraries (PortAudio, Vorbis, FFTW)
#   - Development libraries (Boost, Qt5, Python with NumPy)
#
# Usage:
#   nix develop .#benchmark    # Enter benchmark shell
#   phoronix-test-suite benchmark pts/creator    # Run creator benchmark suite
#   phoronix-test-suite list-available-suites    # List all available test suites
#   phoronix-test-suite list-installed-tests     # Show installed tests
#
# Notes:
#   - All dependencies are available without system installation
#   - Test data stored in ~/.phoronix-test-suite/
#   - Results saved to ~/.phoronix-test-suite/test-results/
##############################################################################

{ inputs, ... }:

{
  perSystem =
    { pkgs, ... }:
    {
      devShells.benchmark = pkgs.mkShell {
        name = "phoronix-benchmark-env";

        packages = with pkgs; [
          # Core benchmarking tool
          phoronix-test-suite

          # Graphics libraries
          glew # OpenGL Extension Wrangler
          xorg.xorgserver # X.Org Development
          xorg.libX11
          xorg.libXext
          xorg.libXrender
          mesa # OpenGL implementation
          ocl-icd # OpenCL ICD loader
          opencl-headers # OpenCL headers

          # SDL libraries
          SDL # SDL 1.x
          SDL2 # SDL 2.x
          SDL_image
          SDL_net

          # Image processing libraries
          libjpeg # JPEG Library
          libtiff # TIFF Image
          libpng # PNG Library
          openexr # OpenEXR
          opencv # OpenCV
          freetype # Freetype
          ocrmypdf # PDF OCR tool
          tesseract # OCR engine

          # Compression and utilities
          zlib # Zlib
          p7zip # 7-Zip / p7zip
          unzip # Unzip (required by many test install scripts)
          zip # Zip
          gzip # Gzip
          bzip2 # Bzip2
          xz # XZ Utils
          gnutar # GNU Tar archiver

          # Build systems and tools
          cmake # CMake
          meson # Meson Build System
          ninja # Ninja (used by Meson)
          scons # SCons
          gnumake # Make
          libtool # Libtool
          pkg-config # pkg-config
          autoconf # Autoconf (required by many tests)
          automake # Automake
          m4 # M4 macro processor (used by autoconf)

          # Compilers and assemblers
          gcc # C/C++ compiler
          rustc # Rust compiler
          cargo # Rust package manager
          nasm # Nasm Assembler
          yasm # Yasm Assembler

          # Development libraries
          boost # C++ Boost
          libxml2 # Libxml2
          swig # C++ SWIG
          qt5.qtbase # Qt5
          qt5.qttools # Qt5 tools
          tinyxml # TinyXML
          hdf5 # HDF5
          tcl # Tool Command Language

          # Python and related
          python3 # Python
          python3Packages.numpy # Python Numpy

          # Audio libraries
          libvorbis # Vorbis
          fftw # FFTW
          portaudio # PortAudio

          # Video acceleration
          libva # VA-API Video Acceleration API

          # Other utilities
          curl # Curl
          wget # wget (some tests may download files)
          git # Git (some tests may need it)
          bison # Bison
          flex # Flex
          patch # Patch utility
          which # Which command
          file # File type detection
          coreutils # Basic utilities (cp, mv, rm, etc.)
          findutils # Find utilities
          gnused # GNU sed
          gnugrep # GNU grep
          gawk # GNU awk
          diffutils # Diff utilities

        ];

        shellHook = ''
          echo "=================================================="
          echo "  Phoronix Test Suite Benchmarking Environment"
          echo "=================================================="
          echo ""
          echo "Common Commands:"
          echo "  phoronix-test-suite benchmark pts/creator    # Run creator benchmark suite"
          echo "  phoronix-test-suite list-available-suites    # List all available test suites"
          echo "  phoronix-test-suite list-all-tests           # List all available tests"
          echo "  phoronix-test-suite info pts/creator         # Show info about a test/suite"
          echo "  phoronix-test-suite result-file-to-pdf FILE  # Convert results to PDF"
          echo ""
          echo "Popular Benchmark Suites:"
          echo "  pts/creator       # Content creation benchmarks (Blender, ffmpeg, etc.)"
          echo "  pts/gaming        # Gaming performance tests"
          echo "  pts/cpu           # CPU-focused tests"
          echo "  pts/graphics      # Graphics rendering tests"
          echo "  pts/disk          # Storage I/O tests"
          echo "  pts/memory        # Memory bandwidth and latency tests"
          echo ""
          echo "Results Location: ~/.phoronix-test-suite/test-results/"
          echo ""
          echo "All dependencies are available in this shell environment."
          echo "=================================================="
          echo ""
        '';

        # Environment variables to help with finding libraries
        LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath (
          with pkgs;
          [
            glew
            mesa
            xorg.libX11
            xorg.libXext
            SDL
            SDL2
            libjpeg
            libtiff
            libpng
            openexr
            zlib
            boost
            libxml2
            opencv
            qt5.qtbase
            libvorbis
            fftw
            portaudio
            libva
            ocl-icd
          ]
        );

        PKG_CONFIG_PATH = pkgs.lib.makeSearchPath "lib/pkgconfig" (
          with pkgs;
          [
            glew
            xorg.xorgserver
            SDL
            SDL2
            libjpeg
            libtiff
            libpng
            openexr
            zlib
            boost
            libxml2
            opencv
            freetype
            qt5.qtbase
            libvorbis
            fftw
            portaudio
            libva
            ocl-icd
          ]
        );
      };
    };
}
