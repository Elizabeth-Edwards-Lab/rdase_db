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
			$('#upload-div-aa').removeAttr('placeholder');
		}
	});

	$("#upload-file-btn-nt").change(function() {
		if( $('#upload-file-btn-nt').get(0).files.length >= 1){
			$('#upload-div-nt').val('');
			$('#upload-div-nt').attr('disabled', true);
			$('#upload-div-nt').attr('placeholder', "File detected. To remove file, click 'Choose File', and click 'Cancel' without selecting anything. Disclaimer: We won't store your file at our database. ");
		}else{
			$('#upload-div-nt').attr('disabled', false);
			$('#upload-div-nt').attr('placeholder',"Optional. We only evaluate your amino acid sequences.\nPlease use the header name that match your amino acid sequences.");
		}
	});
	//////////////////////////////////////////////////////////////////////////////////////////


	$(".upload-file-btn-direct-lab").change(function() {
		if( $('.upload-file-btn-direct-lab').get(0).files.length >= 1){
			$('.upload-div').val('');
			$('.upload-div').attr('disabled', true);
			$('.upload-div').attr('placeholder', "File detected. To remove file, click 'Choose File', and click 'Cancel' without selecting anything. Disclaimer: We won't store your file at our database. ");
		}else{
			$('.upload-div').attr('disabled', false);
			$('.upload-div').removeAttr('placeholder');
		}
	});


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

				$('#upload-seq-result-table').empty();
				$('#p-submit-result').empty();
				$('#submit-seq-result-div').empty();
				$('#save-sequence-form-div').attr("style","display: none;");
			},
			success: function(data){
				if(data.result != undefined){
					$('#selection-info').attr("style", "display: none;");
					$('#submit-seq-result-div').prepend("<h4 id=\"p-submit-result\">Result</h4><hr>" + construct_table(data));
					

					if (containSuccess(data)){
						console.log("has success");
						$('#save-sequence-form-div').removeAttr("style");
						// below is just for appending data for submit the data to database
						var fasta_data = "<div id='uploaded_fasta_data' style=\"display:none;\">";
						for(var i = 0; i < data.fasta.length; i++){
							fasta_data += `<p>${data.fasta[i]}</p>`;
						}

						fasta_data += "</div>";
						$('#submit-seq-result-div').append(fasta_data);

						if (data.file_path != undefined){
							var fasta_file_path = `<div id='fasta_file_path' style="display:none;"><p>${data.file_path}</p></div>`;
							$('#submit-seq-result-div').append(fasta_file_path);
						}
					}
					
					

				}else if (data.notice != undefined){
					// console.log(data.notice);
					$('#submit-seq-result-div').prepend(`<p class=\"alert alert-danger\" role=\"alert\">${data.notice}</p>`);
				}

				
			},
			error: function(data){
				$("#submit-message").text("Error occurs.");
			},
			timeout: 1000 * 60


		});
	});


	var containSuccess = function(data){
		for(var i = 0; i < data.result.length; i++){

			if (data.result[i].status == "SUCCESS" || data.result[i].status == "NEW"){
				return true;
			}
		}
		return false;
	}

	// for styling 
	// var style = $('<style>.class { background-color: blue; }</style>');
	// $('html > head').append(style);
	// https://stackoverflow.com/questions/13075920/add-css-rule-via-jquery-for-future-created-elements
	var construct_table = function(data){
		
		var table_content = "";
		
		table_content += "<table id='upload-seq-result-table'>\
												<tr>\
												<th>Header</th>\
												<th>Status</th>\
												<th>Message</th>\
												<th style=\"display: none;\">Group</th>\
											</tr>";
		for(var i = 0; i < data.result.length; i++){
			header = data.result[i].header;
			status = data.result[i].status;
			msg    = data.result[i].msg;
			group  = data.result[i].group;
			// if status is success, add some style, etc.
			table_content += `<tr>\
														<td>${header}</td>\
														<td>${status}</td>\
														<td>${msg}</td>\
														<td style=\"display: none;\">${group}</td>\
												</tr>`;
		}
		table_content += "</table>";
		return table_content;
	}

	// this ajax is for after annotation, and user decide to upload their data to our database
	$('#save-seqeunce').submit(function(e){
		e.preventDefault();
		var form = $(this);
		var table_data = retrieve_table_data();
		var seq_data   = retrieve_sequence_data(); // this only works if user submit their sequence by textarea
		if($('#fasta_file_path').find('p').length == 1){
			var extra = "&table=" + JSON.stringify(table_data) + "&sequence=" + JSON.stringify(seq_data) + "&file_name=" + file_name
		}else{
			var extra = "&table=" + JSON.stringify(table_data) + "&sequence=" + JSON.stringify(seq_data)
		}

		$.ajax({
			type:"POST",
			url: "/save_sequence",
			// give the sequence back for generating new fasta file
			// may need to pass through file name because the seq_data will be very large potentially
			// data: { authenticity_token: $('[name="csrf-token"]')[0].content},
			data: form.serialize() + extra,
			beforeSend: function(xhr){
				// seems work without below line to avoid `Can't verify CSRF token authenticity rails`
				// xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
			},
			success: function(data){
				console.log(data);
			},
			error: function(data){
				$("#submit-message").text("Error occurs.");
			},
			timeout: 1000 * 60
		})
	});

	var retrieve_table_data = function(){
		var message = [];
		$('#upload-seq-result-table').find('tr').each(function (i, el) {
			var $tds = $(this).find('td');
            header = $tds.eq(0).text();
            status = $tds.eq(1).text();
            group = $tds.eq(3).text();
            message.push({"header":header, "status":status, "group":group});
		});

		message.shift();
		return message;
	}

	var retrieve_sequence_data = function(){
		var sequence = [];
		$('#uploaded_fasta_data').find('p').each(function(i,el){
			sequence.push($(this).text());
		})
		return sequence;
	}


	$('#upload-seq-to-lab').submit(function(e){
		e.preventDefault();
		
		$.ajax({
			type:"POST",
			url: "/submit_sequence_lab",
			// 'form.serialize()+ '&sequence=' + sequence' is kind ugly but it works.
			data:  new FormData(this),
			contentType: false,
			cache: false,
			processData:false,

			beforeSend: function(xhr){

			},
			success: function(data){
				console.log("success");

			},
			error: function(data){

			}
		})
	})


})
