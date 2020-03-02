ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel "Info" do
          para "Welcome to the RDaseDB Admin Interface and Dashboard."
        end
      end      
      column do
        panel "Recent Submissions" do
          table do
            thead do
              th 'Protein Sequence'
              th 'Uploader'
              th 'Uploader Name'
              th 'Uploader Email'
              th 'Uploaded'
            end
            tbody do
              CustomizedProteinSequence.last(10).reverse.map do |post|
                tr do
                  td link_to(post.header, admin_protein_sequence_path(post))
                  td post.uploader
                  td post.uploader_name
                  td post.uploader_email
                  td time_ago_in_words(post.updated_at) + " ago"
                end
              end
            end
          end
        end
      end
    end
  end # content
end
