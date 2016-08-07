var socket = argument0;
var yo = socket;
for (var i = 0; i < ds_list_size(global.players); i++)
        {
            if (i != yo)
            {
            network_send_packet(i, global.buffer, buffer_tell(global.buffer));
            }
        }
