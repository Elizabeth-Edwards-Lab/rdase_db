// jQuery(function($){}) and $(document).ready(function(){} are equivalent.
$(document).ready(function(){

	$('.load-example').on('click', function(){
		// console.log("load-example clicked");
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
		var all_groups = get_all_groups();
		var all_organims = get_all_organims();
		var extra_param = '&sequence=' + sequence;
		// 0 means there is no added selections
		if (all_groups.length != 0){
			extra_param += '&groups=' + JSON.stringify(all_groups);
			// else if all_groups.length == 1, means that only one selecting box or user select all group;
		} 

		if (all_organims.length != 0){
			extra_param += '&organisms=' + JSON.stringify(all_organims);
		}


		// console.log(form);
		$.ajax({
			type:"POST",
			url: "/phylogenetic_tree",
			// give the sequence back for generating new fasta file
			// extra_param => if user only choose use one box, then only pass params[:group] or params[:organism]
			data: form.serialize() + extra_param,
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
					var current_tree_no = $('#tree-group').find('canvas').length;
					if (current_tree_no < 5){
						$('#tree-group').prepend(`<div id=\"phylocanvas-${current_tree_no}\"></div>`);
						create_phylocanvas(data.tree, data.highlight, data.group, data.group_number,`phylocanvas-${current_tree_no}`);
					}else{
						$('#phylocanvas-page-warning').removeAttr("style");
						$('#phylocanvas-page-warning').text("We only allow max 5 trees; If you wish generate more tree, please try on your local machine.");
					}
					
				}
				$('#graph-note').removeAttr("style","visibility:hidden;");
				
			},
			error: function(data){
				$("#submit-message").text(data.message_err);
			},
			timeout: 1000 * 60


		})
	})


	$('#add-group').click(function(){
		
		// getGroupOption();
		var options = getGroupOption();
		var options_element = "";
		for(var i = 0; i < options.length; i++){
			options_element += `<option value="${options[i]}">${options[i]}</option>`;
		};

		$('.col-4.stack-group').append(`<div><select id="append-group">${options_element}</select><button id="new-button-div" type="button">remove</button></div>`);

	})

	$('#add-organism').click(function(){

		var options = getOrganismOption();
		// console.log(options);
		var options_element = "";
		for(var i = 0; i < options.length; i++){
			options_element += `<option value="${options[i]}">${options[i]}</option>`;
		};

		$('.col-8.stack-organism').append(`<div><select id="append-organism">${options_element}</select><button id="new-button-div" type="button">remove</button></div>`);

	})

	
	// Remove parent of 'remove' link when link is clicked.
	// reference: https://stackoverflow.com/questions/1501181/jquery-append-and-remove-element
	$('.col-4.stack-group').on('click', '#new-button-div', function(e) {
	    e.preventDefault();
	    $(this).parent().remove();
	});

	$('.col-8.stack-organism').on('click', '#new-button-div', function(e) {
	    e.preventDefault();
	    $(this).parent().remove();
	});

	// 
	function getOrganismOption(){
		var group_list = []
		$('select#orig-organism option').each(function(){
			group_list.push($(this).val());
		});
		group_list.push("All Organism");
		group_list.shift(); // remove first elements;
		// console.log(group_list);
		return group_list;

	};

	//
	function getGroupOption(){
		var group_list = []
		$('select#orig-group option').each(function(){
			group_list.push($(this).val());
		});

		group_list.push("All OGs");
		group_list.shift();

		return group_list;
	};

	
	// if there is All groups options, then return all groups options immediately without checking other options
	function get_all_groups(){
		
		var all_groups = [];
		var val1 = $( "select#orig-group" ).val();
		if (val1 == "" || val1 == "All OGs"){
			return ["All OGs"];
		}
		// at this step, val1 shouldn't be "" or "All OGs"
		all_groups.push(val1);

		var val2array = $( "select#append-group");
		for(var i = 0; i < val2array.length; i++){
			if (val2array[i].value == "All OGs"){
				return ["All OGs"];
			}else{
				all_groups.push(val2array[i].value);
			};
			
		};

		return all_groups;


	}

	// 
	function get_all_organims(){
		
		var all_organims = [];
		var val1 = $( "select#orig-organism" ).val();
		if (val1 == "" || val1 == "All Organism"){
			return ["All Organism"];
		}
		// at this step, val1 shouldn't be "" or "All OGs"
		all_organims.push(val1);

		var val2array = $( "select#append-organism");
		for(var i = 0; i < val2array.length; i++){
			if (val2array[i].value == "All Organism"){
				return ["All Organism"];
			}else{
				all_organims.push(val2array[i].value);
			};
			
		};

		return all_organims;
	}

	// sample data: (A:0.1,B:0.2,(C:0.3,D:0.4)E:0.5)F
	// data_group is json object
	var create_phylocanvas = function phylocanvas(data,highlight,data_group, group_number, tree_name) {
		// createTree find the div by: document.getElementById(element)
		var tree = Phylocanvas.createTree(tree_name);
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


	// query main pages;
	// #blast-parameters is the button that display parameters option for user (like ncbi-blast)
	$('#blast-parameters').click(function(){
		var blast_box = $('.row#parameter-box');
		var is_style = blast_box.attr('style');
		if (is_style){
			$('.row#parameter-box').removeAttr('style');
			// <i class="fas fa-plus"></i>
			$('#blast-param-sign').attr('class','fas fa-minus');
		}else{
			$('.row#parameter-box').attr('style','display: none;');
			$('#blast-param-sign').attr('class','fas fa-plus');

		}
		// console.log(is_style);
	})
	


})
