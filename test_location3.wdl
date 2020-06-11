version 1.0
workflow test_location {
input {
#  File reference = "/home/ubuntu/Downloads/sample_data/hg19_random.fa"
#  File referenceIndex = "/home/ubuntu/Downloads/sample_data/hg19_random.fa.fai"
#  File amb = "/home/ubuntu/Downloads/sample_data/hg19_random.fa.amb"
#  File ann = "/home/ubuntu/Downloads/sample_data/hg19_random.fa.ann"
#  File bwt = "/home/ubuntu/Downloads/sample_data/hg19_random.fa.bwt"
#  File pac = "/home/ubuntu/Downloads/sample_data/hg19_random.fa.pac"
#  File sa = "/home/ubuntu/Downloads/sample_data/hg19_random.fa.sa"
#  File read1 = "/home/ubuntu/repos/bwa/bwamem/input_data/PCSI0022C.val.1.fastq.gz"
#  File read2 = "/home/ubuntu/repos/bwa/bwamem/input_data/PCSI0022C.val.2.fastq.gz"
#  String readGroups = "@RG\\tID:121005_h804_0096_AD0V4NACXX-NoIndex_6\\tLB:PCSI0022C\\tPL:ILLUMINA\\tPU:121005_h804_0096_AD0V4NACXX-NoIndex_6\\tSM:PCSI0022C"
  String readGroups
}
  call find_tools {
    input:
      readGroups=readGroups
  } 
}
task find_tools {
input {
  String readGroups
}
        command <<<
               echo ~{readGroups}
#		echo "~{readGroups}"
        >>>
        output{
                String result = read_string(stdout())
#                File result = "out.bam"
        }
        runtime {
#                docker: "g3chen/bwa:1.0"
                docker: "ubuntu:latest"
        }
}
