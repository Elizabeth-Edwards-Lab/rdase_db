module SeqSummarizer
	extend ActiveSupport::Concern


	# Test concern function in rail console
	# controller = ActionController::Base::ApplicationController.new.extend(SeqSummarizer)
	# controller.calculateIsoelectricPoint "MEKKKKPELSRRDFGKLIIGAGAAATIAP"
	
	# This function doesn't produce same result as Javascript even though the logic is same;
	# probably caused by float bit between two languages;
	def calculateIsoelectricPoint(proteinSequence)		
		# https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5075173/ => paper about which pK values to use 
		n_term_pK = 8.6
		k_pK = 10.8
		r_pK = 12.5
		h_pK = 6.5
		d_pK = 3.9
		e_pK = 4.1
		c_pK = 8.5
		y_pK = 10.1
		c_term_pK = 3.6

		# count the PEPTIDE
		k_count = proteinSequence.scan("K").count;
		r_count = proteinSequence.scan("R").count;
		h_count = proteinSequence.scan("H").count;
		d_count = proteinSequence.scan("D").count;
		e_count = proteinSequence.scan("E").count;
		c_count = proteinSequence.scan("C").count;
		y_count = proteinSequence.scan("Y").count;


		pH = 7.0
		step = 3.5
		charge = 0.0
		last_charge = 0.0

		while true
			charge  =  (partial_charge(n_term_pK, pH) + (k_count * partial_charge(k_pK, pH)) 
							+ (r_count * partial_charge(r_pK, pH)) + (h_count * partial_charge(h_pK, pH)) 
							- (d_count * partial_charge(pH, d_pK)) - (e_count * partial_charge(pH, e_pK))
							- (c_count * partial_charge(pH, c_pK)) - (y_count * partial_charge(pH, y_pK))
							- (partial_charge(pH, c_term_pK)))
			break
			if charge.round(2) == (last_charge*100).round(2)
				break
			end

			if charge > 0
				pH = pH + step
			else 
				pH = pH - step
			end


			step = step / 2
		
			last_charge = charge

		end

		pH = pH.round(2);

		return pH 

	end



	def calculateMolecularWeight(proteinSequence)
		
		molecularWeight = {'A': 71.08, 
											"C": 103.14,
											"D": 115.09,
											"E": 129.12,
											"F": 147.18, 
											"G": 57.06, 
											"H": 137.15, 
											"I": 113.17, 
											"K": 128.18, 
											"L": 113.17, 
											"M": 131.21, 
											"N": 114.11, 
											"P": 97.12, 
											"Q": 128.41, 
											"R": 156.20, 
											"S": 87.08, 
											"T": 101.11, 
											"V": 99.14, 
											"W": 186.21, 
											"Y": 163.18}

		water  = 18.015;
		result = 0.0;
		proteinSequence.split("").each do |pep|

			if molecularWeight[pep.to_sym].nil?
				next
			else
				result += molecularWeight[pep.to_sym]
			end
		end

		if result != 0.0
			result += water # add the weight of water for the ends of the protein.
			result /= 1000.0
			result = result.round(2);
		end

		return result # in kDa

	end



	def partial_charge(first, second)
		charge = 10.pow(first - second)
		final_charge = charge / (charge + 1)
		return final_charge
	end
end









