$HOSTNAME = ""
params.outdir = 'results'  


if (!params.inputparam){params.inputparam = ""} 

g_2_txtFile_g_0 = file(params.inputparam, type: 'any') 


process Reverse_file {

input:
 file InputFile from g_2_txtFile_g_0

output:
 file "Output.txt"  into g_0_txtFile_g_4

"""
tac ${InputFile} > Output.txt
"""
}


process Reverse_file_copy {

publishDir params.outdir, overwrite: true, mode: 'copy',
	saveAs: {filename ->
	if (filename =~ /Output-copy.txt$/) "outputparam/$filename"
}

input:
 file InputFile from g_0_txtFile_g_4

output:
 file "Output-copy.txt"  into g_4_txtFile

"""
tac ${InputFile} > Output-copy.txt
"""
}


workflow.onComplete {
println "##Pipeline execution summary##"
println "---------------------------"
println "##Completed at: $workflow.complete"
println "##Duration: ${workflow.duration}"
println "##Success: ${workflow.success ? 'OK' : 'failed' }"
println "##Exit status: ${workflow.exitStatus}"
}
