# parameterball
Pong in the style of https://xkcd.com/2852/ 
Check the releases tab to download. Gameplay video:

https://www.youtube.com/watch?v=BkxMmVFGnv4

Every time someone wins/looses, some parameters of the game change. The parameters that currently change are:
```
COURT_HEIGHT
COURT_WIDTH
BALL_SIZE
BALL_SPEED
PAD_LENGTH
PAD_SPEED
GRAVITY_X
GRAVITY_Y
```

I just did this as a fun hour-long game jam, and am unlikely to make further changes. However it someone wants to make PR's, I'll happily review/approve/give-moderator-permissions. I don't think it would take too much to make this into a pretty fun little game. 


## Tech Notes
Built in Godot 4 based on the tutorial for pong ( https://docs.godotengine.org/en/2.1/learning/step_by_step/simple_2d_game.html ) but ... *parameterized*. 

Yeah, the ball collisions are mostly done based on the center of the sprite, so it's a bit weird with a super-big-ball. Fixing that would take more than my one-hour time slot this evening.
