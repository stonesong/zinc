protocol
runWith: block
	"Start a run loop handling the WebSocket protocol.
	When a message is received, block will be passed a String or ByteArray.
	ConnectionClosed will be signalled when the other end closes."
	
	[ | message |
		message := nil.
		[ message := self readMessage ] 
			on: ConnectionTimedOut 
			do: [ "Ignore & continue" self ping ].
		message ifNotNil: [
			block value: message ] ] repeat