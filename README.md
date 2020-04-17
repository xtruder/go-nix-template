# go-nix-template
Go template with nix integration

# Merging into existing repo

```
git remote add go-nix-template https://github.com/xtruder/go-nix-template.git
git fetch go-nix-template
git checkout -p go-nix-template/master shell.nix .nixpkgs-version.json .envrc git/gitignore
mv git/gitignore .git/gitignore
git config core.excludesfile .git/gitignore
```
