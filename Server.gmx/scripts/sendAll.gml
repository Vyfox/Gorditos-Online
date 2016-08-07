for (var i = 0; i < ds_list_size(global.players); i++)
        {
        network_send_packet(i, global.buffer, buffer_tell(global.buffer))
        }
