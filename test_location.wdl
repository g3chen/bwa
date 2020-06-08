workflow test_location {
	call find_tools
}

task find_tools {
	command {
		module avail
		whereis samtools
		whereis bwa
	}
	output{
		String message = read_string(stdout())
	}
	runtime {
		# docker: "g3chen/bwa:1.0"	# the container with .bashrc
		docker: "g3chen/bwa:1.1"	# the container with ENV
	}
}
