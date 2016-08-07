var buffer = async_load[? "buffer"];
var msgId = buffer_read(buffer, buffer_u8);
switch(msgId)
{
    case 0: //... so.. this is my sockt in the server side
        var mySocket = buffer_read(buffer, buffer_u32);
        oLocalPlayer.localPlayerSocket = mySocket;
        
        buffer_seek(global.buffer, buffer_seek_start, 0);
        buffer_write(global.buffer, buffer_u8, 2); //<<<<<<<---------- hey server! tell me about players already in game!
        buffer_write(global.buffer, buffer_u32, oLocalPlayer.localPlayerSocket);
        network_send_packet(clientSocket, global.buffer, buffer_tell(global.buffer));
    break;
    
    case 1: // <<<<<<--------------------------------------------- add the new player!
    var newPlayerSocket = buffer_read(buffer, buffer_u32);
        if (newPlayerSocket != oLocalPlayer.localPlayerSocket)
        {
            if (!instance_exists(oOther))
            {
                with(instance_create(oLocalPlayer.x,oLocalPlayer.y+32, oOther))
                {
                    otherPlayerSocket = newPlayerSocket;
                }
            }
            else if (instance_exists(oOther))
            {
                with(oOther)
                {
                    if (otherPlayerSocket != newPlayerSocket)
                    {
                        with(instance_create(oLocalPlayer.x,oLocalPlayer.y+32, oOther))
                        {
                            otherPlayerSocket = newPlayerSocket;
                        }
                    }
                }
            }
        }
    break;
    
    case 3: // time to add the players already in game
        var amountOfPlayers = buffer_read(buffer, buffer_u32);
        //show_message("players:"+string(amountOfPlayers));
        for (var i = 1; i < amountOfPlayers; i++)
        {
            if (i != oLocalPlayer.localPlayerSocket)
            {
                with(instance_create(oLocalPlayer.x,oLocalPlayer.y+32, oOther))
                {
                    otherPlayerSocket = i;
                }
            }
        }
    break;
    
    case 4: // time to delete the player who left
        var playerToDelete = buffer_read(buffer, buffer_u32);
        //show_message(string(oLocalPlayer.localPlayerSocket)+"says: delete the player socket "+string(playerToDelete));
        with(oOther)
        {
            if (otherPlayerSocket == playerToDelete)
            {
                instance_destroy();
            }
        }
    break;
    
    case 5: //receive position and rotation
        var pId = buffer_read(buffer, buffer_u32);
        var xx = buffer_read(buffer, buffer_u32);
        var yy = buffer_read(buffer, buffer_u32);
        var rot = buffer_read(buffer, buffer_s32);
        with(oLocalPlayer)
        {
            if (localPlayerSocket == pId)
            {
                phy_position_x = xx;
                phy_position_y = yy;
                phy_rotation = rot;
            }
        }
        with(oOther)
        {
            if (otherPlayerSocket == pId)
            {
                phy_position_x = xx;
                phy_position_y = yy;
                phy_rotation = rot;
            }
        }
    break;
    
    case 6: //player explode or dies
        var pId = buffer_read(buffer, buffer_u32);
        var vida = buffer_read(buffer, buffer_u32);
        with(oLocalPlayer)
        {
            if (localPlayerSocket == pId)
            {
                vivo = vida;
            }
        }
        with(oOther)
        {
            if (otherPlayerSocket == pId)
            {
                vivo = vida;
            }
        }
    break;
}
