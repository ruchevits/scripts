#!/bin/bash

function step_javascript() {
    print_step_info "Installing JavaScript tools"

    volta install node
    volta install pnpm
    volta install serverless
    volta install vercel
    volta install vite
}
