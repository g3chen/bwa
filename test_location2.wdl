version 1.0
workflow test_location {
input {
  File reference = "/home/ubuntu/Downloads/sample_data/hg19_random.fa"
  File referenceIndex = "/home/ubuntu/Downloads/sample_data/hg19_random.fa.fai"
  File amb = "/home/ubuntu/Downloads/sample_data/hg19_random.fa.amb"
  File ann = "/home/ubuntu/Downloads/sample_data/hg19_random.fa.ann"
  File bwt = "/home/ubuntu/Downloads/sample_data/hg19_random.fa.bwt"
  File pac = "/home/ubuntu/Downloads/sample_data/hg19_random.fa.pac"
  File sa = "/home/ubuntu/Downloads/sample_data/hg19_random.fa.sa"
  File read1 = "/home/ubuntu/repos/bwa/bwamem/input_data/PCSI0022C.val.1.fastq.gz"
  File read2 = "/home/ubuntu/repos/bwa/bwamem/input_data/PCSI0022C.val.2.fastq.gz"
}
  call find_tools {
    input:
      reference=reference,
      referenceIndex=referenceIndex,
      amb=amb,
      ann=ann,
      bwt=bwt,
      pac=pac,
      sa=sa,
      read1=read1,
      read2=read2
  } 
}
task find_tools {
input {
  File reference
  File referenceIndex
  File amb
  File ann
  File bwt
  File pac
  File sa
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
