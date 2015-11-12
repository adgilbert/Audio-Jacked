# r1 is 1 to compare with mic done and menu check
# r2 is 2 for menu check
# r3 holds cell ram data
# r4 is starting address of cellram
# r5 holds the starting address of cellram for playback
# r6 holds the menu value
# r7 holds the value of mic done. also used to increment the number of times gone without jumping 2 addressses or not storing
# r8 holds the mic data
# r10 holds number of times gone without storing
# r11 is 40 -the number of times to go without storing
# r12 is filter comparison
# r13 is for filler
# r14 is for leds
# r15 


and r1 zero
addi r1 1
addi r2 2 		#for menu check
addi r4 8388608 #cellram address for record
addi r5 8388608 #cellram address for playback
addi r11 40		# number of times to go without storing


firstmenu:		and r13 zero		# filler
				and r4 zero
				and r10 zero
				addi r4 8388608
				li r6 00001000		# check value of menus
				beq r6 r1 recording	# if the menu changes to 2 go to recording
				j firstmenu			# else check again

recording: 		and r13 zero
				li r8 00100000 			# get the value of the mic
				addi r10 1				#increment number of samples since last store
				beq r10 r11 store		# only store every 40th value
donestoring: 	and r13 zero			
				si r12 00100000			#r12 should be irrelevant. this is resetting mic_start
				li r6 00001000			# check value of menus
				beq r6 r2 playback  	# if the menu changes go to playback
hold: 			and r13 zero
				li r7 00100001 			# get the value of mic done
				beq r7 r1 recording
				j hold


store: 			and r13 zero
				sw r8 r4 			# store data
				lshi r8 -8 			# shift data
				si r8 00000100 		# update leds
				addi r4 1    		# increment address
				and r10 zero		# reset count
				j donestoring

playback: 		and r13 zero
				li r6 00001000			# get value of menu and filter
				and r12 zero			# set r12 to zero for first comparison
				beq r6 r12 firstmenu	# go back to first menu if menu is 0n
				addi r12 6				# set to 6 for next comparison
				beq r6 r12 filteruno	# if first filter go there
				addi r12 4				# set to 10 for next comparison
				beq r6 r12 filterdos	# go to second filter if true
				addi r12 4				# set to 14 for next comparison
				beq r6 r12 filtertres	# go to third filter if true
				addi r12 4				# set to 18 for next comparison
				beq r6 r12 filterquatro	# go to fourth filter if true
				and r14 zero			# reset leds
				addi r14 16				# set leds value
				si r14 00000100			# update leds
				j playback				# else do the checks again

filteruno:		and r13 zero			######NORMAL PLAYBACK#######
				beq r5 r4 reset 		# if r5 gets to the last value stored reset loop
				si r3 01000000			# load speaker buffer data to speaker output buffer sets spkr_updated
				lw r3 r5				# load cellram data into r3
				si r3 01001000			# load cellram data into speaker buffer this also resets spkr_updated
				addi r5 1				# update the current memory address
				lshi r3 -ç8 				# shift value over
				si r3 00000100			# update leds
doneuno:		and r13 zero
				li  r12 01000001		# get value of speaker update signal
 				beq r12 r1 filteruno	# get a new memory address for cellram
 				j doneuno

filterdos:		and r13 zero			######FAST PLAYBACK#######
				bge r5 r4 reset 		# if r5 gets to the last value stored reset loop and go to main menu
				addi r7 1 				# increment the number of times gone without jumping two addresses.
				si r3 01000000			# load speaker buffer data to speaker output buffer sets spkr_updated
				lw r3 r5				# load cellram data into r3
				si r3 01001000			# load cellram data into speaker buffer this also resets spkr_updated
				li r14 00000010 		# load the value of the switches
				and r6 zero				# load first comparison
				ori r6 207				# or so that only the values of the 3rd and 4th switches matter
				beq r14 r6 fivefourths	# if switches are at zero down increment by 5/4
				addi r6 16				# check if first switch is high
				beq r14 r6 threehalves	# if so increment by 3/2
				addi r6 32 				# add value of second switch
				beq r14 r6 fivehalves	# if second and first switch are high increment by 5/2
				addi r6 -16				# finally subtract first switch
				beq r14 r6 jumptwoaddr	# if only second switch is high then jump two addresses
finishedinc:	and r13 zero
				addi r5 1				# update the current memory address by 1 at least every time
				lshi r3 -8 				# test shift
				si r3 00000100			# update leds
donedos:		and r13 zero
				li  r12 01000001		# get value of speaker update signal
 				beq r12 r1 filterdos	# get a new memory address for cellram
 				j donedos

fivefourths:	and r13 zero
				and r6 zero
				addi r6 4				# set comparison amount to 4
				beq r6 r7 jumptwoaddr	# if we've gone four times without incrementing by 2 increment by two this time
				j finishedinc			# else go back to the main loop		

fivehalves: and r13 zero 
		and r6 zero
		addi r6 1			
		beq r6 r7 jumptwoaddr
		j jumpthreeaddr


threehalves: and r13 zero
		and r6 zero
		addi r6 2
		beq r6 r7 jumptwoaddr
		j finishedinc





jumptwoaddr: 	and r13 zero
				and r7 zero 			# reset counter
				addi r5 1 				# increment address an additional time
				j finishedinc

jumpthreeaddr: 	and r13 zero
				addi r5 2 				# increment address two additional times
				j finishedinc

filtertres:		and r13 zero			######SLOW PLAYBACK#######
				beq r5 r4 reset 		# if r5 gets to the last value stored reset loop
				si r3 01000000			# load speaker buffer data to speaker output buffer sets spkr_updated
				lw r3 r5				# load cellram data into r3
				si r3 01001000			# load cellram data into speaker buffer this also resets spkr_updated
				and r14 zero			# reset leds
				addi r14 2				# set leds value
				lshi r3 -8
				si r3 00000100			# update leds
donetres:		and r13 zero
				li  r12 01000001		# get value of speaker update signal
 				beq r12 r1 segundotres	# get a new memory address for cellram
 				j donetres

segundotres:	si r3 01000000			# load speaker buffer data to speaker output buffer sets spkr_updated
				lw r3 r5				# load cellram data into r3
				si r3 01001000			# load cellram data into speaker buffer this also resets spkr_updated
				addi r5 1				# update the current memory address
donetress:		and r13 zero
				li  r12 01000001		# get value of speaker update signal
 				beq r12 r1 filtertres	# get a new memory address for cellram
 				j donetress


 				
filterquatro:	and r13 zero			######BACKWARDS PLAYBACK#######
				and r8 zero				# reset r8
				add r8 r4				# set r8 to be r4
				and r5 zero
				addi r5 8388608			# set r5 to initial addresss
quatroplay:		and r13 zero
				beq r5 r8 reset 		# if r5 gets to the last value stored reset loop
				si r3 01000000			# load speaker buffer data to speaker output buffer sets spkr_updated
				lw r3 r8				# load cellram data into r3
				si r3 01001000			# load cellram data into speaker buffer this also resets spkr_updated
				addi r8 -1				# update the current memory address
				lshi r3 -8 				# shift LEDs
				si r3 00000100			# update leds
donequatro:		and r13 zero
				li  r12 01000001		# get value of speaker update signal
 				beq r12 r1 quatroplay	# get a new memory address for cellram
 				j donequatro

reset: 			and r13 zero
				and r5 zero
  				addi r5 8388608
  				j playback