# Simple 3D Racing Game

## Overview

This project is a simple 3D racing game where the player controls a car and aims to reach a predefined destination in the shortest time possible. The track is built using provided assets, including roads, barriers, and environmental elements.

The player starts from a fixed position, and the race begins immediately (or optionally after a countdown). The main objective is to complete 3 laps of the track as quickly as possible while maintaining control of the vehicle and avoiding penalties.

---

## Gameplay

The player drives a car along a predefined track with full control over acceleration, braking, and steering. A timer tracks how long it takes to reach the finish area.

If the player collides with the track boundaries, the car is smoothly pushed backward before control is returned. The player has a limited number of lives, representing the number of allowed collisions. Once all lives are used, the game ends.

---

## Core Features (Required)

* A drivable car with:

  * Forward and backward movement
  * Left and right steering
* Rotating (spinning) wheels on all four tires using the provided tire model
* A predefined start point and finish area
* A timer that starts at the beginning of the race and stops upon reaching the finish
* Collision detection with track boundaries and obstacles
* A penalty system:

  * The car is pushed backward upon collision
  * The player has a total of 6 lives (collisions allowed)
* Camera system:

  * Third-person camera following the car
  * First-person camera toggle using the **C** key

---

## Optional Features

* Best time record display (high score system)
* Simple sound effects:

  * Engine sound
  * Collision sound
  * Background music
* A **3–2–1–Go** countdown at the start of the race

---

## Objective

Complete all 3 laps in the shortest time possible while staying on track and minimizing collisions.

## Illustration
<img width="1058" height="538" alt="image" src="https://github.com/user-attachments/assets/798182d7-3ed3-47b3-a3e9-c9dbc11caa8b" />



---
## Deliverables

The final submission must contain a complete and runnable Godot project with the following structure and elements.
- The project must open and run directly from `Level.tscn`, which is the main entry scene.
- The root project must contain exactly four main folders: Assets, Global, Scenes, and Scripts.
- The Assets folder contains the provided resources and must keep its internal organization (audios, fonts, sprites, icons). No external assets are allowed beyond the ones provided.
- The Global folder must contain a `global.gd` script used for shared variables such as score, laps, or persistent data.
- The Scenes folder must contain all `.tscn` scene files used in the project. This includes at minimum the Level scene and any UI or reusable object scenes (car, coin, etc.).
- The Scripts folder must contain all `.gd` scripts attached to scenes or nodes. Scripts must follow GDScript naming conventions (PascalCase for nodes, UPPERCASE for constants, snake_case for variables and functions).

## Submission
- link to itch.io deployed game, which should be named “groupname-godot-3d.”
- link to public GitHub repository, which should be named “Real-Time-3D-Godot-Game-Group-[X or Y]”

