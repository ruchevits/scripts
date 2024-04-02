#!/bin/bash

function install_vscode_extension() {
    code --list-extensions | grep $1
    if [[ $? == 0 ]]; then
        echo "VSCode extension is already installed: $1"
    else
        code --install-extension $1
    fi
}

function step_vscode_extensions() {
    print_step_info "Installing VSCode extensions"

    # If VSCode CLI is not found
    if [[ $+commands[code] == 0 ]]; then
        return
    fi

    # MAYBE
    # "thang-nm.catppuccin-perfect-icons"
    # "github.copilot"
    # "github.copilot-chat"
    # "github.github-vscode-theme"
    # "github.vscode-github-actions"
    # "rvest.vs-code-prettier-eslint"
    # "davidanson.vscode-markdownlint"          # Markdown linting and style checking
    # "mechatroner.rainbow-csv"                 # Highlight CSV and TSV files, Run SQL-like queries
    # "shd101wyy.markdown-preview-enhanced"     # Markdown Preview Enhanced ported to vscode
    # "kisstkondoros.vscode-gutter-preview"     # Shows image preview in the gutter and on hover
    # "mushan.vscode-paste-image"               # Paste image directly from clipboard to markdown/asciidoc(or other file)!
    # "redhat.vscode-xml"                       # XML Language Support

    # Common
    # "github.github-vscode-theme"              # GitHub Theme
    # "miguelsolorio.fluent-icons"              # Fluent product icons for Visual Studio Code
    # "vscode-icons-team.vscode-icons"          # Icons for Visual Studio Code
    # "editorconfig.editorconfig"               # EditorConfig Support
    # "bierner.markdown-preview-github-styles"  # Changes VS Code's built-in markdown preview to match Github's style
    # "mikestead.dotenv"                        # Support for dotenv file syntax
    # "eamodio.gitlens"                         # Git blame annotations
    # "gimenete.github-linker"                  # Create links to fragments of code in GitHub
    # "streetsidesoftware.code-spell-checker"   # Spelling checker for source code
    # "streetsidesoftware.code-spell-checker-british-english"
    # MAYBE "tintinweb.vscode-inline-bookmarks" # Customizable Inline Bookmarks
    # MAYBE "gruntfuggly.todo-tree"             # Show TODO, FIXME, etc. comment tags in a tree view
    # MAYBE "ryu1kn.partial-diff"               # Compare (diff) text selections within a file, across files, or to the clipboard

    # DevOps
    # "hashicorp.terraform"                                 # Syntax highlighting and autocompletion for Terraform
    # "pjmiravalle.terraform-advanced-syntax-highlighting"  # Advanced Syntax Highlighting for all Terraform file types
    # "run-at-scale.terraform-doc-snippets"                 # Terraform code snippets pulled from examples in the terraform registry provider docs
    # "devadvice.serverlessconsole"                         # An alternative UI for AWS CloudWatch and DynamoDB, focused on "serverless development"
    # "threadheap.serverless-ide-vscode"                    # Enhanced support for AWS SAM, CloudFormation and Serverless Framework
    # "ms-azuretools.vscode-docker"                         # Makes it easy to create, manage, and debug containerized applications

    # JavaScript
    # "ecmel.vscode-html-css"                   # CSS Intellisense for HTML
    # "esbenp.prettier-vscode"                  # Code formatter using prettier
    # "inferrinizzard.prettier-sql-vscode"      # VSCode Extension to format SQL files
    # "chrmarti.regex"                          # Regex matches previewer for JavaScript, TypeScript, PHP and Haxe
    # "christian-kohler.npm-intellisense"       # Autocomplete npm modules in import statements
    # "miclo.sort-typescript-imports"           # Sorts import statements in Typescript code
    # "pmneo.tsimporter"                        # Automatically searches for TypeScript definitions in workspace files and provides all known symbols as completion item to allow code completion
    # "yoavbls.pretty-ts-errors"                # Make TypeScript errors prettier and more human-readable
    # "dbaeumer.vscode-eslint"                  # Integrates ESLint JavaScript into VS Code
    # "christian-kohler.path-intellisense"      # Autocompletes filenames (for Javascript only?)
    # "mariusalchimavicius.json-to-ts"          # Convert JSON object to typescript interfaces
    # "bradlc.vscode-tailwindcss"               # Intelligent Tailwind CSS tooling for VS Code
    # "stivo.tailwind-fold"                     # Improves code readability by folding class attributes
    # "orta.vscode-jest"                        # Jest test runner
    # "dsznajder.es7-react-js-snippets"         # Extensions for React, React-Native and Redux in JS/TS with ES7+ syntax. Customizable. Built-in integration with prettier
    # "xabikos.reactsnippets"                   # Code snippets for Reactjs development in ES6 syntax
    # "vue.volar"                               # Language Support for Vue
    # MAYBE "steoates.autoimport"               # Automatically finds, parses and provides code actions and code completion for all available imports. Works with Typescript and TSX

    # Python
    # "ms-python.python"                        # Python language support, including features such as IntelliSense (Pylance), linting, debugging (Python Debugger), code navigation, code formatting, refactoring, variable explorer, test explorer, and more!
    # "ms-python.debugpy"                       # Python Debugger extension using debugpy
    # "ms-python.vscode-pylance"                # A performant, feature-rich language server for Python in VS Code
    # MAYBE "ms-toolsai.jupyter"
    # MAYBE "ms-toolsai.jupyter-keymap"
    # MAYBE "ms-toolsai.jupyter-renderers"
    # MAYBE "ms-toolsai.vscode-jupyter-cell-tags"
    # MAYBE "ms-toolsai.vscode-jupyter-slideshow"
    # MAYBE "donjayamanne.python-environment-manager" # View and manage Python environments & packages

    # C++
    # "ms-vscode.cpptools"                      # C/C++ IntelliSense, debugging, and code browsing
    # "ms-vscode.cmake-tools"                   # Extended CMake support in Visual Studio Code

    # Rust
    # "rust-lang.rust-analyzer"                 # Rust language support

    # Go
    # "golang.go"                               # Rich Go language support for Visual Studio Code

    # Web3
    # "juanblanco.solidity"                     # Ethereum Solidity Language support
    # "tintinweb.solidity-metrics"              # Solidity Metrics generator
    # MAYBE "ericglau.defi-ls"                  # Ethereum DeFi support for NodeJS applications

    vscode_extensions=(
    )

    for i in "${vscode_extensions[@]}"; do
        install_vscode_extension $i
    done
}
