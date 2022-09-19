# Robowars
Desktop macOS client for the Robowars game

[![CI](https://github.com/VMironiuk/Robowars/actions/workflows/CI.yml/badge.svg)](https://github.com/VMironiuk/Robowars/actions/workflows/CI.yml)

# Launch Game Client Feature

🟢 - Implement some kind of validator which have to validate ships returned by robots according to a specified game mode:

     [✅] a. check that the count and size of ships returned is correct
     [✅] b. check that the ships placed on correct positions:
        [✅] 1. all ships are placed incide the battlefield
        [✅] 2. there are no collisions between ships positions

🟢 - Integrate ships validation into the GameEngine

🟢 - Implement shooting logic

      [✅] Ask a robot for coordinate of shooting
      [✅] Send a robot the result of shooting

🟢 - Improve shooting logic

      [✅] Implement more real test cases
      [✅] Improve the code

🟢 - Add a delegate for GameEngine

      [✅] Emmit the `robot 1 did change` event
      [✅] Emmit the `robot 2 did change` event
      [✅] Emmit the `did fail` event in case of incorrect ships placement by any robot
      [✅] Emit the `robot 1 did shoot` event
      [✅] Emit the `robot 2 did shoot` event
      [✅] Emit the `robot 1 did win` event
      [✅] Emit the `robot 2 did win` event
      [✅] Emit the `robot 1 did lose` event
      [✅] Emit the `robot 2 did lose` event

🟢 - Emmit the `game mode did change` event

🟢 - Add memory leak test

🟢 - Do refactoring (system design mostlys)

🟢 - Setup CI

🟡 - Make a prototype app
      [-] Add 'Samples' panel
            [✅] Show/hide error message
            [✅] Start game
            [✅] In progress game
            [✅] Finished game
                  [✅] Show winner message
                  [✅] Set colors
                  [-] Set image (optional)
      [-] Battlefield colors
            [✅] Colors
            [-] Draw 'X' for hit shots
            [-] Draw 'O' for missed shots

## BDD Specs

### Story: User launches the game

### Narrative #1

```
As a user
I want to select robots, select the game mode and specify the shooting speed
So I can start the game and see the robots battle
```

#### Scenarios (Acceptance Criteria)
```
Given the user selects robots
  And the user selects the game mode
  And the user specifies the shooting speed
 When the user taps the start button
 Then the robots start fighting  
```

### Narrative #2

```
As a user
I can not start the game when there are no robots
So the start button have to be disabled
```

#### Scenarios (Acceptance Criteria)

```
Given the user selects the game mode
  And the user specifies the shooting speed
 When there are no robots
 Then the start button have to be disabled 
```

### Narrative #3

```
As a user
I can not start the game when there is no game mode
So the start button have to be disabled
```

#### Scenarios (Acceptance Criteria)

```
Given the user selects robots
  And the user specifies the shooting speed
 When there is no game mode
 Then the start button have to be disabled 
```

### Story: System is ready to the battle if it receives correct list of ships from a robot

### Narrative #4

```
When the system sends battlefield size and list of possible ships to a robot
Robot have to send back ships positions
The system checks whether ships placed correctly
```

#### Scenarios (Acceptance Criteria)

```
Given the system sends battlefield and list of possible ships to a rebot
 When battlefield and list of possible ships are not empty
 Then robot sends back to the system non empty list of ships
```

## Use Cases

### Launch the App

#### Data

* Robot #1
* Robot #2
* The Game Mode
* Shooting Speed

#### Primary Course (Happy Path)
1. Launch the app
2. Select Robot #1
3. Select Robot #2
4. Select the game mode
5. Specify the shooting speed
6. Tap the start button
7. The robots start fighting

### No Robots (Sad Path)
1. The start button have to be disabled
2. The app should show the no robots error message

### No Game Mode (Sad Path)
1. The start button have to be disabled
2. The app should show the no game mode error message

### Set the battlefield and the list of ships for a robot

#### Data

* Battlefiled
* List of possible ships

#### Primary Course (Happy Path)
1. Set non empty battlefield
2. Set non empty list of possible ships
3. System receives non empty list of ships
4. System checks whether the list of ships is correct

#### Empty battlefield (Sad Path)
1. Set an empty battlefield
2. Set non empty list of possible ships
3. System receives an empty list of ships

#### Empty list of ships (Sad Path)
1. Set non empty battlefield
2. Set an empty list of possible ships
3. System receives an empty list of ships

#### Empty battlefield and empty list of possible ships
1. Set an empty battlefield
2. Set an empty list of possible ships
3. System receives an empty list of ships
