workflow test_location {
	call find_tools
}

task find_tools {
	command {
#		echo $PATH
#		samtools
#		whereis bwa
#		echo $MANPATH
#		echo "@@@@@@@@@@@@@@@@"
#		echo $PYTHONPATH
#		echo "@@@@@@@@@@@@@@@@"
#		echo $LD_LIBRARY_PATH
#		ls /modules/gsi/modulator/sw/Ubuntu18.04/htslib-1.9/lib
	
		bwa mem -M /home/ubuntu/Downloads/sample_data/hg19_random.fa /home/ubuntu/repos/bwa/bwamem/input_data/PCSI0022C.val.1.fastq.gz /home/ubuntu/repos/bwa/bwamem/input_data/PCSI0022C.val.2.fastq.gz
# | samtools sort -O bam -T /tmp/ -o out.bam
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
