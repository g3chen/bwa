version 1.0
workflow test_location {
input {
  File reference = "/home/ubuntu/Downloads/sample_data/hg19_random.fa"
  File read1 = "/home/ubuntu/repos/bwa/bwamem/input_data/PCSI0022C.val.1.fastq.gz"
  File read2 = "/home/ubuntu/repos/bwa/bwamem/input_data/PCSI0022C.val.2.fastq.gz"
}
  call find_tools {
    input:
      reference=reference,
      read1=read1,
      read2=read2
  } 
}
task find_tools {
input {
  File reference
  File read1
  File read2
}
        command <<<
                bwa mem -M ~{reference} ~{read1} ~{read2}
	>>>
        output{
                String message = read_string(stdout())
        }
        runtime {
                docker: "g3chen/bwa:1.0"
        }
}
