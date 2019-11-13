module AutomaticRetrieveSeq


	# retrieve the sequence and save to fasta file
	# at this point, we only retrieve aa sequence
	def perform_retrieve
		key_word = ["reductive dehalogenase[Protein Name]"]
		retrieve_fasta_name = Array.new
		key_word.each do |keyw|
			"https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi?db=protein&term=reductive dehalogenase[Protein Name]&usehistory=y"
			url_with_date = "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi?
											db=protein&term=#{keyw}&reldate=1&datetype=mdat&usehistory=y"
			req = open(url_with_date)

			if ncbi_res.status.include? "200"
			  doc = Nokogiri::XML(req.read)
			  if doc.xpath('//ERROR').length != 0 
			  	maxCound = doc.xpath("//Count").children.text
			  	queryKey = doc.xpath("//QueryKey").children.text
			  	start    = doc.xpath("//RetStart").children.text
			  	webEnv   = doc.xpath("//WebEnv").children.text
			  	retrieve_fasta = open("https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?
										db=protein&WebEnv=#{webEnv}&query_key=#{queryKey}&rettype=fasta&retmode=text&retstart=#{start}&retmax=#{maxCound}")
			  	if retrieve_fasta.read.length != 0
			  		fasta = File.write("tmp/tmp_fasta/#{test_fasta}.fasta",fasta)
			  		retrieve_fasta_name << "tmp/tmp_fasta/#{test_fasta}.fasta"
			  	end
			  end

			end 

		end


		return retrieve_fasta
	end



	def annotate_retrieved_fasta

		retrieve_fasta = perform_retrieve
		
		if retrieve_fasta.length != 0
			
		end


	end

end