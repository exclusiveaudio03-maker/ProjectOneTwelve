Master Exoskeleton + Game Project
================================

This archive contains the FULL exoskeleton package: Godot demo + GitHub repository scaffold + master manifest.

Structure:
- src/game_project/    -> The Godot 4 portrait demo (open project.godot inside this folder)
- docs/                -> Documentation and iOS build notes
- export/ios/          -> iOS export scaffold (placeholders)
- exoskeleton_manifest.json -> Master manifest describing contents and batches included

How to run:
1. Copy the `src/game_project` folder to your local machine.
2. Open it in Godot 4 (open the folder as a project or open project.godot inside).
3. Run the main scene (scenes/main.tscn). The intro cutscene will auto-play and the tutorial mission will start.

GitHub:
- This repo scaffold is ready to be pushed. IGNORE binary exports and large assets.
- Use the included .gitignore to avoid committing export/import folders.

iOS Build:
- See docs/iOS_BUILD.md for steps to export an Xcode project and sign it.

Enjoy!

