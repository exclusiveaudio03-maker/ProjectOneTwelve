
Prototype: Zero Twelve - Demo
=================================

Contents:
- Godot 4 project (portrait mobile) with a playable tutorial combat test
- Scenes: main.tscn, tutorial.tscn
- Scripts: player.gd, enemy.gd, game_manager.gd
- UI: HUD with TouchScreenButtons (ui/hud.tscn + ui/hud.gd)
- Loading screen: assets/loading_screen/index.html + style + script, uses embedded title.png
- Data: simple mission JSON for the tutorial
- export_presets/: placeholder for Godot export settings

How to run locally:
1. Install Godot 4.x (stable).
2. Copy this folder to your machine and open the folder in Godot.
3. Open 'scenes/main.tscn' and press Play.
4. For mobile: configure export presets in Godot (export_presets.cfg placeholder included).

iOS Notes:
- To export to iOS you must use a Mac with Xcode and Apple signing keys.
- Follow Godot's docs to export an Xcode project, then sign & deploy using Xcode.
