$(document).ready(function(){
	$('.load-example').on('click', function(){
		console.log("load-example clicked");
		// $('.seq-search-sequence').text("");
		var example1 = '>8657036VS\nMGKFHLTLSRRDFMKSLGLAGAGLATVKVGTPVFHDLDEVISNENSNWRRPWWVKEREFDKPTVDVDWGIYKRFDKFTYAPANARIAMFGQEAVMKANQDWNNLVAKRLQEDTAGFTIRDRAMDEGLCEEGINGGYPAPRTASLPQDLADMADPPIVLSKGRWEGTPEENSRMVRCVLKLAGAGSVAFGVASEDKAEKFIYTHEHVWGDFKHYKIGDYDDIWEDEETRYHPHKCKYMITYTIPESEELLRRAPSNFAEATVDQAYSESRVIFGRMTNFLWALGKYICGGDCSNAHSIHTATAAWTGLSECSRMHQQTISSEFGNIMRQFCIWTDLPLAPTPPIDMGIMRYCLTCKKCADTCPSGAISHEDPTWERAFAPYCQEGVYDYDFSHAKCSQFWKQSSWGCSMCTGSCPFGHKNYGTVHDVISATAAVTPIFNGFFRNMDDLFGYGKNPGMESWWDQEPRYRGLYREIF';
		$('.seq-search-sequence').val(example1);
	})

	$('.result-send-email').on('click', function(){
		// console.log("result-send-email");
		if(this.checked){
			$('.send-email-box').attr('hidden',false);
		}else{
			$('.send-email-box').attr('hidden',true);
		}
	})

	// https://stackoverflow.com/questions/8423217/jquery-checkbox-checked-state-changed-event
	// detect if the checkbox is changed
	var seq_search_form = $('#seq-search-form');
	$("#new_result_tab").change(function() {
	    if(this.checked) {

	    	if(seq_search_form.attr("target") === undefined){
				// not checked attribute yet; add one
				seq_search_form.attr('target','_blank');

				console.log(seq_search_form.attr("target"));
			}
		}else if(!this.checked){
			seq_search_form.removeAttr("target");
			console.log(seq_search_form.attr("target"));
		}
	});




})

jQuery(function($){
	// var items = $('.each-result');
	var items = $('.seq-search-hit');
	items.promise().done(function(){
		// console.log(items);
		var numItems = items.length;
		var perPage = 5;
		items.slice(perPage).hide();

		$('.data-container').pagination({
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
	
})

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
