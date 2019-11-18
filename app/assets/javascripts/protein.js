$(document).ready(function(){


	var predictedPH = writeProtIep("AAAAAAA");
	var data = $('.protein_s_chain').data("proteinchain");
	
	if (data != undefined){
		$('#ppi-emboss').text(writeProtIep(data));
	}
	function writeProtIep(proteinSequence){
	    var pH = 7.0;
	    var step = 3.5;
		var charge = 0.0;
	    var last_charge = 0.0;

		var N_term_pK = 8.6;
		var K_pK = 10.8;
		var R_pK = 12.5;
		var H_pK = 6.5;
		var D_pK = 3.9;
		var E_pK = 4.1;
		var C_pK = 8.5;
		var Y_pK = 10.1;
		var C_term_pK = 3.6;

		var K_count = 0;
		if (proteinSequence.search(/k/i) != -1)	{
			K_count = ((proteinSequence.match(/k/gi)).length);	
		}
		var R_count = 0;
		if (proteinSequence.search(/r/i) != -1)	{
			R_count = ((proteinSequence.match(/r/gi)).length);	
		}
		var H_count = 0;
		if (proteinSequence.search(/h/i) != -1)	{
			H_count = ((proteinSequence.match(/h/gi)).length);	
		}
		var D_count = 0;
		if (proteinSequence.search(/d/i) != -1)	{
			D_count = ((proteinSequence.match(/d/gi)).length);	
		}
		var E_count = 0;
		if (proteinSequence.search(/e/i) != -1)	{
			E_count = ((proteinSequence.match(/e/gi)).length);	
		}
		var C_count = 0;
		if (proteinSequence.search(/c/i) != -1)	{
			C_count = ((proteinSequence.match(/c/gi)).length);	
		}
		var Y_count = 0;
		if (proteinSequence.search(/y/i) != -1)	{
			Y_count = ((proteinSequence.match(/y/gi)).length);	
		}

		while(1) {
			charge =  partial_charge(N_term_pK, pH) + 
					K_count * partial_charge(K_pK, pH) + 
					R_count * partial_charge(R_pK, pH) + 
					H_count * partial_charge(H_pK, pH) - 
					D_count * partial_charge(pH, D_pK) - 
					E_count * partial_charge(pH, E_pK) - 
					C_count * partial_charge(pH, C_pK) - 
					Y_count * partial_charge(pH, Y_pK) - 
					partial_charge(pH, C_term_pK);

			if ((charge).toFixed(2) == (last_charge*100).toFixed(2)) {
				break;
			}

			if (charge > 0) {
				pH = pH + step;
			}
			else {
				pH = pH - step;
			}

			step = step / 2;
		
			last_charge = charge

		}

		pH = pH.toFixed(2);

		r_val = `${pH} pH`

		return r_val;
	}

	function partial_charge (first, second) {
		var charge = Math.pow(10, (first - second));
		return charge / (charge + 1);
	}

})

function openWindowAlign (title) {
	return _openWindowAlign(title, true);
}


function _openWindowAlign (title, isBackground) {

	outputWindow=window.open("","my_new_window","toolbar=no, location=no, directories=no, status=yes, menubar=yes, scrollbars=yes, resizable=yes, copyhistory=no, width=800, height=400");
	outputWindow.focus();
	outputWindow.document.write ("<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n" +
			             "<html lang=\"en\">\n" +
				     "<head>\n" +
                                     "<title>Amino Acid Sequence Statistics</title>\n" +                         
                                     "<meta http-equiv=\"Content-Type\" content=\"text/html; charset=ISO-8859-1\" />\n");
	if (isBackground) {
        outputWindow.document.write ("<style type=\"text/css\">\n" +
				     "body.main {font-family: arial, sans-serif; font-size:90%; color: #000000; background-color: #FFFFFF}\n" +
			             "div.pre {color: #000000; font-family: courier, sans-serif; white-space: pre}\n" +
				     "div.title {color: #000000; text-align: left; background-color: #FFFFFF}\n" +
				     "div.info {font-weight: bold}\n" +	
 				     "span.ident {color: #FFFFFF; background-color: #000000}\n" +
				     "span.sim {color: #FFFFFF; background-color: #666666}\n" +
				     "span.g, span.a, span.v, span.l, span.i {color: #000000; background-color: #C0C0C0}\n" +
				     "span.f, span.y, span.w {color: #000000; background-color: #FF6600}\n" +
			             "span.c, span.m {color: #000000; background-color: #FFFF00}\n" +
				     "span.s, span.t {color: #000000; background-color: #66FF00}\n" +
				     "span.k, span.r, span.h {color: #000000; background-color: #FF0000}\n" +
				     "span.d, span.e {color: #000000; background-color: #0066FF}\n" +
				     "span.n, span.q {color: #000000; background-color: #996633}\n" +
			             "span.p {color: #000000; background-color: #FF99FF}\n" +
				     "</style>\n");
	}
	else {
        outputWindow.document.write ("<style type=\"text/css\">\n" +
				     "body.main {font-family: arial, sans-serif; font-size:90%; color: #000000; background-color: #FFFFFF}\n" +
			             "div.pre {color: #000000; font-family: courier, sans-serif; white-space: pre}\n" +
				     "div.title {display: none}\n" +
				     "div.info {font-weight: bold}\n" +	
 				     "span.ident {color: #000000; font-weight: bold; text-decoration: underline; background-color: #FFFFFF}\n" +
				     "span.sim {color: #000000; font-weight: bold; background-color: #FFFFFF}\n" +
				     "span.diff {color: #999999; background-color: #FFFFFF}\n" +
				     "span.g, span.a, span.v, span.l, span.i {color: #CC33CC; background-color: #FFFFFF}\n" +
				     "span.f, span.y, span.w {color: #FF6600; background-color: #FFFFFF}\n" +
			             "span.c, span.m {color: #FFCC00; background-color: #FFFFFF}\n" +
				     "span.s, span.t {color: #CCFF00; background-color: #FFFFFF}\n" +
				     "span.k, span.r, span.h {color: #FF0000; background-color: #FFFFFF}\n" +
				     "span.d, span.e {color: #0000FF; background-color: #FFFFFF}\n" +
				     "span.n, span.q {color: #996633; background-color: #FFFFFF}\n" +
			             "span.p {color: #00FFCC; background-color: #FFFFFF}\n" +
				     "img {display: none}\n" +
				     "</style>\n");
	}
        outputWindow.document.write ("</head>\n" +
                                     "<body class=\"main\">\n" +
                                     "<div class=\"title\"></div>\n");
	outputWindow.status = 'Please Wait.';

	return outputWindow;
}



// include this function in assests
// itemsToCheck are regular expressions. A number included with each regular expression serves as an adjustment for the percentage calculation. Any additional text will appear next to the pattern when the results are given.
function writeSequenceStats (sequence)	{	
	
	var outputWindow = openWindowAlign("Sequence Statistics");

	var itemsToCheck = ["/A/ (A)1", "/B/ (B)1", "/C/ (C)1", "/D/ (D)1", "/E/ (E)1", "/F/ (F)1", "/G/ (G)1", "/H/ (H)1", 
						"/I/ (I)1", "/K/ (K)1", "/L/ (L)1", "/M/ (M)1", "/N/ (N)1", "/P/ (P)1", "/Q/ (Q)1", "/R/ (R)1", 
						"/S/ (S)1", "/T/ (T)1", "/V/ (V)1", "/W/ (W)1", "/X/ (X)1", "/Y/ (Y)1", "/Z/ (Z)1", "/[GAVLI]/ (Aliphatic G,A,V,L,I)1", 
						"/[FWY]/ (Aromatic F,W,Y)1", "/[CM]/ (Sulphur C,M)1", "/[KRH]/ (Basic K,R,H)1", "/[BDENQZ]/ (Acidic B,D,E,N,Q,Z)1", 
						"/[ST]/ (Aliphatic hydroxyl S,T)1", "/[ZEQRCMVILYW]/ (tRNA synthetase class I Z,E,Q,R,C,M,V,I,L,Y,W)1", 
						"/[BGAPSTHDNKF]/ (tRNA synthetase class II B,G,A,P,S,T,H,D,N,K,F)1"];

	var originalLength = sequence.length;

	outputWindow.document.write ('<table border="1" width="100%" cellspacing="0" cellpadding="2"><tbody>\n');	
	outputWindow.document.write ('<tr><td class="title">' + 'Pattern:' + '</td><td class="title">' + 'Times found:' + 
		'</td><td class="title">' + 'Percentage:' + '</td></tr>\n');	
	
	for (var i = 0; i < (itemsToCheck.length); i++)	{
		var tempNumber = 0;
		var matchExp = itemsToCheck[i].match(/\/[^\/]+\//) + "gi";
		
		matchExp = eval(matchExp);
		if (sequence.search(matchExp) != -1)	{
			tempNumber = ((sequence.match(matchExp)).length);
		}
		var percentage = 0;

		if ((originalLength + 1 - parseFloat(itemsToCheck[i].match(/\d+/))) > 0) {
			percentage = (100 * tempNumber/(originalLength + 1 - parseFloat(itemsToCheck[i].match(/\d+/))));
		}

		outputWindow.document.write ('<tr><td>' + ((itemsToCheck[i].match(/\([^\(]+\)\b/)).toString()).replace(/\(|\)/g,"") + 
			'</td><td>' + tempNumber + '</td><td>' + percentage.toFixed(2) + '</td></tr>\n');
	}

	outputWindow.document.write('</tbody></table>\n');

	return true;
}




function writeFASTA(sequence, header, accession_no, organism){
	outputWindow=window.open("","my_new_window","toolbar=no, location=no, directories=no, status=yes, menubar=yes, \
		scrollbars=yes, resizable=yes, copyhistory=no, width=800, height=400");
	outputWindow.focus();
	var sequence_br = 60;
	var fasta_header = `>${header} | ${accession_no} | ${organism} |`
	var fasta_chain = `${sequence.charAt(0)}`;
	for(var i = 1; i < sequence.length; i++){
		if(i%sequence_br != 0){
			fasta_chain += sequence.charAt(i);
		}else{
			fasta_chain += `${sequence.charAt(i)}\n` 
		}
	}
	fasta = `${fasta_header}\n${fasta_chain}`
	outputWindow.document.write(`<title>FASTA</title><div>${fasta}</div>`)
	return true;
}




