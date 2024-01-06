# Personal NixOS + Home Manager Config


## Setup as NixOS Configuration

Available hosts:
- desktop
- laptop
- vbox

### Fresh installation

```
git clone https://github.com/lwndhrst/nixos-config /mnt/etc/nixos
```
Make sure to replace `/mnt/etc/nixos/hosts/<host>/hardware-configuration.nix` with an appropriate one for your system (see: `nixos-generate-config`).
```
sudo nixos-install --flake /mnt/etc/nixos#<host>
```

### Rebuild

Make sure to `git add` new files before rebuilding as they will be ignored otherwise.
```
sudo nixos-rebuild switch --flake /etc/nixos#<host>
```

### Update flake from within the flake dir

```
nix flake update
```


## Setup with standalone Home Manager

Available hosts:
- desktop
- laptop
- vbox
- wsl

### For non-NixOS Systems

Install nix via the [Determinate Nix Installer](https://github.com/DeterminateSystems/nix-installer).
```sh
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install linux --init none
```
Note: you may need to install a few extra packages, such as `curl` or `git`.

### Initial setup of [Home Manager with Flakes](https://nix-community.github.io/home-manager/index.html#ch-nix-flakes).

```sh
git clone https://github.com/lwndhrst/nixos-config ~/.config/home-manager
```
```sh
nix run home-manager/master -- switch --flake .#<host>
```

### Update as follows:

```sh
nix flake update && home-manager switch --flake .#<host>
```

### Get OpenGL and Vulkan to work on non-NixOS Systems with [nixGL](https://github.com/guibou/nixGL)

Invoke OpenGL/Vulkan programs by prefixing the appropriate wrapper:

- `nixGLIntel <program> <args>`
- `nixGLMesa <program> <args>`
- `nixGLNvidia <program> <args>`
- `nixVulkanIntel <program> <args>`
- `nixVulkanMesa <program> <args>`
- `nixVulkanNvidia <program> <args>`

```nix
# devShell config for nix develop
{
  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    nixgl = {
      url = "github:guibou/nixGL";
    };
  };

  outputs = { self, nixpkgs, nixgl }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          nixgl.overlays.default
        ];
      };

    in {
      devShell.${system} = pkgs.mkShell {
        packages = with pkgs; [
          mesa-demos
          pkgs.nixgl.nixGLMesa
        ];

        LD_LIBRARY_PATH = with pkgs; lib.makeLibraryPath [
          xorg.libX11
        ];
      };
    };
}
```

### Misc

- For removing Windows PATH and disabling execution of Windows binaries on WSL add the following to `/etc/wsl.conf`:
   ```
   [interop]
   enabled = false
   appendWindowsPath = false
   ```
   Note: requires restart of WSL: `wsl --shutdown`.

- Set `zsh` as default shell by first adding its absolute path to `/etc/shells` and then running `chsh`
   ```
   /home/<user>/.nix-profile/bin/zsh
   ```
   ```sh
   chsh -s /home/<user>/.nix-profile/bin/zsh
   ```
- Wezterm config for WSL 2:
   ```lua
   local wezterm = require('wezterm')
   local muz = wezterm.mux
   
   local colors = require('lua/rose-pine').colors()

   wezterm.on("gui-startup", function()
       local tab, pane, window = mux.spawn_window{}
       window:gui_window():maximize()
   end)

   return {
       default_domain = 'WSL:Debian',
       enable_tab_bar = false,

       colors = colors,
       force_reverse_video_cursor = true,

       font = wezterm.font('Cascadia Mono'),
       font_size = 14.0,
   }
   ```


## Usage as NixOS Module

Available modules:
- desktop
- laptop
- vbox

```nix
inputs.nixos-config = {
  url = "github:lwndhrst/nixos-config";
  inputs.nixpkgs.follows = "nixpkgs";
};
```

```nix
# ...

lib.nixosSystem {
  inherit lib pkgs system;

  specialArgs = {
    inherit user;
  };

  modules = [
    ./configuration.nix

    # Home config from nixos-config flake
    nixos-config.nixosModules.desktop;
  ];
};

# ...
```


## Example flake for `nix develop`

Put flake into `path/to/project/flake.nix` and enter dev shell via `nix develop`.

```nix
{
  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };

    in {
      devShell.${system} = pkgs.mkShell {
        buildInputs = with pkgs; [
          texlive.combined.scheme-full
          texlab
        ];
      };
    };
}
```



## Working with Godot and WSL 2

Godot on Windows:
- set language server address to `0.0.0.0` and hit enter
- Windows should open a dialog to update firewall settings
- update firewall manually otherwise

Add a flake like this to your Godot project:

```nix
{
  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
  };

  outputs = { self, nixpkgs }:
    let
      forEachSystem = fn:
        nixpkgs.lib.genAttrs [
          "x86_64-linux"
        ] (system: fn (import nixpkgs { inherit system; }) system);

    in {
      devShells = forEachSystem (pkgs: system: {
        default = pkgs.mkShell {
          name = "godot";
          packages = with pkgs; [];
          shellHook = ''
            export GDScript_Addr=$(ip route list default | awk '{print $3}')
          '';
        };
      });
    };
}
```

Update LSP config for your text editor to use the remote address (Windows host) instead.
Here's an example for Neovim using [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig):

```lua
-- gdscript lsp
local gdscript_addr = os.getenv("GDScript_Addr") or "127.0.0.1"
local gdscript_port = os.getenv("GDScript_Port") or "6005"
lsp.gdscript.setup(vim.tbl_extend("error", default_config, {
	cmd = vim.lsp.rpc.connect(gdscript_addr, gdscript_port),
}))
```

To allow Godot to open files in Neovim running in WSL, start `nvim` as a server.

```sh
nvim --listen ~/.cache/nvim/godot.pipe
```

Make a batch file and set it as the external editor executable in Godot.
Exec flags should be smth like `{file}`. Unfortunately flags such as `+call cursor({line}, {col})` don't seem to work with `nvim --remote`.

```console
@echo off
wsl ~/.nix-profile/bin/nvim --server ~/.cache/nvim/godot.pipe --remote $(wslpath %1)
```

