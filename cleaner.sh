#!/bin/bash

echo "🧹 Starting user session cleanup (no sudo required)..."

echo "🗑️  Cleaning user temp files..."
rm -rf /tmp/"$USER"/* 2>/dev/null
rm -rf ~/.cache/* 2>/dev/null
rm -rf ~/.local/share/Trash/* 2>/dev/null

echo "🖼️  Cleaning thumbnail cache..."
rm -rf ~/.cache/thumbnails/*

echo "🧾 Clearing recent files..."
rm -f ~/.local/share/recently-used.xbel

echo "📜 Clearing bash history..."
shred -u ~/.bash_history 2>/dev/null
history -c

echo "🧾 Cleaning user logs (VS Code, etc)..."
find ~/.config -type f -name "*.log" -delete 2>/dev/null
find ~/.local/share -type f -name "*.log" -delete 2>/dev/null

echo "🌐 Cleaning browser cache (Firefox)..."
rm -rf ~/.mozilla/firefox/*.default-release/cache2/* 2>/dev/null

echo "🧮 Cleaning SQLite cache files..."
find ~/.cache -name "*.sqlite" -delete 2>/dev/null


echo "📜 Clearing other shell histories..."
rm -f ~/.zsh_history ~/.lesshst ~/.python_history 2>/dev/null

if command -v flatpak &> /dev/null; then
  echo "📦 Cleaning Flatpak leftovers..."
  flatpak uninstall --unused -y
fi

echo "✅ User session cleanup complete!"
