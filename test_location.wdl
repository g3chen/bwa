workflow test_location {
	call find_tools
}

task find_tools {
	command {
#		echo $PATH
#		whereis samtools
#		whereis bwa
		echo $MANPATH
		echo "@@@@@@@@@@@@@@@@"
		echo $PYTHONPATH
		echo "@@@@@@@@@@@@@@@@"
		echo $LD_LIBRARY_PATH
	}
	output{
		String message = read_string(stdout())
	}
	runtime {
		docker: "g3chen/bwa:1.0"
#		docker: "mtaschuk-bwa:latest"
#		docker: "g3chen/mtaschuk-bwa:1.0"
	}
}
