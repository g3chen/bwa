workflow test_location {
    call find_tools
}

task find_tools {
    command {
        ls $SLICER_ROOT
        echo "@@@@@@@@@@@@@@@@"
        ls $HTSLIB_ROOT
        echo "@@@@@@@@@@@@@@@@"
        ls $PYTHON_ROOT
        echo "@@@@@@@@@@@@@@@@"
        ls $BWA_ROOT
        echo "@@@@@@@@@@@@@@@@"
        ls $CUTADAPT_ROOT
        echo "@@@@@@@@@@@@@@@@"
        ls $SAMTOOLS_ROOT
        echo "@@@@@@@@@@@@@@@@"

        echo $PATH
        echo "################"
        echo $MANPATH
        echo "################"
        echo $LD_LIBRARY_PATH
        echo "################"
        echo $PYTHONPATH
        echo "################"
        echo $PKG_CONFIG_PATH
        echo "################"
    }
    output{
        String message = read_string(stdout())
    }
    runtime {
        docker: "g3chen/bwa@sha256:c1af8987388e5a02415982b4fd7ef11d691b95ba063130b159428307557005c7"
        modules: "bwa/0.7.12 samtools/1.9 cutadapt/1.8.3 slicer/0.3.0"
    }
}
