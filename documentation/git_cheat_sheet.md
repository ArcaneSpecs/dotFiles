# Staging files (adding files, ready for commit)
git add filename.txt

# or add all files in the current directory
git add .

# or add recursively all files and subdirectories
git add test_folder/*

# Commit files (staged files)
git commit -a

# Check overall git status (staged files, untracked files, etc.)
git status

# Check git log (history of commits, newest on the top)
git log

# Change default editor to vs code
git config --global core.editor code --wait


