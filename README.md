# Coordinator
Architectural example of using a coordinator

## Description

1. Conceptually, the application can be represented as a directed graph, where
-the vertices of the graph are screens (`Main folder`,` Loader folder`) and 
-the edges are unidirectional transitions between screens (`PresentTransition.swift`,` DismissTransition.swift`, `PushTransition.swift`,` PopTransition.swift`).

2. `Coordinator.swift` controls the graph (transitions from screen to screen).

3. The screen (folder with three files), consists of two layers (for example of the main screen - `Main folder`)
-Business layer (`MainInteractor.swift`)
-Presentation layer (`MainViewController.swift`)

4. The business layer of the screen contains:
-Transition - `showTransition` (optional second transition -` hideTransition`)
-Optional presentation layer of the screen (`viewController`, closed by protocol)
-Weak link to the coordinator (`delegate`)
-All screen business logic

5. The presentation layer of the screen contains:
-Weak link to the interactor (`delegate`)
-All screen ui logic

6. The coordinator contains screen interactors (optionally, other coordinators)
For example, `Coordinator -> MainInteractor -> MainViewController`
Or `Coordinator -> LoaderInteractor -> LoaderViewController`

7. Responsibilities of the coordinator (`Coordinator.swift`):
-Show, hide screens (manage transition graph)
-Share data between screens (provide interaction between screens)

8. Builds (all classes with the suffix `Builder`) - provide assembly of interactors and coordinators.
The assembly includes two steps: instantiation and linking.

## Features

One of the implementations of pure architecture, with a clear division of responsibilities, allows you to:
- reuse screens (each screen is a completed module with an interaction interface)
- change the sequence of screens (changes are made only in the coordinator)
- change the way of switching between screens (a new / existing `Transition` is added / changed)
- expand functionality (adding new screens and coordinators does not affect the existing code base)

## Supported Platforms

- iOS

## Screenshots
![coordinator](https://user-images.githubusercontent.com/27812408/69920016-33808f00-1494-11ea-9607-cc56603bcbcd.gif)
