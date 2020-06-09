workflow test_location {
	call find_tools
}

task find_tools {
	command {
#		echo $PATH
		samtools
#		whereis bwa
#		echo $MANPATH
#		echo "@@@@@@@@@@@@@@@@"
#		echo $PYTHONPATH
#		echo "@@@@@@@@@@@@@@@@"
#		echo $LD_LIBRARY_PATH
#		ls /modules/gsi/modulator/sw/Ubuntu18.04/htslib-1.9/lib
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
