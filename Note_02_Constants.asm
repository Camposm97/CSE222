.data
	

.text
	# Starting at the MSB, s0 = 0xFEDC0000
	lui $s0 0xFEDC	# In other words the first 4 bytes of s0 is FEDC
	
	# Starting at the LSB, s0 = 0x00008765
	ori $s0 $s0 0x8765 # In other words the last 4 bytes of s0 is 8765
	