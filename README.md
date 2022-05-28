# Robowars
Desktop macOS client for the Robowars game

# Launch Game Client Feature

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