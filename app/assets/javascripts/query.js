$(document).ready(function(){
	$('.load-example').on('click', function(){
		console.log("load-example");
		var example1 = '>8657036VS\nMGKFHLTLSRRDFMKSLGLAGAGLATVKVGTPVFHDLDEVISNENSNWRRPWWVKEREFDKPTVDVDWGIYKRFDKFTYAPANARIAMFGQEAVMKANQDWNNLVAKRLQEDTAGFTIRDRAMDEGLCEEGINGGYPAPRTASLPQDLADMADPPIVLSKGRWEGTPEENSRMVRCVLKLAGAGSVAFGVASEDKAEKFIYTHEHVWGDFKHYKIGDYDDIWEDEETRYHPHKCKYMITYTIPESEELLRRAPSNFAEATVDQAYSESRVIFGRMTNFLWALGKYICGGDCSNAHSIHTATAAWTGLSECSRMHQQTISSEFGNIMRQFCIWTDLPLAPTPPIDMGIMRYCLTCKKCADTCPSGAISHEDPTWERAFAPYCQEGVYDYDFSHAKCSQFWKQSSWGCSMCTGSCPFGHKNYGTVHDVISATAAVTPIFNGFFRNMDDLFGYGKNPGMESWWDQEPRYRGLYREIF';
		$('.seq-search-sequence').text(example1);
	})


	$('#seq-result-container').pagination({
		dataSource: [],
		pageSize: 5,
		callback: function(data, pagination) {
			// template method of yourself
			// so I can access all the value from $('.well.hit-result')[0].children
			// put all value into javascript array
			// and then do the pagination
			var html = template(data);
			dataContainer.html(html);
		}
	})
})

