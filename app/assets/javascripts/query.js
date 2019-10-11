// jQuery(function($){}) and $(document).ready(function(){} are equivalent.
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
				seq_search_form.attr('value','1'); // will render new pages
			}
		}else if(!this.checked){
			seq_search_form.removeAttr("target");
			seq_search_form.attr('value','0');
			// console.log(seq_search_form.attr("target"));
		}
	});


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


	// phylogenies tree module
	$('#do-tree').submit(function(e){
		e.preventDefault();
		sequence = $('.seq-search-sequence').val(); 
		var form = $(this);
		$.ajax({
			type:"POST",
			url: "/phylogenetic_tree",
			// give the sequence back for generating new fasta file
			data: form.serialize() + '&sequence=' + sequence,
			beforeSend: function(){
				// $('#generate-phylogenetic-tree').hide();
				$('#waiting-gif').removeAttr("style");
			},
			success: function(data){
				$('#phylocanvas-page-warning').attr("style","visibility:hidden;");
				
				var number_sequence = Number(data.num_sequence)
				// console.log(data.num_sequence)
				if (number_sequence == 0){
					$('#waiting-gif').attr("style","visibility:hidden;");
					$('#phylocanvas-page-warning').removeAttr("style","visibility:hidden;");
					$('#phylocanvas-page-warning').text("Your selection return 0 sequence. Please choose different selection. More detail can be found in our sequence database.")
				}
				else{
					$('#waiting-gif').attr("style","visibility:hidden;");
					$('#phylocanvas-page-warning').attr("style","visibility:hidden;");
					create_phylocanvas(data.tree, data.highlight, data.group, data.group_number);
				}
				$('#graph-note').removeAttr("style","visibility:hidden;");
				
			},
			error: function(data){
				$("#submit-message").text(data.message_err);
			},
			timeout: 1000 * 60


		})
	})

	// sample data: (A:0.1,B:0.2,(C:0.3,D:0.4)E:0.5)F
	// data_group is json object
	var create_phylocanvas = function phylocanvas(data,highlight,data_group, group_number) {
		var tree = Phylocanvas.createTree('phylocanvas');
		tree.setTreeType('circular');
		tree.load(data);

		// auto generate #of group color
		var group_number_int = parseInt(group_number)
		var color_pool = [];
		var color_hash = {};
		for (var i = 0; i <= group_number_int; i++){
			var random_color = getRandomColor();
			while (color_pool.includes(random_color) == false){
				color_pool.push(random_color);
				color_hash[i] = random_color;
			}
		}
		

		// colour the node based on their groups
		// data_group need test and check its data type
		// assign color and group info based on group
		var all_leaves = tree.leaves;
		if(all_leaves.length > 1){
			for(var i = 0; i < all_leaves.length; i++){
				var group = data_group[all_leaves[i].label];
				if(group != null && group != undefined){
					// based on group, colour the right color
					all_leaves[i].colour = color_hash[parseInt(group)]
					all_leaves[i].label  = all_leaves[i].label + "(" + group + ")"
				}
				else{
					all_leaves[i].label  = all_leaves[i].label + "( No Group )"
				}
			}
		}

		var re = new RegExp(highlight);
		var leaves = tree.findLeaves(re);
		// require check the sequence header to make sure it doesn't have duplicates
		if (leaves[0] !== undefined ){
			leaves[0].highlighted = true;
			tree.fitInPanel(leaves);
		}
		
		tree.draw();
		tree.on('click', function (e) {
			var node = tree.getNodeAtMousePosition(e);
			if (node) {
				tree.redrawFromBranch(node);
			}
		});

	}

	function getRandomColor() {
		var letters = '0123456789ABCDEF';
		var color = '#';
		for (var i = 0; i < 6; i++) {
			color += letters[Math.floor(Math.random() * 16)];
		}
		return color;
	}


	// submit sequence part
	// This is not used anymore as we moved out the submit sequence as independent module
	// $('#submit-seq').submit(function(e){
	// 	e.preventDefault();
	// 	var sequence = $('.seq-search-sequence').val();
	// 	var group = $('#simtext-group').text().replace(/^\s+|\s+$/g, '');
	// 	var form = $(this);
	// 	form.attr('sequence',sequence);
		
	// 	console.log(typeof(form.serialize()));
	// 	$.ajax({
	// 		type:"POST",
	// 		url: "/submit_sequence",
	// 		// 'form.serialize()+ '&sequence=' + sequence' is kind ugly but it works.
	// 		data: form.serialize()+ '&sequence=' + sequence + '&group=' + group,
	// 		success: function(data){
	// 			console.log("success");
	// 			console.log(data);
	// 			$("#submit-message").text(data.message);
	// 			$("#submit-seq").remove();
	// 			$("#_submit_seq_p").remove();

	// 		},
	// 		error: function(data){
	// 			$("#submit-message").text(data.message_err);
	// 		}
	// 	})
	// })


	


})
