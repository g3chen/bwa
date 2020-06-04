workflow test_location {
	call find_tools
}

task find_tools {
	command {
		whereis samtools
		whereis bwa
	}
	output{
		String message = read_string(stdout())
	}
}