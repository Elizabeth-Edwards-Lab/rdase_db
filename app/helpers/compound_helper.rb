module CompoundHelper

	def show_header(title, object, colspan=2)
	  name = title.gsub(/\W/, '_').downcase
	  "<tr id=\"#{name}\"><th class=\"divider\" colspan=\"#{colspan}\">#{title}</th></tr>".html_safe
	end

	def bio_link_out(site, id, name=nil, html_options=nil)
		name ||= "#{id}"

		if id.present?
			bio_link_to(name.html_safe, bio_url(site, id), html_options)
		end
	end

	def nah(value=nil, message="Not Available")
	  if value.present?
	    value.to_s.html_safe
	  else
	    "<span class='wishart wishart-not-available'>#{message}</span>".html_safe
	  end
	end

	def bio_url(site, id)
	  case site.to_sym
	    when :pubchem_compound             then "http://pubchem.ncbi.nlm.nih.gov/summary/summary.cgi?cid=#{id}"
	    when :pubchem_cid                  then "http://pubchem.ncbi.nlm.nih.gov/summary/summary.cgi?cid=#{id}"
	    when :pubchem_substance            then "http://pubchem.ncbi.nlm.nih.gov/summary/summary.cgi?sid=#{id}"
	    when :kegg_compound                then "http://www.genome.jp/dbget-bin/www_bget?cpd:#{id}"
	    when :kegg_drug                    then "http://www.genome.jp/dbget-bin/www_bget?drug:#{id}"
	    when :kegg_pathway                 then "http://www.genome.jp/kegg/pathway/map/#{id}.html"
	    when :kegg_reaction                then "http://www.genome.jp/dbget-bin/www_bget?rn:#{id}"
	    when :kegg_gene                    then "http://www.genome.jp/dbget-bin/www_bget?eco:#{id}"
	    when :kegg_map                     then "http://www.genome.jp/kegg/pathway/map/#{id}.html"
	    when :kegg_map_thumb               then "http://www.genome.jp/kegg/misc/thumbnail/map#{id.sub(/^\D*/, '')}.gif"
	    when :chebi                        then "http://www.ebi.ac.uk/chebi/searchId.do?chebiId=#{id}"
	    when :chembl                       then "http://www.ebi.ac.uk/chembldb/index.php/compound/inspect/#{id}"
	    when :uniprot                      then "http://www.uniprot.org/uniprot/#{id}"
	    when :genbank                      then "http://www.ncbi.nlm.nih.gov/entrez/viewer.fcgi?val=#{id}"
	    when :het                          then "http://www.ebi.ac.uk/pdbe-srv/pdbechem/chemicalCompound/show/#{id}"
	    when :wikipedia                    then "http://en.wikipedia.org/wiki/#{id}"
	    when :wiki                         then "http://en.wikipedia.org/wiki/#{id}"
	    when :pdb                          then "http://www.rcsb.org/pdb/explore.do?structureId=#{id}"
	    when :pdb_ligand                   then "http://www.rcsb.org/pdb/ligand/ligandsummary.do?hetId=#{id}"
	    when :hgnc                         then "http://www.genenames.org/data/hgnc_data.php?hgnc_id=#{id}"
	    when :genecard                     then "http://www.genecards.org/cgi-bin/carddisp.pl?gene=#{id}"
	    when :genatlas                     then "http://www.dsi.univ-paris5.fr/genatlas/fiche1.php?symbol=#{id}"
	    when :pubmed                       then "http://www.ncbi.nlm.nih.gov/pubmed/#{id}"
	    when :drugbank                     then "http://www.drugbank.ca/drugs/#{id}"
	    when :drugbank_metabolite          then "http://www.drugbank.ca/metabolites/#{id}"
	    when :hmdb                         then "http://www.hmdb.ca/metabolites/#{id}"
	    when :chemspider                   then "http://www.chemspider.com/Chemical-Structure.#{id}.html"
	    when :bindingdb                    then "http://www.bindingdb.org/bind/chemsearch/marvin/MolStructure.jsp?monomerid=#{id}"
	    when :stitch                       then "http://stitch-db.org/interactions/#{id}"
	    when :snpjam                       then "http://snpjam.wishartlab.com/genes/#{id}"
	    when :pfam                         then "http://pfam.sanger.ac.uk/family?acc=#{id}"
	    when :dbsnp                        then "http://www.ncbi.nlm.nih.gov/SNP/snp_ref.cgi?rs=#{id}"
	    when :biocyc                       then "http://biocyc.org/META/NEW-IMAGE?type=COMPOUND&object=#{id}"
	    when :ecocyc                       then "http://biocyc.org/ecoli/new-image?object=#{id}"
	    when :bigg                         then "http://bigg1.ucsd.edu/bigg/view3.pl?type=metabolite&id=#{id}&model=1461534,2795088,3277493,3409217,3307911,222668,1823466,3473243,2423527,2247625"
	    when :nugo                         then "http://www.nugowiki.org/index.php/#{id}"
	    when :metagene                     then "http://www.metagene.de/program/d.prg?Accession_No=#{id}"
	    when :omim                         then "http://omim.org/entry/#{id}"
	    when :phenol_metabolite            then "http://www.phenol-explorer.eu/metabolites/#{id}"
	    when :phenol_compound              then "http://www.phenol-explorer.eu/compounds/#{id}"
	    when :foodb                        then "http://foodb.ca/" #fix when foodb goes public
	    when :foodb_compound               then "http://foodb.ca/compounds/#{id}"
	    when :afcdb_compound               then "http://afcdb.ca/compounds/#{id}"
	    when :knapsack                     then "http://kanaya.naist.jp/knapsack_jsp/result.jsp?sname=all&word=#{id}"
	    when :metlin                       then "http://metlin.scripps.edu/metabo_info.php?molid=#{id}"
	    when :golm                         then "http://gmd.mpimp-golm.mpg.de/Analytes/#{id}.aspx"
	    when :open_isbn                    then "http://www.openisbn.com/isbn/#{id}"
	    when :textbook                     then "http://www.google.com/search?tbo=p&tbm=bks&q=#{id}"
	    when :ttd                          then "http://bidd.nus.edu.sg/group/cjttd/ZFTTDDRUG.asp?ID=#{id}"
	    when :pharmgkb                     then "http://www.pharmgkb.org/drug/#{id}"
	    when :dpd                          then "http://webprod5.hc-sc.gc.ca/dpd-bdpp/info.do?code=#{id}&lang=eng"
	    when :rxlist                       then "#{id}"
	    when :pdrhealth                    then "#{id}"
	    when :drugs_dot_com                then "#{id}"
	    when :dailymed                     then "http://dailymed.nlm.nih.gov/dailymed/lookup.cfm?ndc=#{id}"
	    when :iuphar_ligand                then "http://www.iuphar-db.org/DATABASE/LigandDisplayForward?ligandId=#{id}"
	    when :guide_to_pharma_ligand       then "http://www.guidetopharmacology.org/GRAC/LigandDisplayForward?ligandId=#{id}"
	    when :iuphar_protein               then "http://www.iuphar-db.org/DATABASE/ObjectDisplayForward?objectId=#{id}"
	    when :guide_to_pharma_protein      then "http://www.guidetopharmacology.org/GRAC/FamilyDisplayForward?familyId=#{id}"
	    when :google_patent_search         then "https://www.google.com/?tbm=pts#q=#{id}&tbm=pts"
	    when :google_patent                then "https://patents.google.com/patent/#{id}"
	    when :dfcd                         then "http://www.foodcomp.dk/v7/fcdb_details.asp?FoodId=#{id}"
	    when :ecocyc_pathway               then "http://ecocyc.org/ECOLI/NEW-IMAGE?type=PATHWAY&object=#{id}"
	    when :ecocyc_pathway_thumb         then "http://ecocyc.org/tmp/ptools-images/ECOLI/#{id}_PWY-DIAGRAM.gif"
	    when :ecocyc_compound              then "http://ecocyc.org/ECOLI/NEW-IMAGE?type=COMPOUND&object=#{id}"
	    when :ligand_expo                  then "http://ligand-expo.rcsb.org/reports/2/#{id}/index.html"
	    when :ccdb                         then "http://ccdb.wishartlab.com/CCDB/cgi-bin/ECARD_HTML_NEW.cgi?ECARD=#{id}.ecard&Coli+Card=ColiCard"
	    when :brenda                       then "http://www.brenda-enzymes.info/php/result_flat.php4?ecno=#{id}&Suchword=&organism%5B%5D=Escherichia+coli&show_tm=0"
	    when :ecogene                      then "http://www.ecogene.org/geneInfo.php?eg_id=#{id}"
	    when :colibase                     then "http://www.xbase.ac.uk/genome/escherichia-coli-str-k-12-substr-mg1655/NC_000913/#{id};thrL/viewer"
	    when :ecobase                      then "http://www.york.ac.uk/res/thomas/Gene.cfm?recordID=#{id}"
	    when :bacmap                       then "http://bacmap.wishartlab.com/cgi/getGeneCard.cgi?accession=NC_000913&id=#{id}"
	    when :ctd                          then "http://ctdbase.org/detail.go?type=chem&acc=#{id}"
	    when :ncbi_protein                 then "http://www.ncbi.nlm.nih.gov/protein/#{id}"
	    when :ncbi_cdna                    then "http://www.ncbi.nlm.nih.gov/nuccore/#{id}"
	    when :ncbi_gene                    then "http://www.ncbi.nlm.nih.gov/gene/#{id}"
	    when :dfc                          then "http://ccd.chemnetbase.com/AAA00.entry?parentCHNumber=#{id}"
	    when :duke, :duke_nutrient         then "http://sun.ars-grin.gov:8080/npgspub/xsql/duke/chemdisp.xsql?chemical=#{id}"
	    when :knapsack, :knapsack_nutrient then "http://kanaya.naist.jp/knapsack_jsp/information.jsp?word=#{id}"
	    when :eafus                        then "http://www.accessdata.fda.gov/scripts/fcn/fcnDetailNavigation.cfm?rpt=eafusListing&id=#{id}"
	    when :flavornet                    then "http://www.flavornet.org/info/#{id}.html"
	    when :goodscent                    then "http://www.thegoodscentscompany.com/data/#{id}.html"
	    when :superscent                   then "http://bioinf-applied.charite.de/superscent/src/fullinfo.php?cas=#{id}"
	    when :itis                         then "http://www.itis.gov/servlet/SingleRpt/SingleRpt?search_topic=TSN&search_value=#{id}"
	    when :pathwhiz                     then "http://smpdb.ca/pathwhiz/pathways/#{id}"
	    when :pathwhiz_greyscale           then "http://smpdb.ca/pathwhiz/pathways/#{id}?image_type=greyscale"
	    when :pathwhiz_simple              then "http://smpdb.ca/pathwhiz/pathways/#{id}?image_type=simple"
	    when :pathwhiz_thumb               then "http://smpdb.ca/super_pathway_visualizations/#{id}/thumb"
	    when :pathwhiz_thumb_greyscale     then "http://smpdb.ca/super_pathway_visualizations/#{id}/thumb?image_type=greyscale"
	    when :pathwhiz_thumb_simple        then "http://smpdb.ca/super_pathway_visualizations/#{id}/thumb?image_type=simple"
	    when :smpdb                        then "http://smpdb.ca/view/#{id}"
	    when :smpdb_greyscale              then "http://smpdb.ca/view/#{id}?image_type=greyscale"
	    when :smpdb_simple                 then "http://smpdb.ca/view/#{id}?image_type=simple"
	    when :smpdb_thumb                  then "http://smpdb.ca/super_pathway_visualizations/#{id}/thumb"
	    when :smpdb_thumb_greyscale        then "http://smpdb.ca/super_pathway_visualizations/#{id}/thumb?image_type=greyscale"
	    when :smpdb_thumb_simple           then "http://smpdb.ca/super_pathway_visualizations/#{id}/thumb?image_type=simple"
	    when :phenolexplorer_nutrient      then "http://www.phenol-explorer.eu/contents/total?compound_id=#{id}"
	    when :phenolexplorer_food          then "http://www.phenol-explorer.eu/contents/total?food_id=#{id}"
	    when :dtu_food                     then "http://www.foodcomp.dk/v7/fcdb_details.asp?FoodId=#{id}"
	    when :dtu_nutrient                 then "http://www.foodcomp.dk/v7/fcdb_foodnutrlist.asp?CompId=#{id}"
	    when :duke_food                    then "http://sun.ars-grin.gov:8080/npgspub/xsql/duke/plantdisp.xsql?taxon=#{id}"
	    when :usda_food, :usda_nutrient    then "http://www.nal.usda.gov/fnic/foodcomp/search/"
	    when :phenolexplorer_metabolite    then "http://www.phenol-explorer.eu/metabolites/#{id}"
	    when :massbank                     then "http://www.massbank.jp/jsp/FwdRecord.jsp?id=#{id}"
	    when :sgd                          then "http://www.yeastgenome.org/cgi-bin/locus.fpl?locus=#{id}"
	    when :sdbs                         then "http://sdbs.db.aist.go.jp/sdbs/cgi-bin/direct_frame_disp.cgi?sdbsno=#{id}"
	    when :nist                         then "http://webbook.nist.gov/cgi/cbook.cgi?ID=#{id}"
	    when :classyfire_tax_node          then "http://classyfire.wishartlab.com/tax_nodes/#{id}"
	    when :lipidmaps_compound           then "http://www.lipidmaps.org/data/LMSDRecord.php?LMID=#{id}"
	    when :metacyc_compound             then "http://metacyc.org/META/new-image?type=COMPOUND&object=#{id}"
	    when :ecmdb                        then "http://www.ecmdb.ca/compounds/#{id}"
	    when :mona_spectrum                then "http://mona.fiehnlab.ucdavis.edu/#/spectra/display/#{id}"
	    when :mona_splash                  then "http://mona.fiehnlab.ucdavis.edu/#/spectra/splash/#{id}"
	    when :ymdb                         then "http://www.ymdb.ca/compounds/#{id}"
	    when :unii                         then "http://fdasis.nlm.nih.gov/srs/srsdirect.jsp?regno=#{id}"
	    when :lmdb                         then "http://lmdb.ca/metabolites/#{id}"
	    when :bmdb                         then "http://bmdb.wishartlab.com/metabolites/#{id}"
	    when :gnps_library                 then "https://gnps.ucsd.edu/ProteoSAFe/gnpslibraryspectrum.jsp?SpectrumID=#{id}#{}"
	    when :bmrb                         then "http://bmrb.wisc.edu/metabolomics/mol_summary/show_data.php?id=#{id}"
	    else                               raise ArgumentError, "given site [#{site}, #{id}] does not exist"
	  end
	end
	
	# Link to the ChemAxon website based on the given property
	def bio_link_to_chemaxon(property)
	  url = nil
	  base = 'http://www.chemaxon.com/products/calculator-plugins'
	  case property.to_sym
	    when :logp                  then  url = "#{base}/property-predictors/#logp_logd"
	    when :pka                   then  url = "#{base}/property-predictors/#pka"
	    when :ha_count              then  url = "#{base}/property-calculations/#h_bond"
	    when :hd_count              then  url = "#{base}/property-calculations/#h_bond"
	    when :psa                   then  url = "#{base}/property-calculations/#topolgical_surface"
	    when :rb_count              then  url = "#{base}/property-calculations/#topology_analysis"
	    when :refractivity          then  url = "#{base}/property-calculations/#refractivity"
	    when :polarizability        then  url = "#{base}/molecular-modelling/#polarization"
	    when :formal_charge         then  url = "#{base}/molecular-modelling/#polarization"
	    when :physiological_charge  then  url = "#{base}/molecular-modelling/#polarization"
	    else                        raise ArgumentError, "given site does not exist"
	  end

	  link_to('ChemAxon', url)
	end

	# def moldb_properties_table(record)
	#   render partial: '/views/compound/properties_table', locals: { record: record }
	# end



end
