var buffer = async_load[? "buffer"]
var msgId = buffer_read(buffer, buffer_u8)
switch(msgId)
{
    case 2: //tell the new player the amount of players already in game
        var newPlayer = buffer_read(buffer, buffer_u32);
        buffer_seek(global.buffer, buffer_seek_start, 0);
        buffer_write(global.buffer, buffer_u8, 3); //--- hey new player! this is the amount of players, add them to your game!
        buffer_write(global.buffer, buffer_u32, ds_list_size(global.players));
        network_send_packet(newPlayer, global.buffer, buffer_tell(global.buffer));
    break;
    
    case 6: //receive if pressed
        var pId = buffer_read(buffer, buffer_u32);
        var pressed = buffer_read(buffer, buffer_u32);
        with(oPlayer)
        {
            if (playerSocket == pId)
            {
                tapped = pressed;
            }
        }
    break;    
}
