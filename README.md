# Offline-ready Ollama + Twinny (v4)

This repo bundles Ollama (with your chosen model) and the Twinny VS Code extension into a single Docker image for offline use.

The download of the extension in the internet environment may actually be useless lol

## Prerequisites

- **Internet env**: Docker, Git  
- **Offline env**: Docker, VS Code

---

## 1. Internet Environment

1. **Clone this repo**  

2. **Build & export**  
   ```bash
    ./build_and_export.sh 3.23.17 gemma3:1b ./exported
   ```
   - `https://github.com/twinnydotdev/twinny.git`: Twinny extension Git URL  
   - `gemma3:1b`: Ollama model tag  
   - `./exported`: Output folder

3. **Transfer** the entire `./exported` folder to your offline machine.

---

## 2. Offline Environment

1. **Load the image**  
   ```bash
   docker load -i exported/twinny-ollama.tar
   ```

2. **Run Ollama**  
   ```bash
   docker run -d \
     --name ollama \
     -v ollama:/root/.ollama \
     -p 11434:11434 \
     twinny-ollama
   ```

3. **Extract Twinny** in VS Code  
   - Just see the .vscode directory
   - Copy something that looks like rjmacarthy.twinny-3.23.18-win32-x64/
   - Zip it with the following instructions
   ```
   cd exported
   # 1. Create the proper wrapper folder
   mkdir extension
   # 2. Copy all of Twinny’s files into it
   cp -r rjmacarthy.twinny-3.23.18-win32-x64/* extension/
   # 3. Zip that folder into a VSIX
   zip -r twinny.vsix extension
   # 4. Install
   code --install-extension twinny.vsix
   ```


---

## Command Reference

```bash
# Build & export
./build_and_export.sh <TWINNY_REPO_URL> <MODEL_NAME> <EXPORT_DIR>
```
- `<TWINNY_REPO_URL>`: URL of Twinny’s Git repo  
- `<MODEL_NAME>`: Ollama model (e.g. `gemma3:1b`)  
- `<EXPORT_DIR>`: where to dump tar & extension

```bash
# Run Ollama offline
docker run -d --name ollama -v ollama:/root/.ollama -p 11434:11434 twinny-ollama
```
