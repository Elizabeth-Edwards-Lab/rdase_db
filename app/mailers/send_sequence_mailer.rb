class SendSequenceMailer < ApplicationMailer

	# default :from => 'non-reply@reductivedehalogenasedb.ca'


	# # to invoke following method: SendSequenceMailer.send_submit_mail(parameters...).deliver
	# # Send mail to our lab
 #  def send_submit_mail(username, email, lab_email, aa_sequence, nt_sequence, comment)
 #  	@username = username
 #  	@email = email
 #  	@aa_sequence = aa_sequence
 #  	@nt_sequence = nt_sequence
 #  	@comment = comment
 #    mail( :to => lab_email, :subject => 'New Sequence Submission (ReductiveDehalogenaseDB)' )
 #  end


 #  # send the mail to user after the sequence has been successful add to database
 #  def send_confirm_mail(username,email)
 #  	@username = username
 #  	mail( :to => email, :subject => 'Thanks for submitting your sequence! (ReductiveDehalogenaseDB)' )
 #  end


end
