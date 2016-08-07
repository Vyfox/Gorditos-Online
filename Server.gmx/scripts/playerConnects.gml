var socket = async_load[? "socket"];
global.lastPlayerId++;
ds_list_add(global.players, socket);
with(instance_create(oDoor.x,oDoor.y,oPlayer))
{
playerId = global.lastPlayerId;
playerSocket = socket;
}
//tell the one who conected the socket it has
buffer_seek(global.buffer, buffer_seek_start, 0);
buffer_write(global.buffer, buffer_u8, 0); // <<<<<<------------ hey ppl! add the new player! 
buffer_write(global.buffer, buffer_u32, socket);
sendSelf(socket);


//tell players in game to add the new player
for (var i = 0; i < ds_list_size(global.players); i++)
    {
    var storedPlayerSocket = ds_list_find_value(global.players,i);
                buffer_seek(global.buffer, buffer_seek_start, 0);
                buffer_write(global.buffer, buffer_u8, 1); // <<<<<<------------ hey ppl! add the new player! 
                buffer_write(global.buffer, buffer_u32, socket);
                network_send_packet(storedPlayerSocket, global.buffer, buffer_tell(global.buffer));
    }
    
