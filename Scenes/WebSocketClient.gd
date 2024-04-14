extends Node

var socket = WebSocketPeer.new()
var last_state = WebSocketPeer.STATE_CLOSED

signal connected_to_server()
signal connection_close()
signal message_recieved(message : Variant)

## Function that searches for a new message
func poll() : 
	## If its not ready poll again
	if socket.get_ready_state() != socket.STATE_CLOSED:
		socket.poll()
	
	## Gets the state
	var state = socket.get_reay_state()
	
	## Update the last_state if it`s different
	if last_state != state:
		last_state = state
		
		## If socket is open connect to the server
		if state == socket.STATE_OPEN:
			connected_to_server.emit()
			
		## If socket is closed close connection to the server
		elif state == socket.STATE_CLOSED:
			connection_close.emit()
	
	## Making sure socket is open and has packet to read
	while socket.get_ready_state() == socket.STATE_OPEN and socket.get_available_packet_count():
		message_recieved.emit(get_message())
	
## Function that return the message	
func get_message() -> Variant :
	## Fail safe double check on packet count
	if socket.get_available_packet_count() < 1:
		return null
	## Checkint if it`s a string packet
	if socket.was_string_packet():
		## Returning formatted string packet
		return socket.get_packet().get_string_from_utf8()
	
	## Returning formatted packet	
	return bytes_to_var(socket.get_packet())
	
## Function that sends strings messages to the other connection	
func send(message) -> int:
	## If it`s string send it
	if typeof(message) == TYPE_STRING:
			return socket.send_text(message)
	
	## If it`s not string turn it to string
	return socket.send(var_to_bytes(message))
	
## Function that connects to another connection	
func connect_to_url(url) -> int:
	pass

## Function that closes connection with another url
func close(code := 1000, reason := "") :
	pass
	
func clear():
	print("cleared")

func get_socket() -> WebSocketPeer:
	pass  




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	poll()
