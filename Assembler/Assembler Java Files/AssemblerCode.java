package assembler;

import java.util.LinkedList;
import java.util.Map;
import java.util.Scanner;

import java.util.TreeMap;



/*
 * AssemblerCode is two-pass and is made for custom processor
 *	
 * This class IS NOT the entry point of the program. 
 * 		"AssemblerMain" is the main entry point
 * 			- refer to it for program level comments
 *  
 */

public class AssemblerCode 
{
	//TODO: Still need to create machine code for jumps, branches, and these things: 8($t4)
	private static int lineNumber;
	private static String machineFileName;
	private static String opCodeForDebug = new String();
	private static Map<String, String> functions;
	private static Map<String, String> opCodes;
	private static Map<String, String> registers;
	private static Map<String, String> shifts;
	private static Map<String, String> branches;
	private static Map<String, String> special;
	private static Map<String, String> condition;
	private static LinkedList<LinkedLabel> labelList = new LinkedList<LinkedLabel>();

	
	/**
	 * Load in the Assembly Code file, get the 
	 */
	public String[] loadFile()
	{
		//Prompt user to input text file name in the Console 
		String[] files = new String[3];
		Scanner scanner = new Scanner(System.in);
		System.out.println("Enter the assembly code file name:");
		files[1] = scanner.nextLine() + ".txt";
		System.out.println("Enter the machine code file name:");
		files[0] = scanner.nextLine() + ".txt";					// save the name of the machine file we're writing to
		System.out.println("Enter the Hex representation file name:");
		files[2] = scanner.nextLine() + ".txt";
		return files;							// return the Assembly code file we're reading from
	}
	
	
	/**
	 * First pass through the Assembly Code .txt file
	 * 	Find and connect labels
	 */
	public void passOne(String line)
	{
		Scanner s = new Scanner(line);
		String word = "";
		boolean incLine = true;
		if (line.length()==0) // if there are no words, we won't increment line
			incLine = false;
		if (incLine)			// there are words, check if its just a comment
			if (line.charAt(0)=='#')
				incLine = false;		// the line was just a comment, don't increment
		// go through each string in the line
		while (s.hasNext() && incLine) // as long as there is valid information
		{
			word = s.next();
			
			//break out if its a comment
			if (word.charAt(0) == '#')
				break;
			
			// found a label; now add it to the list
			if (word.charAt(word.length()-1) == ':'){
				String[] temp = word.split(":");
				String label = temp[0];					// take off the colon and save the label
				LinkedLabel ll = new LinkedLabel(label, lineNumber);
				labelList.add(ll);
			}	
			
			// if it wasn't at the beginning of the line, its a link back to the label
			else if (hasLabel(word))
				labelList.get(labelFinder(word)).addLinkData(lineNumber); // if we found it, add the rest of the data and break
		}
		
		//System.out.println(line + " " + lineNumber);
			
		if (incLine)
			lineNumber(true);
	}
	
	public void debugLabels() {
		System.out.println("Label\t" + "Label Line\t" + "Link Line");
		for (int i = 0; i < labelList.size(); i++){
			System.out.println(labelList.get(i).label + "\t\t" + labelList.get(i).labelLine + "\t" + labelList.get(i).linkLine);
		}
	}
	
	

	/**
	 * returns whether or not the label list contains a label
	 */
	public boolean hasLabel(String label){
		// look through the labelSet to find the appropriate LinkedLabl
		for (int i = 0; i < labelList.size(); i++)
			if (labelList.get(i).label.equals(label))
				return true;
		
		return false;
	}

	
	/**
	 * Debugging method 
	 * 	prints labels
	 */
	public void printLabels(){
		System.out.println("\nLabels:");
		for (int i = 0; i < labelList.size(); i++){
			System.out.println(labelList.get(i).label);
		}
		System.out.println();
	}
	

	/**
	 * First pass through the Assembly Code .txt file
	 * 	Find and connect labels
	 */
	public String passTwo(String line)
	{
		String instruction = "";
		
		Scanner s = new Scanner(line);
		String word = "";
		
		if (s.hasNext()) word = s.next();		// the current word in the line will be held here
		else return instruction;
		if (word.charAt(0)=='#')
			return instruction;
		
		// go through each string in the line
		while (s.hasNext()){
			if (word.contains(":"))
				word = s.next();
			
			opCodeForDebug = word;
			
			// lw/sw
			if (word.equals("sw") || word.equals("lw")){
				String opCode = opCodes.get(word);
				String specialIns = special.get(word);
				word = s.next();							// store: reg holding value to store, load: reg holding value to load
				String regVal = regBinary(word);
				word = s.next();							// register holding memory address
				String regAdrs = regBinary(word);
				
				// create the machine code
				instruction = opCode;
				instruction += regVal;
				instruction += specialIns;
				instruction += regAdrs;
				instruction += filler(16);
				break;
			}
			
			// li/si 0110/0111 Rdest/Rsourc 24 bit binary address
			// li ra #jargon#
			if (word.equals("li") || word.equals("si")){
				String opCode = opCodes.get(word);
				word = s.next();							// store: reg holding value to store, load: reg holding value to load
				String regVal = regBinary(word);
				word = s.next();							// register holding memory address
				String imm = word;
				
				// create the machine code
				instruction = opCode;
				instruction += regVal;
				instruction += filler(8-imm.length());
				instruction += imm;
				instruction += filler(16);
				break;
			}
			
			//(R-TYPE)
			// R-TYPEs include Register ALU ops and Shifting
			// decide if its an ALU op      or        a shift
			if (functions.containsKey(word) || opCodes.get(word) == "1000"){
				
				// it's an ALU op - instruction output is: 
				//	$ty = $tx + $ty, or similar ALU op
				if (functions.containsKey(word)){
					String function = functions.get(word);	// get the function type and store the binary
					instruction = "0000";			// the opCode is 0
					word = s.next();				// the next word is dst reg and read reg 1
					instruction += regBinary(word);	// add the dst reg/read reg 1
					word = s.next();				// the next word is read reg 2
					instruction += function;		// time to put in that function
					instruction += regBinary(word);	// add in read reg 2
					instruction += "0000000000000000"; // filler - these bits aren't looked at
					break;
				}
				
				// it's a shift op
				// shift for immediate: lsh 10 $rdst
				// shift for reg amount:lsh $ramnt $rdst
				else if (opCodes.get(word) == "1000"){		// this is the opCode for Shift instructions
					String shift = shifts.get(word);		// save the shift opCode
					String shiftAmt = filler(16);			// immediate shift
					String srcReg = "";						// register containing number to shift
					String shiftReg = filler(4);			// register containing amount of shift
					word = s.next();						// register holding the value to shift
					srcReg = regBinary(word);
					word = s.next();						// next word is either shift immediate or reg
					
					// if its an immediate set shiftAmt (16 bits)
					if (isInteger(word) || word.contains("-")){
						shiftAmt = toSignedBinary(word, 16);// save the integer shift amount as a binary String
					}
					
					else shiftReg = regBinary(word);		// its a register; save it
					
					// put it all together
					instruction = "1000";	
					instruction += srcReg;
					instruction += shift;
					instruction += shiftReg;
					instruction += shiftAmt;
					break;
					
				}
				
			}
			
			// (I-TYPE) 
			// if the instruction type contains an opCode and isn't special or a branch
			boolean notSpecial = true;
			if (special.containsKey(word) || special.containsKey(Character.toString(word.charAt(0))))
				notSpecial = false;
			
			if(word.equals("subi"))
				notSpecial = true;
			
			if (opCodes.containsKey(word) && notSpecial && !branches.containsKey(word)){
				instruction += opCodes.get(word);	// add the binary opCode to the instruction
				
				// next is the register
				word = s.next();
				instruction += regBinary(word);
				
				// then it's the immediate 
				word = s.next();
				instruction += toSignedBinary(word, 24);
				break;
			}
			
			// (Special Instructions)			// case for sCond
			if (special.containsKey(word) || special.containsKey(Character.toString(word.charAt(0)))){
				
				// jump register instruction
				if (word.equals("jr")){
				 
					boolean jrReg = false;
				
					if (s.hasNext()){
						jrReg = true;
						word = s.next();
					}
					
					if (jrReg && word.charAt(0) == 'r')
						instruction = "0100" + "0000" + "1100" +  "0011" + regBinary(word) + filler(12);
					else instruction = "0100" + "0000" + "1100" +  "0011" + "1111" + filler(12);
					break;
				}
				
				// statement for "jump" and "jump and link" 
				if (word.equals("j") || word.equals("jal")){
					String opCode = opCodes.get(word);
					String jType = special.get(word);									// either jump or jump & link
					String cond = "";
					if (condition.containsKey(word.substring(1)))
						cond = condition.get(word.substring(1));
					else cond = "1111";
					word = s.next(); 													// next is the label to jump to
					Integer lineNum = labelList.get(labelFinder(word)).labelLine-1;		// find the line number of the label
					String imm = toSignedBinary(lineNum.toString(), 12);
					
					// put it together
					instruction = opCode;
					instruction += filler(4); // filler
					instruction += jType;  // the jump type
					instruction += filler(4); // filler
					instruction += cond;
					instruction += imm;
					break;
				}
				
				// set conditional
				if (word.charAt(0) == 's'){
					String opCode = opCodes.get(word);
					String spec =   special.get("s");
					String condish = word.substring(1).trim();
					String cond =   condition.get(condish);
					word = s.next();	// next word is the register
					String reg = regBinary(word);
					
					// put it together
					instruction =  opCode;
					instruction += reg;
					instruction += spec;
					instruction += filler(4);
					instruction += cond;
					instruction += filler(12);
					break;
				}
				
			}
			
			// (Branch Types)
			if (branches.containsKey(word)){
				String opCode = opCodes.get(word);		// add the opCode
				String bType = branches.get(word);		// get the branch type
				word = s.next();						// next word is a register
				String r1 = regBinary(word);			// store the register
				word = s.next();						// next word is another register for comparison
				String r2 = regBinary(word);			// store the register
				word = s.next();						// load in the destination label
				
				// get the line number of the LABEL and SUBTRACT the line number of the (LINK + 1) <- for processor offset
				int labelLine = labelList.get(labelFinder(word)).labelLine;
				//int linkLine = labelList.get(labelFinder(word)).linkLine;
				Integer offset = labelLine - (lineNumber + 2); 
				String binOffset = toSignedBinary(offset.toString(), 16); 
				instruction = opCode;
				instruction += r1;
				instruction += bType;
				instruction += r2;
				instruction += binOffset;
				break;
			}
			
			else {
				instruction = "INSTRUCTION NOT FOUND";
				System.out.println("INSTRUCTION NOT FOUND");
				break;
			}
		}	// end of while loop
		
		System.out.println(lineNumber + "\t" + line); // for debugging
		lineNumber(true);	// increment the line number (program starts at "line 0")
		
		if (instruction.contains("null"))
			System.out.println("\nInstruction contains null: " + line + "\n" + instruction + "\n");
		
		if (instruction.length()==32 || instruction.equals("") || instruction.equals("INSTRUCTION NOT FOUND")){
			return instruction;
		}
				
			
		// for debugging, tell me if I didn't write a full instruction and where
		else return "*****************\nInstruction was not 32 bits. \nInstruction: -" + instruction + "-" + 	// print instruction
					"\nInstruction length: " + instruction.length() +						// instruction length
					"\nOpcode: "+ opCodeForDebug + 											// opCode
					"\nLine number: " + lineNumber + "\n*****************";											// and line Number
	}
	
	
	/**
	 * Returns binary String rep of a register
	 */
	public static String regBinary(String register){
		//System.out.println("regBinary: " + register);
		// if its a special register
		if (registers.containsKey(register))
			return registers.get(register);
			
		// if its a numbered register (it wasn't in the registers list)
		else {
			String[] split = register.split("r");	// split the String to separate the number
			String split1 = split[1];
			return toSignedBinary(split[1], 4);		// add the register number - substring is to ensure 4 unsigned bits
		}
	}
	
	
	/**
	 * Returns binary String representation found from Register String
	 * @param number - the String rep. of a number to convert
	 * 		  bitNum - the number of bits we would like the binary 
	 * 				   	to be represented in
	 * @return - the binary representation as a String
	 */
	public static String toSignedBinary(String number, int bitNum)
	{
		//TODO: finish toSigned Binary: needs bitNum and signed
		
		// case for positive numbers
		if (number.charAt(0)!='-'){
			int integer = Integer.parseInt(number);			// convert the String to an integer
			String rep =  Integer.toBinaryString(integer);	// convert the integer to a binary String representation
			if (rep.length() == bitNum)						// check for right length
				return rep;
			else{
				int bitsToAppend = bitNum - rep.length();		
				if (bitsToAppend < 0)			
					return null;							// the number was out of range, throw a phatty null
				String append = "";
				for (int i = 0; i < bitsToAppend; i++){		// create a String of the number of zeros to append 
					append += "0";
				}
				return append+rep;
			}
		}
		
		// case for negative numbers
		else{
			String[] split = number.split("-");
			int integer = Integer.parseInt(split[1]);
			String rep = Integer.toBinaryString(integer*-1);
			return rep.substring(rep.length()-bitNum);			// negative numbers are returned as 32 bits,
																//	shorten it to the appropriate number of bits
		}
	}
	
	
	/**
	 * Either increments or resets the line number. 
	 * 	Used to handle lineNumber variable through multiple classes
	 * @param incOrReset
	 */
	public void lineNumber(boolean incOrReset){
		if (incOrReset)
			lineNumber++;
		else lineNumber = 0;
	}
	
	
	/**
	 * Makes a filler with param number of zeros
	 */
	public String filler(int zeros){
		String filler = "";
		
		for (int i = 0; i < zeros; i++)
			filler += "0";
		
		return filler;
	}
	
	/**
	 * returns position in LinkedList of LinkedLabel
	 * 	@param label - the label we're looking for
	 * 	@return i - the index of the label
	 * 	@return null if the label is not found (should never happen)
	 */
	@SuppressWarnings("null")
	public static int labelFinder(String label){
		
		// look through the list. When we find the label, return the index of it
		for (int i = 0; i < labelList.size(); i++){
			if (labelList.get(i).label.equals(label))
				return i;
		}
		
		return (Integer) null;
	}
	
	/**
	 * Determines whether a string is an integer
	 * @param input
	 * @return
	 */
	public static boolean isInteger( String input ) {
	    try {
	        Integer.parseInt( input );
	        return true;
	    }
	    catch( Exception e ) {
	        return false;
	    }
	}
	
	/**
	 * Builds the tables 
	 */
	@SuppressWarnings("unchecked")
	public void buildTables()
	{
		branches  = new TreeMap<String, String>();	 // list of branch instructions 
		functions = new TreeMap<String, String>();	 // table for R-TYPE operations - instruction[5:0]
		opCodes   = new TreeMap<String, String>();	 // table for I-TYPE (among other) ops - instruction[31:26]
		registers = new TreeMap<String, String>(); 	 // table for registers
		shifts 	  = new TreeMap<String, String>();	 // table for shift types
		special   = new TreeMap<String, String>();	 // table of special types
		condition = new TreeMap<String, String>();	// table of conditions (only 'lt' right now)
		
		// add the branches to look for 
		branches.put("beq", "0000");	// branch if equal
		branches.put("bne", "0001");	// branch if not equal
		branches.put("blt", "0010");	// branch if less than
		branches.put("bgt", "0011");	// branch if greater than
		branches.put("ble", "0100");	// branch if less than or equal to
		branches.put("bge", "0101");	// branch if greater than or equal to
		branches.put("blz", "0110");	// branch if less than or equal to zero
		branches.put("bgz", "0111");	// branch if greater than or equal to zero
		
		// Special types
		special.put("j",   "1001");	// jump
		special.put("jr",  "1100");	// jump register
		special.put("jal", "1000");	// jump and link
		special.put("lw",  "0000");	// load word
		special.put("sw",  "0100");	// store word
		special.put("li",  "0110");	// load immediate
		special.put("si",  "0111");	// store immediate
		special.put("s",   "1101");	// set conditional
		
		// Conditions (SCond) 
		condition.put("eq", "0000");
		condition.put("ne", "0001");
		condition.put("gt", "0110");
		condition.put("le", "0111");
		condition.put("lt", "1100");
		condition.put("ge", "1101");
		
		// Shift types
		shifts.put("lshi", "0000");	// logical shift immediate
		shifts.put("lsh",  "0100"); // logical shift 
		shifts.put("ashui","0010"); // arithmetic shift immediate
		shifts.put("ashu", "0110"); // arithmetic shift 
		
		// add in the functions
		functions.put("add",  "0101");
		functions.put("addu", "0110");
		functions.put("addc", "0111");
		functions.put("sub",  "1001");
		functions.put("subc", "1010");
		functions.put("xor",  "0011");
		functions.put("and",  "0001");
		functions.put("or",   "0010");
		functions.put("mul",  "1110");
		functions.put("wait", "0000");
		functions.put("cmp",  "1011");
		
		// add in the opCodes
		opCodes.put("addi", "0101");
		opCodes.put("muli", "1110");
		opCodes.put("subi", "1001");
		opCodes.put("subci","1010");
		opCodes.put("cmpi", "1011");
		opCodes.put("andi", "0001");
		opCodes.put("ori",  "0010");
		opCodes.put("xori", "0011");
		opCodes.put("movi", "1101");
		opCodes.put("lshi", "1000");
		opCodes.put("lsh",  "1000");
		opCodes.put("ashui","1000");
		opCodes.put("ashu", "1000");
		opCodes.put("lui",  "1111");
		opCodes.put("lw",   "0100");
		opCodes.put("sw",   "0100");
		opCodes.put("li",   "0110");
		opCodes.put("si",   "0111");
		opCodes.put("j",    "0100");
		opCodes.put("jal",  "0100");
		opCodes.put("jr",   "0100");
		opCodes.put("slt",  "0100");
		opCodes.put("beq",  "1100");	// branch if equal
		opCodes.put("bne",  "1100");	// branch if not equal
		opCodes.put("blt",  "1100");	// branch if less than
		opCodes.put("bgt",  "1100");	// branch if greater than
		opCodes.put("ble",  "1100");	// branch if less than or equal to
		opCodes.put("bge",  "1100");	// branch if greater than or equal to
		opCodes.put("blz",  "1100");	// branch if less than or equal to zero
		opCodes.put("bgz",  "1100");
		
		// add in the special registers
		registers.put("zero", "0000");	// zero register hold value 0
		registers.put("ra",   "1111");	// register 15 holds return address
		registers.put("sp",   "1110"); // register 14 holds stack pointer
		registers.put("fp",   "1101"); // register 13 holds frame pointer
	}
	
	
	/**
	 * Converts signed bytes to unsigned bytes
	 * 	(may be useful)
	 * @param b - the signed byte
	 * @return the unsigned byte representation
	 */
	public static int unsignedToBytes(byte b) 
	{
		return b & 0xFF;
	}
	
	
	/**
	 * Class to hold links between labels
	 * @author tombo
	 *
	 */
    public class LinkedLabel
    {
        private String label;
        private int labelLine;
        private int linkLine;
        
        /**
         * Builds this node to contain the specified data.  By default, this
         * node does not point to any other nodes (next is null), although it
         * is expected that 'next' may change.  
         * 
         * Also note, the data variable is final, the data reference cannot be 
         * changed.  (This fact is largely irrelevant.)
         * 
         * @param data   the data to store in the node
         */
        LinkedLabel (String label, int line)
        {
            this.label = label;
            this.labelLine = line;
        }
        
        
        /**
         * Constructor
         * @param instruct - the instruction
         * @param lineNum  - the line number the instruction occurs at in the file
         */
        private void addLinkData(int lineNum){
        	this.linkLine = lineNum;
        	
        }
    }
}

