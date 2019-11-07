$(document).ready(function(){
	$body = $("body");
	$(document).on({
	    ajaxStart: function() { $body.addClass("loading"); },
	    ajaxStop: function() { $body.removeClass("loading"); }    
	});



	// decision tree button selection; will render with different contents
	$('#public-id-no').click(function(){
		// send to lab 
		$('.container.decision-tree').attr('style',"display: none;");
		$('#submit-to-lab-interface').removeAttr('style');

	});

	$('#public-id-yes').click(function(){
		$('#public-id-info-div').attr('style',"display: none;");
		$('#binding-domain-info-div').removeAttr('style');
	})

	$('#binding-domain-yes').click(function(){
		$('.container.decision-tree').attr('style',"display: none;");
		$('#submit-interface').removeAttr('style');
		$('#selection-info').removeAttr('style');
	})

	$('#binding-domain-no').click(function(){
		$('.container.decision-tree').attr('style',"display: none;");
		$('#submit-to-lab-interface').removeAttr('style');
	})
	//////////////////////////////////////////////////////////////////////////////////////////

	
	// https://stackoverflow.com/questions/8423217/jquery-checkbox-checked-state-changed-event
	// detect if the checkbox is changed
	$("#upload-file-btn-aa").change(function() {
		if( $('#upload-file-btn-aa').get(0).files.length >= 1){
			$('#upload-div-aa').val('');
			$('#upload-div-aa').attr('disabled', true);
			$('#upload-div-aa').attr('placeholder', "File detected. To remove file, click 'Choose File', and click 'Cancel' without selecting anything. Disclaimer: We won't store your file at our database. ");
		}else{
			$('#upload-div-aa').attr('disabled', false);
			$('#upload-div-aa').attr('placeholder',"> Self-assigned ID or Name | Accession No. | Organism | Citation (optional) | \nYour Amino Acid Sequence ...");
		}
	});

	$("#upload-file-btn-nt").change(function() {
		if( $('#upload-file-btn-nt').get(0).files.length >= 1){
			$('#upload-div-nt').val('');
			$('#upload-div-nt').attr('disabled', true);
			$('#upload-div-nt').attr('placeholder', "File detected. To remove file, click 'Choose File', and click 'Cancel' without selecting anything. Disclaimer: We won't store your file at our database. ");
		}else{
			$('#upload-div-nt').attr('disabled', false);
			$('#upload-div-nt').attr('placeholder',"> Self-assigned ID or Name | Accession No. | Organism | Citation (optional) | \nYour Nucleotide Sequence ...");
		}
	});
	//////////////////////////////////////////////////////////////////////////////////////////
	

	// this ajax request overwrite the rails default parameter passing
	// this ajax is for submit sequence to annotate
	$('#upload-seq').submit(function(e){
		e.preventDefault();

		$.ajax({
			type:"POST",
			url: "/submit_sequence",
			// give the sequence back for generating new fasta file
			data:  new FormData(this),
			contentType: false,
			cache: false,
			processData:false,
			beforeSend: function(){

				// restart the warning message;
				$('#possible_errors').empty();
				$('#possible_errors').attr("style","display: none;");
			},
			success: function(data){
				if(data.result != undefined){
					$('#submit-interface').empty(); // for the safe, people can change the attribute of dom in chrome to make it appear again if use display none;
					// add style
					var style = $('<style>\
									div#submit-interface-result table td,tr,th  \
										{ \
											border: none; \
											\
										}\
									\
									</style>');
					$('html > head').append(style);

					$('#submit-interface-result').removeAttr("style");
					$('#submit-interface-result').prepend("<h3 id=\"p-submit-result\">Result</h3>" + construct_table(data));


				}else if (data.errors != undefined){
					$('#possible_errors').removeAttr('style');
					for(var i = 0; i < data.errors.length; i++){
						$('#possible_errors').prepend(`<p>${data.errors[0]}</p>`);
					}
					
				}

				
			},

			error: function(data){
				$("#possible_errors").prepend(`<p>${data}</p>`);
			},

			timeout: 1000 * 600


		});
	});


	// for styling 
	// var style = $('<style>.class { background-color: blue; }</style>');
	// $('html > head').append(style);
	// https://stackoverflow.com/questions/13075920/add-css-rule-via-jquery-for-future-created-elements
	var construct_table = function(data){

		var table_content = "<table class='table'>\
							<thead>\
								<tr>\
									<th scope='col'>#</th>\
									<th scope='col'>Header</th>\
									<th scope='col'>Status</th>\
									<th scope='col'>Message</th>\
								</tr>\
							</thead>\
							<tbody>"

		// table_content += "<table id='upload-seq-result-table'>\
		// 										<tr>\
		// 										<th>Header</th>\
		// 										<th>Status</th>\
		// 										<th>Message</th>\
		// 										<th style=\"display: none;\">Group</th>\
		// 									</tr>";
		for(var i = 0; i < data.result.length; i++){
			header = data.result[i].header;
			status = data.result[i].status;
			msg    = data.result[i].msg;
			group  = data.result[i].group;
			// if status is success, add some style, etc.
			table_content += `<tr>\
									<th scope="row">${i+1}</th>\
										<td>${header}</td>\
										<td>${status}</td>\
										<td>${msg}</td>\
								</tr>`;
		}
		table_content += "</tbody></table>";
		return table_content;
	}



})
