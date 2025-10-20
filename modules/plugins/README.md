# Windows VST Plugins

This directory contains Windows VST plugin definitions that are automatically discovered and integrated by the `windows-vst.nix` module.

## How to Add a New Plugin

1. **Create a new `.nix` file** in this directory (e.g., `my-plugin.nix`)

2. **Follow the pattern** used in `serum2.nix`:

```nix
{ stdenvNoCC, lib, pkgs, requireFile }:

let
  _version = "1.0.0";

  plugin-installer = requireFile {
    name = "Install_PluginName_${_version}.exe";
    sha256 = "your-sha256-hash-here";
    url = "https://plugin-website.com/download";
  };

in
stdenvNoCC.mkDerivation {
  pname = "plugin-name";
  version = _version;
  src = plugin-installer;
  dontUnpack = true;

  nativeBuildInputs = [
    pkgs.wine-staging
    pkgs.xvfb-run
  ];

  installPhase = ''
    runHook preInstall

    export WINEPREFIX="$PWD/wineprefix"
    export XDG_CONFIG_HOME="$PWD/.config"

    # Run the installer silently
    xvfb-run wine $src /S

    mkdir -p $out/lib/vst

    # Copy the VST files from the wine prefix to the output
    cp -r "$WINEPREFIX/drive_c/Program Files/Common Files/VST3/YourPlugin.vst3" "$out"
    # Add any additional files (presets, etc.)

    runHook postInstall
  '';

  meta = with lib; {
    description = "Your Plugin Description";
    homepage = "https://plugin-website.com";
    license = licenses.unfree;
    platforms = [ "x86_64-linux" ];
  };
}
```

3. **Rebuild your system**:
   ```bash
   sudo nixos-rebuild switch
   ```

4. **The yabridge configuration is automatic!** The `yabridge.nix` home-manager module will automatically:
   - Find the plugin bundle
   - Add it to yabridge
   - Sync yabridge
   - Clean up old plugin paths

5. **Restart your DAW** (e.g., Bitwig Studio) and rescan plugins - your new VST should appear!

## Getting the Installer File

When you first build, Nix will prompt you to provide the installer file:

```
error: unfortunately, we cannot download file 'Install_PluginName_1.0.0.exe' automatically.
Please go to https://plugin-website.com/download to download the file manually,
and add it to the Nix store using:
  nix-store --add-fixed sha256 /path/to/Install_PluginName_1.0.0.exe
```

Follow the instructions to download and add the file to the Nix store.

## Finding VST Installation Paths

Different plugins install to different locations. Common paths in the Windows environment:

- **VST3**: `C:\Program Files\Common Files\VST3\`
- **VST2**: `C:\Program Files\Steinberg\VstPlugins\`
- **Presets**: `C:\Users\{user}\Documents\{PluginVendor}\`
- **App Data**: `C:\Users\{user}\AppData\Roaming\{PluginVendor}\`

To find where a plugin installs, you can:

1. Install it manually in a wine prefix
2. Search for the VST files: `find wineprefix -name "*.vst3" -o -name "*.dll"`
3. Use those paths in your plugin definition

## Tips

- Use `/S` or `/SILENT` flags for silent installation (check the installer documentation)
- Some installers may require different flags (`/SP- /VERYSILENT /SUPPRESSMSGBOXES`)
- If the installer shows dialogs even with silent flags, it may need additional configuration
- Test the plugin in your DAW after installation to ensure it works correctly
