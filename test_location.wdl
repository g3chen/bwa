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
	runtime {
		docker: "g3chen/bwa:1.0"
	}
}
