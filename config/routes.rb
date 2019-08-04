Rails.application.routes.draw do





	# static routes
	get 'statistics' => 'simple#statistics', as: :statistics
	get 'downloads' => 'simple#downloads', as: :downloads
	get 'contact'  => 'simple#contact', as: :contact
	get 'citation' => 'simple#citation', as: :cite
	get 'about' => 'simple#about', as: :about
	get 'other_database' => 'simple#other_database', as: :other_database
	get 'help' => 'simple#help', as: :help
	get 'home' => 'simple#home', as: :home



	# download route
	get "simple/download_aa_original"
	get "simple/download_nt_original"
	get "simple/download_aa_cus"
	get "simple/download_nt_cus"

	match "search" => 'query#search',
		as: :search,
		via: [:get, :post]
	match "submit_sequence" => 'query#submit_sequence',
		as: :submit_sequence,
		via: [:post]
	match "phylogenetic_tree" => 'query#phylogenies',
		as: :phylogenetic_tree,
		via: [:post]



	resources :protein, only: [:show, :index] do

	end

	root to: 'simple#home'

end
