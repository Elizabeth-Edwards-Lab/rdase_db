$(document).ready(function(){


	$('#public-id').click(function () {
		$('#binding-domain').removeAttr('style');
		$('#public-id').attr('style',"display: none;");
	
	});

	$('#binding-domain').click(function () {
		$('#submit-interface').removeAttr('style');
		$('.container.decision-tree').attr('style',"display: none;");
	});

	$('#send-to-lab').click(function () {
		$('#submit-to-lab-interface').removeAttr('style');
		$('.container.decision-tree').attr('style',"display: none;");
	});

	
	// https://stackoverflow.com/questions/8423217/jquery-checkbox-checked-state-changed-event
	// detect if the checkbox is changed
	var upload_file_btn = $('#upload-file-btn');
	$("#upload-file-btn").change(function() {

		if( $('#upload-file-btn').get(0).files.length >= 1 ){
			// console.log("file uploaded");
			$('#upload-text').val('');
			$('#upload-text').attr('disabled', true);
			$('#upload-text').attr('placeholder', "File detected. To remove file, click 'Choose File', and click 'Cancel' without selecting anything. Disclaimer: We won't store your file at our database. ");
		}else{
			// console.log("file not uploaded");
			$('#upload-text').attr('disabled', false);
			$('#upload-text').removeAttr('placeholder');
		}
	});


	// this ajax request overwrite the rails default parameter passing
	$('#upload-seq').submit(function(e){
		e.preventDefault();
		var form = $(this);
		var formData = new FormData(this);
		console.log(formData);
		$.ajax({
			type:"POST",
			url: "/submit_sequence",
			// give the sequence back for generating new fasta file
			data: form.serialize(),
			beforeSend: function(){

				$('#upload-seq-result-table').empty();
				$('#p-submit-result').empty();
				$('#submit-seq-result-div').empty();
			},
			success: function(data){

				if(data.result != undefined){
					// console.log(data.result);
					$('#submit-seq-result-div').prepend("<h3 id=\"p-submit-result\">Result</h3>" + construct_table(data));

					var submit_form = `<form method="post" action="/save_sequence" id="save-seqeunce">
															<hr>
															Name: <input type="text" name="FirstName"><br>
															Email: <input type="text" name="Email"><br>
															<input value="Save To Database" type="submit" class="btn btn-primary" /><br>
															<input name="authenticity_token" type="hidden" value="<%= form_authenticity_token %>"/>
														</form>`

					$('#submit-seq-result-div').append(submit_form)

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
											</tr>";
		for(var i = 0; i < data.result.length; i++){
			header = data.result[i].header;
			status = data.result[i].status;
			msg    = data.result[i].msg;
			// if status is success, add some style, etc.
			table_content += `<tr>\
														<th>${header}</th>\
														<th>${status}</th>\
														<th>${msg}</th>\
												</tr>`;
		}
		table_content += "</table>";
		return table_content;
	}


	$('#save-seqeunce').submit(function(e){
		e.preventDefault();
		var form = $(this);
		$.ajax({
			type:"POST",
			url: "/save_sequence",
			// give the sequence back for generating new fasta file
			data: form.serialize(),
			beforeSend: function(xhr){
				// seems work without below line to avoid `Can't verify CSRF token authenticity rails`
				// xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
			},
			success: function(data){
				console.log(data)
			},
			error: function(data){
				$("#submit-message").text("Error occurs.");
			},
			timeout: 1000 * 60
		})
	});



	// submit sequence to lab part
	// This is not used anymore as we moved out the submit sequence as independent module

	$('#upload-seq-to-lab').submit(function(e){
		e.preventDefault();
		var form = $(this);
		$.ajax({
			type:"POST",
			url: "/submit_sequence_lab",
			// 'form.serialize()+ '&sequence=' + sequence' is kind ugly but it works.
			data: form.serialize(),
			success: function(data){
				console.log("success");
				console.log(data);

			},
			error: function(data){

			}
		})
	})


})
