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
    
    case 7:
        var pId = buffer_read(buffer, buffer_u32);
        var myName = buffer_read(buffer, buffer_string);
        for (var i = 0; i < ds_list_size(global.players); i++)
        {
        var storedPlayerSocket = ds_list_find_value(global.players,i);
        buffer_seek(global.buffer, buffer_seek_start, 0);
        buffer_write(global.buffer, buffer_u8, 2); //msg id
        buffer_write(global.buffer, buffer_u32, pId); // write socket
        buffer_write(global.buffer, buffer_string, myName);//write name
        network_send_packet(storedPlayerSocket, global.buffer, buffer_tell(global.buffer)); //send packet
        }
    break;    
}
