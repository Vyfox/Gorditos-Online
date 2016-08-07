var socket = async_load[? "socket"];
var kick = ds_list_find_index(global.players, socket);
for (var i = 0; i < ds_list_size(global.players); i++)
{
var storedPlayerSocket = ds_list_find_value(global.players,i)
    buffer_seek(global.buffer, buffer_seek_start, 0);
    buffer_write(global.buffer, buffer_u8, 4); // <<<<<<------------ hey ppl! delete the player who left! 
    buffer_write(global.buffer, buffer_u32, socket);
    network_send_packet(storedPlayerSocket, global.buffer, buffer_tell(global.buffer))
}
if kick != -1
{
    with(oPlayer)
    {
        if (playerSocket == socket)
        {
            instance_destroy();
        }
}
ds_list_delete(global.players, kick);
}
