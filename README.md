# Neovim Configuration

This is my personal configuration for Neovim, designed to enhance productivity and efficiency in software development.
![image](https://github.com/user-attachments/assets/144b770a-0437-42a9-a180-be5e5a82f86d)
![image](https://github.com/user-attachments/assets/7cdbbb05-a0f6-41d3-b1c2-174fbae59cba)


---

## About

This configuration includes various plugins and custom settings to improve the editing experience in Neovim. The goal is to provide an efficient and customizable development environment.

---

## Installation

### Prerequisites

Make sure you have installed:

- [Neovim](https://neovim.io/) >= **0.9.0** (needs to be built with **LuaJIT**)
- Basic utils: `git`, `make`, `unzip`, C Compiler (`gcc`)
- [Git](https://git-scm.com/) >= **2.19.0** (for partial clones support)
- A [Nerd Font](https://www.nerdfonts.com/): optional, provides various icons
  - if you have it set `vim.g.have_nerd_font` in `lua/config/options.lua` to true
- Language Setup:
  - If you want to write Typescript, you need `npm`
  - If you want to write Golang, you will need `go`
  - Add additional tools depending on the programming languages you use.

### Steps

1.  **Clone the Repository**:

    ```bash
    git clone https://github.com/username/nvim-config.git ~/.config/nvim
    ```

2.  **Remove the `.git` folder, so you can add it to your own repo later**

    ```bash
    rm -rf ~/.config/nvim/.git
    ```

3.  **Start Neovim**:

    ```bash
    nvim
    ```

    That's it! Lazy will install all the plugins you have. Use `:Lazy` to view the current plugin status. Hit `q` to close the window.

---

## File Structure

Here is the structure of the configuration files:

```
~/.config/nvim
├── after
│   ├── ftplugin
│   └── queries
├── lua
│   ├── config
│   │   ├── autocmds.lua
│   │   ├── keymaps.lua
│   │   ├── lazy.lua
│   │   └── options.lua
│   ├── plugins
│   │   ├── coding
│   │   ├── editor
│   │   └── ui
│   └── utils
├── queries
└── init.lua
```

---
