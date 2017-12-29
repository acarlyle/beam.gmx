///handle_playerMove

print("handle player move");

if (key_left && !scr_collisionCheck(global.playerX - 16, global.playerY)){
    global.playerX -= 16;
    moved = true;
}
if (key_right && !scr_collisionCheck(global.playerX + 16, global.playerY)){
    global.playerX += 16;
    moved = true;
}
if (key_up && !scr_collisionCheck(global.playerX, global.playerY - 16)){
    global.playerY -= 16;
    moved = true;
}
if (key_down && !scr_collisionCheck(global.playerX, global.playerY + 16)){
    global.playerY += 16;
    moved = true;
}
if (key_upleft && !scr_collisionCheck(global.playerX - 16, global.playerY - 16)){
    global.playerX -= 16;
    global.playerY -= 16;
    moved = true;
}
if (key_upright && !scr_collisionCheck(global.playerX + 16, global.playerY - 16)){
    global.playerX += 16;
    global.playerY -= 16;
    moved = true;
}
if (key_downleft && !scr_collisionCheck(global.playerX - 16, global.playerY + 16)){
    global.playerX -= 16;
    global.playerY += 16;
    moved = true;
}
if (key_downright && !scr_collisionCheck(global.playerX + 16, global.playerY + 16)){
    global.playerX += 16;
    global.playerY += 16;
    moved = true;
}

if (moved){ 
    global.oldPlayerX = x;
    global.oldPlayerY = y;
    x = global.playerX; 
    y = global.playerY; 
    ds_stack_push(obj_player.moveHistory, string(x) + "," + string(y))
}

move = false;
