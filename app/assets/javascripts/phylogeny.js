

$(document).ready(function(){

	var hashed_color = {
		0: "#618F47",
		1: "#DFBC38",
		2: "#D5A0DF",
		3: "#2BEC4E",
		4: "#2B6E44",
		5: "#9B56EF",
		6: "#2436A7",
		7: "#5FCE36",
		8: "#346C60",
		9: "#84B6B3",
		10: "#E1F10A",
		11: "#87CCF6",
		12: "#D01FE3",
		13: "#51387B",
		14: "#A1212B",
		15: "#CEAA6C",
		16: "#E5842F",
		17: "#D47AAA",
		18: "#296A50",
		19: "#63A142",
		20: "#E8846C",
		21: "#FD2F93",
		22: "#D2943A",
		23: "#E6FD86",
		24: "#D3304E",
		25: "#4DFBE9",
		26: "#9CE96A",
		27: "#A6E6B6",
		28: "#52FA10",
		29: "#A0BC18",
		30: "#88EFA9",
		31: "#C03652",
		32: "#E9D0FC",
		33: "#D83A78",
		34: "#148316",
		35: "#8F2FA3",
		36: "#C91785",
		37: "#84628C",
		38: "#F820B4",
		39: "#AF4549",
		40: "#4B1D3E",
		41: "#21AAED",
		42: "#C7A6C2",
		43: "#BA31CE",
		44: "#EFA40C",
		45: "#909F6B",
		46: "#CF08F1",
		47: "#695062",
		48: "#A4A65E",
		49: "#E78E4C",
		50: "#A0D2AC",
		51: "#7CA741",
		52: "#191719",
		53: "#07281F",
		54: "#FD31E6",
		55: "#6AC247",
		56: "#CCA23E",
		57: "#F9E84E",
		58: "#FDB8E4",
		59: "#CAB80A",
		60: "#030B8D",
		61: "#A047C7",
		62: "#CB685E",
		63: "#5882B1",
		64: "#7E676A",
		65: "#53941E",
		66: "#7EE423",
		67: "#5E1395",
		68: "#09E135",
		69: "#819369",
		70: "#32A89C",
		71: "#61E1F0",
		72: "#4EA70A",
		73: "#037320",
		74: "#65AF57",
		75: "#FDD284",
		76: "#0D9E1B",
		77: "#F2E26A",
		78: "#C77F19",
		79: "#ABAF68",
		80: "#5C3393",
		81: "#F07E1A",
		82: "#A779C9",
		83: "#2DF494",
		84: "#A94A67",
		85: "#22DD54",
		86: "#4930C5",
		87: "#62F3AE",
		88: "#3D7E55",
		89: "#59BA92",
		90: "#38692A",
		91: "#23B6E7",
		92: "#242759",
		93: "#A58BBB",
		94: "#04E89E",
		95: "#872FD6",
		96: "#56431D",
		97: "#9388EC",
		98: "#479577",
		99: "#DF70E5",
		100: "#44F7AF",
		101: "#619D52",
		102: "#67BD52",
		103: "#33CC17",
		104: "#275E03",
		105: "#66FCB1",
		106: "#E9898E",
		107: "#CE9496",
		108: "#E8BE90",
		109: "#FBA419",
		110: "#8E6544",
		111: "#A1C6E1",
		112: "#47D846",
		113: "#B326A2",
		114: "#4363BF",
		115: "#DDE3E7",
		116: "#3753C5",
		117: "#E6ABB3",
		118: "#14F2E1",
		119: "#C5C7F4",
		120: "#62F41D",
		121: "#BC19CF",
		122: "#B9C748",
		123: "#41EBFD",
		124: "#16A082",
		125: "#1BC024",
		126: "#A320CF",
		127: "#5C190C",
		128: "#78321E",
		129: "#011A7A",
		130: "#064BFD",
		131: "#5BDB07",
		132: "#23268F",
		133: "#F5C8CA",
		134: "#9E64DF",
		135: "#230322",
		136: "#C10A4B",
		137: "#6E092C",
		138: "#69C6B5",
		139: "#BD3D3D",
		140: "#97FE78",
		141: "#A6BCE4",
		142: "#D64AE7",
		143: "#3D89E4",
		144: "#5BFE7D",
		145: "#3DDE1D",
		146: "#BF717F",
		147: "#A9A71A",
		148: "#4E42A7",
		149: "#D9C600",
		150: "#9853FD",
		151: "#090728",
		152: "#D2581E",
		153: "#64EA84",
		154: "#EDAC26",
		155: "#64F7F9",
		156: "#B65E35",
		157: "#C29B13",
		158: "#D98593",
		159: "#718F45",
		160: "#52F4B4",
		161: "#65E3AA",
		162: "#E71BE0",
		163: "#01A79F",
		164: "#85580F",
		165: "#CE81F7",
		166: "#60FE04",
		167: "#82CC47",
		168: "#1D4C51",
		169: "#E525D1",
		170: "#046D20",
		171: "#E487D3",
		172: "#5927D6",
		173: "#E124E3",
		174: "#CAE9DB",
		175: "#47595E",
		176: "#7015EF",
		177: "#BD6F26",
		178: "#87ED8E",
		179: "#6F574F",
		180: "#CA58CC",
		181: "#85B829",
		182: "#F56E4D",
		183: "#048F6C",
		184: "#3E8399",
		185: "#479286",
		186: "#3AF4D4",
		187: "#D603E3",
		188: "#043118",
		189: "#2DE4DE",
		190: "#85CF90",
		191: "#26437D",
		192: "#26E273",
		193: "#0EAC45",
		194: "#29DC83",
		195: "#F2816C",
		196: "#7AE244",
		197: "#AA2B88",
		198: "#74BF40",
		199: "#E78834",
		200: "#3C8D43",
		201: "#84CAA4",
		202: "#919830",
		203: "#237844",
		204: "#21E42D",
		205: "#ED0D04",
		206: "#D78A52",
		207: "#FB40EF",
		208: "#CB02D8",
		209: "#C5D4ED",
		210: "#139F6E",
		211: "#90BD08",
		212: "#B86A4A",
		213: "#21D1FD",
		214: "#7CE00A",
		215: "#BB1651",
		216: "#258BA6",
		217: "#029C4E",
		218: "#3A616F",
		219: "#2B8642",
		220: "#6C2948",
		221: "#49E33D",
		222: "#37F092",
		223: "#827E46",
		224: "#0141ED",
		225: "#B64637",
		226: "#CB2DFE",
		227: "#FAB974",
		228: "#81DA3B",
		229: "#6A334A",
		230: "#669B67",
		231: "#C4B21E",
		232: "#19614D",
		233: "#E7AE02",
		234: "#58F032",
		235: "#052EA9",
		236: "#B86742",
		237: "#2FAE92",
		238: "#F9370A",
		239: "#E3C8A9",
		240: "#6AC323",
		241: "#C6EE33",
		242: "#1254BF",
		243: "#793A99",
		244: "#B399D5",
		245: "#484DFF",
		246: "#1E4A6D",
		247: "#E355F7",
		248: "#4328AB",
		249: "#25D284",
		250: "#A4C7A7",
		251: "#8B09D3",
		252: "#F0355C",
		253: "#FA21D0",
		254: "#0FDC4B",
		255: "#E9838A",
		256: "#63F1E1",
		257: "#FEE79F",
		258: "#1F45C8",
		259: "#84EA03",
		260: "#FB2CBA",
		261: "#E543B4",
		262: "#BAAC22",
		263: "#016393",
		264: "#6A43A5",
		265: "#8B30B3",
		266: "#4B2373",
		267: "#31F0C9",
		268: "#5C5EBA",
		269: "#364121",
		270: "#AE74A0",
		271: "#367729",
		272: "#B8EDE1",
		273: "#0B1F32",
		274: "#2D86B3",
		275: "#927709",
		276: "#5CCBA8",
		277: "#107B41",
		278: "#694B04",
		279: "#776C1A",
		280: "#31B686",
		281: "#D43E85",
		282: "#0346D8",
		283: "#255562",
		284: "#3E0C2C",
		285: "#E21C6B",
		286: "#2564AB",
		287: "#E0ED22",
		288: "#E664F9",
		289: "#601C59",
		290: "#C5EAB0",
		291: "#B8F2C9",
		292: "#E7AB8B",
		293: "#CBE942",
		294: "#56ACCA",
		295: "#22A8BD",
		296: "#4EBE6C",
		297: "#B431A3",
		298: "#513163",
		299: "#F875FD",
		300: "#D397A9",
		301: "#414C43",
		302: "#08A0BE",
		303: "#321099",
		304: "#8831AA",
		305: "#EF68D6",
		306: "#BE4937",
		307: "#E0008D",
		308: "#9EE7A9",
		309: "#B5114A",
		310: "#531F60",
		311: "#CB7C68",
		312: "#4E0687",
		313: "#8C5522",
		314: "#97A105",
		315: "#34704A",
		316: "#7407F0",
		317: "#749AEC",
		318: "#67A776",
		319: "#9F0A34",
		320: "#E3380B",
		321: "#95586D",
		322: "#50C73B",
		323: "#7D9467",
		324: "#C6E930",
		325: "#92F070",
		326: "#3C4ADC",
		327: "#BA4954",
		328: "#F0F2EC",
		329: "#070052",
		330: "#DB4B88",
		331: "#0AC918",
		332: "#9C3509",
		333: "#A045B1",
		334: "#F0BF7D",
		335: "#0BC839",
		336: "#A41F7A",
		337: "#3FA8F9",
		338: "#65514C",
		339: "#284E5E",
		340: "#B26B6F",
		341: "#D6E38C",
		342: "#F0EB58",
		343: "#A3C62E",
		344: "#B596EB",
		345: "#9AC95D",
		346: "#9FC81B",
		347: "#9B7E43",
		348: "#8FB588",
		349: "#C42B76",
		350: "#6316FF",
		351: "#30D6B1",
		352: "#4094AF",
		353: "#F1FE20",
		354: "#88D1A3",
		355: "#6898AF",
		356: "#D5A73E",
		357: "#BCC8BB",
		358: "#B5A346",
		359: "#8AB478",
		360: "#EF6DEF",
		361: "#F0B414",
		362: "#70C200",
		363: "#D3903B",
		364: "#7F9A4C",
		365: "#35E55F",
		366: "#B62B8D",
		367: "#86377C",
		368: "#6BDF0B",
		369: "#CDD23C",
		370: "#EEB2D3",
		371: "#200BBD",
		372: "#BA12BD",
		373: "#8A2C72",
		374: "#E5A420",
		375: "#35BA35",
		376: "#EE009B",
		377: "#171AAE",
		378: "#675A61",
		379: "#AA95E9",
		380: "#5C79A4",
		381: "#6E7954",
		382: "#23030C",
		383: "#FC3220",
		384: "#301FF1",
		385: "#5595A3",
		386: "#1D1C9B",
		387: "#BDD7CD",
		388: "#5B1442",
		389: "#9054B6",
		390: "#D1FA5D",
		391: "#3AD0FE",
		392: "#58B4F1",
		393: "#8BBFC4",
		394: "#A4F70C",
		395: "#001902",
		396: "#0C8494",
		397: "#E5860B",
		398: "#D3D4A8",
		399: "#2018A3"
	};

	var data = $('.controller-phy_data').data("phyData");
	var data_group = $('.controller-group_info').data("groupInfo");
	if (data != undefined && data_group != undefined){
		create_preloading_tree(data,data_group);
	}
	
	
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
				// console.log(group);
				// console.log(all_leaves[i].label);
				if(group != null && group != undefined){
					// based on group, colour the right color
					all_leaves[i].colour = hashed_color[parseInt(group)]
					// console.log(all_leaves[i].colour);
					all_leaves[i].label  = `${all_leaves[i].label} (${group})`
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



























