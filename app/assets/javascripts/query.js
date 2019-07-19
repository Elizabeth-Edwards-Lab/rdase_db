$(document).ready(function(){
	$('.load-example').on('click', function(){
		console.log("load-example clicked");
		// $('.seq-search-sequence').text("");
		var example1 = '>8657036VS\nMGKFHLTLSRRDFMKSLGLAGAGLATVKVGTPVFHDLDEVISNENSNWRRPWWVKEREFDKPTVDVDWGIYKRFDKFTYAPANARIAMFGQEAVMKANQDWNNLVAKRLQEDTAGFTIRDRAMDEGLCEEGINGGYPAPRTASLPQDLADMADPPIVLSKGRWEGTPEENSRMVRCVLKLAGAGSVAFGVASEDKAEKFIYTHEHVWGDFKHYKIGDYDDIWEDEETRYHPHKCKYMITYTIPESEELLRRAPSNFAEATVDQAYSESRVIFGRMTNFLWALGKYICGGDCSNAHSIHTATAAWTGLSECSRMHQQTISSEFGNIMRQFCIWTDLPLAPTPPIDMGIMRYCLTCKKCADTCPSGAISHEDPTWERAFAPYCQEGVYDYDFSHAKCSQFWKQSSWGCSMCTGSCPFGHKNYGTVHDVISATAAVTPIFNGFFRNMDDLFGYGKNPGMESWWDQEPRYRGLYREIF';
		$('.seq-search-sequence').val(example1);
	})


	// $('.option').on('click', function(){ } // this only work once

	// $('.seq-result-container').pagination({
	// 	dataSource: ConstructDataSource(),
	// 	pageSize: 5,
	// 	callback: function(data, pagination) {
	// 		// template method of yourself
	// 		// so I can access all the value from $('.well.hit-result')[0].children
	// 		// put all value into javascript array
	// 		// and then do the pagination
	// 		var html = simpleTemplating(data);
	// 		$('.data-container').html(html);
	// 	}
	// })

	$('.result-send-email').on('click', function(){
		// console.log("result-send-email");
		if(this.checked){
			$('.send-email-box').attr('hidden',false);
		}else{
			$('.send-email-box').attr('hidden',true);
		}
	})
	
})

jQuery(function($){
	var items = $('.each-result');
	items.promise().done(function(){
		// console.log(items);
		var numItems = items.length;
		var perPage = 5;
		items.slice(perPage).hide();

		$('#data-container').pagination({
			items: numItems,
			itemsOnPage: perPage,
			cssStyle: "light-theme",
			onPageClick: function(pageNumber){
				var showFrom = perPage * (pageNumber - 1);
				var showTo = showFrom + perPage;
				items.hide().slice(showFrom,showTo).show();
			}
		})
	})
	// var numItems = items.length;
	// var perPage = 5;
	// items.slice(perPage).hide();

	// $('.data-container').pagination({
	// 	items: numItems,
	// 	itemsOnPage: perPage,
	// 	cssStyle: "light-theme",
	// 	onPageClick: function(pageNumber){
	// 		var showFrom = perPage * (pageNumber - 1);
	// 		var showTo = showFrom + perPage;
	// 		items.hide().slice(showFrom,showTo).show();
	// 	}
	// })


	
})


// $( window ).on( "load", function() { 

// 	$('.load-example').on('click','.delete_it', function(){
// 		var example1 = '>8657036VS\nMGKFHLTLSRRDFMKSLGLAGAGLATVKVGTPVFHDLDEVISNENSNWRRPWWVKEREFDKPTVDVDWGIYKRFDKFTYAPANARIAMFGQEAVMKANQDWNNLVAKRLQEDTAGFTIRDRAMDEGLCEEGINGGYPAPRTASLPQDLADMADPPIVLSKGRWEGTPEENSRMVRCVLKLAGAGSVAFGVASEDKAEKFIYTHEHVWGDFKHYKIGDYDDIWEDEETRYHPHKCKYMITYTIPESEELLRRAPSNFAEATVDQAYSESRVIFGRMTNFLWALGKYICGGDCSNAHSIHTATAAWTGLSECSRMHQQTISSEFGNIMRQFCIWTDLPLAPTPPIDMGIMRYCLTCKKCADTCPSGAISHEDPTWERAFAPYCQEGVYDYDFSHAKCSQFWKQSSWGCSMCTGSCPFGHKNYGTVHDVISATAAVTPIFNGFFRNMDDLFGYGKNPGMESWWDQEPRYRGLYREIF';
// 		$('.seq-search-sequence').text(example1);
// 	})

// })


function ConstructDataSource(){
	var all_result = $('.each-result');
	var global_seq_array = [];
	for(var i = 0; i < all_result.length; i++){
		let children = all_result[i].children;
		let local_seq_array = [];
		for (var j = 0; j < children.length; j++){
			local_seq_array.push(children[j].textContent);
		}
		global_seq_array.push(local_seq_array);
	}

	return global_seq_array;
}


function simpleTemplating(data) {
    var html = '<ul>';
    $.each(data, function(index, item){
        html += '<li>'+ item +'</li>';
    });
    html += '</ul>';
    return html;
}