{
  "defaults": {
    "description": "BwaMem workflow test",
    "metrics_calculate": "calculate.sh",
    "metrics_compare": "compare.sh",
    "output_metrics_dir": "bwamem/2.0/output_metrics",
    "parameters": {
          "wdl_options": {
            "write_to_cache": false,
            "read_from_cache": false
           }
         }
  },

    "tests": [
       {
            "id": "PCSI0022C_notrim_nosplit_bam",
            "description": "Runs the small PCSI_0022 C data without trimming, without splitting, and outputs as BAM.",
            "parameters": {
              "wdl_inputs": {
                "bwaMem.fastqR1": "bwamem/input_data/PCSI0022C.val.1.fastq.gz",
                "bwaMem.fastqR2": "bwamem/input_data/PCSI0022C.val.2.fastq.gz",
                "bwaMem.outputFileNamePrefix": "121005_h804_0096_AD0V4NACXX_PCSI0022C_NoIndex_L006_001",
                "bwaMem.readGroups": "'@RG\\tID:121005_h804_0096_AD0V4NACXX-NoIndex_6\\tLB:PCSI0022C\\tPL:ILLUMINA\\tPU:121005_h804_0096_AD0V4NACXX-NoIndex_6\\tSM:PCSI0022C'",
                "bwaMem.runBwaMem.modules": "samtools/1.9 bwa/0.7.12 hg19-bwa-index/0.7.12",
                "bwaMem.runBwaMem.bwaRef": "$HG19_BWA_INDEX_ROOT/hg19_random.fa"
              }
            }
        },      
        {
            "id": "PCSI0022C_trim_nosplit_bam",
            "description": "Runs the small PCSI_0022 C data with trimming, without splitting, and outputs as BAM.",
            "parameters": {
              "wdl_inputs": {
                "bwaMem.fastqR1": "bwamem/input_data/PCSI0022C.val.1.fastq.gz",
                "bwaMem.fastqR2": "bwamem/input_data/PCSI0022C.val.2.fastq.gz",
                "bwaMem.doTrim": "true",
                "bwaMem.outputFileNamePrefix": "121005_h804_0096_AD0V4NACXX_PCSI0022C_NoIndex_L006_001",
                "bwaMem.readGroups": "'@RG\\tID:121005_h804_0096_AD0V4NACXX-NoIndex_6\\tLB:PCSI0022C\\tPL:ILLUMINA\\tPU:121005_h804_0096_AD0V4NACXX-NoIndex_6\\tSM:PCSI0022C'",
                "bwaMem.runBwaMem.modules": "samtools/1.9 bwa/0.7.12 hg19-bwa-index/0.7.12",
                "bwaMem.runBwaMem.bwaRef": "$HG19_BWA_INDEX_ROOT/hg19_random.fa"
              }
            }
        },
        
        {
            "id": "PCSI0022C_trim_split_hg19_bam",
            "description": "Runs the small PCSI_0022 C data with trimming, with splitting, and outputs as BAM.",
            "parameters": {
              "wdl_inputs": {
                "bwaMem.fastqR1": "bwamem/input_data/PCSI0022C.val.1.fastq.gz",
                "bwaMem.fastqR2": "bwamem/input_data/PCSI0022C.val.2.fastq.gz",
                "bwaMem.doTrim": "true",
                "bwaMem.numChunk": 4,
                "bwaMem.outputFileNamePrefix": "121005_h804_0096_AD0V4NACXX_PCSI0022C_NoIndex_L006_001",
                "bwaMem.readGroups": "'@RG\\tID:121005_h804_0096_AD0V4NACXX-NoIndex_6\\tLB:PCSI0022C\\tPL:ILLUMINA\\tPU:121005_h804_0096_AD0V4NACXX-NoIndex_6\\tSM:PCSI0022C'",
                "bwaMem.runBwaMem.modules": "samtools/1.9 bwa/0.7.12 hg19-bwa-index/0.7.12",
                "bwaMem.runBwaMem.bwaRef": "$HG19_BWA_INDEX_ROOT/hg19_random.fa"

              }
            }
        },
        {
            "id": "PCSI0022C_notrim_split_hg19_bam",
            "description": "Runs the small PCSI_0022 C data without trimming, with splitting, and outputs as BAM.",
            "parameters": {
              "wdl_inputs": {
                "bwaMem.fastqR1": "bwamem/input_data/PCSI0022C.val.1.fastq.gz",
                "bwaMem.fastqR2": "bwamem/input_data/PCSI0022C.val.2.fastq.gz",
                "bwaMem.doTrim": "false",
                "bwaMem.numChunk": 4,
                "bwaMem.outputFileNamePrefix": "121005_h804_0096_AD0V4NACXX_PCSI0022C_NoIndex_L006_001",
                "bwaMem.readGroups": "'@RG\\tID:121005_h804_0096_AD0V4NACXX-NoIndex_6\\tLB:PCSI0022C\\tPL:ILLUMINA\\tPU:121005_h804_0096_AD0V4NACXX-NoIndex_6\\tSM:PCSI0022C'",
                "bwaMem.runBwaMem.modules": "samtools/1.9 bwa/0.7.12 hg19-bwa-index/0.7.12",
                "bwaMem.runBwaMem.bwaRef": "$HG19_BWA_INDEX_ROOT/hg19_random.fa"  
              }
            }
        },
        {
            "id": "PCSI0022C_trim_split_hg38_bam",
            "description": "Runs the small PCSI_0022 C data with trimming, with splitting, with hg38, and outputs as BAM.",
            "parameters": {
              "wdl_inputs": {
                "bwaMem.fastqR1": "bwamem/input_data/PCSI0022C.val.1.fastq.gz",
                "bwaMem.fastqR2": "bwamem/input_data/PCSI0022C.val.2.fastq.gz",
                "bwaMem.doTrim": "true",
                "bwaMem.numChunk": 4,
                "bwaMem.outputFileNamePrefix": "121005_h804_0096_AD0V4NACXX_PCSI0022C_NoIndex_L006_001",
                "bwaMem.readGroups": "'@RG\\tID:121005_h804_0096_AD0V4NACXX-NoIndex_6\\tLB:PCSI0022C\\tPL:ILLUMINA\\tPU:121005_h804_0096_AD0V4NACXX-NoIndex_6\\tSM:PCSI0022C'",
                "bwaMem.runBwaMem.modules": "samtools/1.9 bwa/0.7.12 hg38-bwa-index/0.7.12",
                "bwaMem.runBwaMem.bwaRef": "$HG38_BWA_INDEX_ROOT//hg38_random.fa"
              }
            }
        }       
    ]
}


