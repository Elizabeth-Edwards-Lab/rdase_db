$(document).ready(function(){


	color_hash = {0: "#A52306", 1: "#163FE6", 2: "#6A7BF1", 3: "#F55C05", 4: "#45784C", 
								5: "#B9D279", 6: "#9B1E83", 7: "#0C70F4", 8: "#8F7663", 9: "#D5317D", 
								10: "#4EF49D", 11: "#1372D8", 12: "#3235A3", 13: "#8F95CF", 14: "#D326CF", 
								15: "#A26CA4", 16: "#2338D0", 17: "#524644", 18: "#BE3C19", 19: "#663DAF", 
								20: "#EB5FFF", 21: "#A50063", 22: "#F2375B", 23: "#22D9AB", 24: "#0DAE07", 
								25: "#64FC1E", 26: "#C099B0", 27: "#1578D4", 28: "#6C9DB1", 29: "#F92BF7", 
								30: "#354B49", 31: "#DBEAF1", 32: "#2D0DEA", 33: "#51C3E0", 34: "#C96CC5", 
								35: "#E14D00", 36: "#F6FA5E", 37: "#D19143", 38: "#146FD6", 39: "#5A6E79", 
								40: "#E39E4A", 41: "#48582F", 42: "#F2F0DF", 43: "#E7EF0B", 44: "#4C5E77", 
								45: "#FC1943", 46: "#127689", 47: "#E1CF4A", 48: "#67CA84", 49: "#0339A4", 
								50: "#A50DD8", 51: "#7E96FB", 52: "#6C28EA", 53: "#F8C79E", 54: "#22653C", 
								55: "#31D864", 56: "#716981", 57: "#15EF14", 58: "#AD26EC", 59: "#D5ED50", 
								60: "#8AC5CE", 61: "#A9849C", 62: "#C2B949", 63: "#390274", 64: "#E78D89", 
								65: "#161592", 66: "#5D2D13", 67: "#645741", 68: "#7098CB", 69: "#033F97", 
								70: "#461B15", 71: "#1581FF", 72: "#CB24BA", 73: "#C9F7F9", 74: "#2BDC27", 
								75: "#FC19AA", 76: "#6DC446", 77: "#26BB8F", 78: "#DF7D27", 79: "#B0DF4B", 
								80: "#5C8005", 81: "#F4C38B", 82: "#183645", 83: "#350CFF", 84: "#BD9C6D", 
								85: "#B70F93", 86: "#4EFEB0", 87: "#2AB09C", 88: "#F2211F", 89: "#48236C", 
								90: "#656D36", 91: "#7619BD", 92: "#CC6873", 93: "#CF3AC7", 94: "#529A93", 
								95: "#F581D0", 96: "#6590CD", 97: "#C0A2DF", 98: "#65F816", 99: "#561A0F"};

	var data = $('.controller-phy_data').data("phyData");
	var data_group = $('.controller-group_info').data("groupInfo");
	if (data != undefined && data_group != undefined){
		create_preloading_tree(data,data_group);
	}

	// add group button and add organism button are implemented in query.js
	// create pre-existing tree and render

	
	


	// phylogenies tree module
	$('#phylogeny-do-tree').submit(function(e){
		e.preventDefault();
		var form = $(this);
		var all_groups = get_all_groups();
		var all_organims = get_all_organims();
		var extra_param = "";
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
			url: "/phylogeny",
			// give the sequence back for generating new fasta file
			// extra_param => if user only choose use one box, then only pass params[:group] or params[:organism]
			data: form.serialize() + extra_param,
			beforeSend: function(){
				
				// $('#waiting-gif').removeAttr("style");
			},
			success: function(data){
				$('#phylocanvas-page-warning').attr("style","visibility:hidden;");
				
				var number_sequence = Number(data.num_sequence)
				// console.log(data.num_sequence)
				if (number_sequence == 0){
					// $('#waiting-gif').attr("style","visibility:hidden;");
					$('#phylocanvas-page-warning').removeAttr("style","visibility:hidden;");
					$('#phylocanvas-page-warning').text("Your selection return 0 sequence. Please choose different selection. More detail can be found in our sequence database.")
				}
				else{
					// $('#waiting-gif').attr("style","visibility:hidden;");
					$('#phylocanvas-page-warning').attr("style","visibility:hidden;");
					var current_tree_no = $('#tree-group').find('canvas').length;
					
					if (current_tree_no < 5){
						$('#tree-group').prepend(`<div id=\"phylocanvas-${current_tree_no}\"></div>`);
						create_phylocanvas_for_phylogeny(data.tree, data.group, `phylocanvas-${current_tree_no}`);
						
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


		});
	});



	// only load pre-tree when at phylogeny page
	function create_preloading_tree(data,data_group){
		create_phylocanvas_for_phylogeny(data,data_group,"pre-rendered-tree");
		$('.phylocanvas-history').remove();

	}

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


	function create_phylocanvas_for_phylogeny(data,data_group,tree_name) {
		// createTree find the div by: document.getElementById(element)
		var tree = Phylocanvas.createTree(tree_name);
		tree.setTreeType('circular');
		tree.load(data);

		var all_leaves = tree.leaves;
		if(all_leaves.length > 1){
			for(var i = 0; i < all_leaves.length; i++){
				var group = data_group[all_leaves[i].label];
				if(group != null && group != undefined){
					// based on group, colour the right color
					all_leaves[i].colour = color_hash[parseInt(group)]
					all_leaves[i].label  = all_leaves[i].label + "(" + group + ")"
				}
			}
		}
		
		tree.draw();
		tree.on('click', function (e) {
			var node = tree.getNodeAtMousePosition(e);
		});

		$('.phylocanvas-history').remove();

	}


});




























