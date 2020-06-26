workflow test_location {
    call find_tools
}

task find_tools {
    command <<<
        ls -l /data/HG19_BWA_INDEX_ROOT/hg19_random.fa
        echo "@@@@@@@@@@@@@"
    >>>
    output{
        String message = read_string(stdout())
    }
    runtime {
        docker: "g3chen/bwa@sha256:c1af8987388e5a02415982b4fd7ef11d691b95ba063130b159428307557005c7"
    }
}
