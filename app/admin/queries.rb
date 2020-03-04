ActiveAdmin.register Query do
  permit_params :sequence, :query_range_up, :query_range_down, :job_title, :database, :organism, :report_format, :algorithm, :email, :file_upload
  
end
