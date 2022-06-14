# Robowars
Desktop macOS client for the Robowars game

# Launch Game Client Feature

🟢 - Implement some kind of validator which have to validate ships returned by robots according to a specified game mode:

     [✅] a. check that the count and size of ships returned is correct
     [✅] b. check that the ships placed on correct positions:
        [✅] 1. all ships are placed incide the battlefield
        [✅] 2. there are no collisions between ships positions

🟡 - Implement shooting logic

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