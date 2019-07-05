Rails.application.routes.draw do


	


	# static routes
	get 'statistics' => 'simple#statistics', as: :statistics
	get 'downloads' => 'simple#downloads', as: :downloads
	get 'contact'  => 'simple#contact', as: :contact
	get 'citation' => 'simple#citation', as: :cite
	get 'other_database' => 'simple#other_database', as: :other_database
	get 'help' => 'simple#help', as: :help


	match "search" => 'query#search',
		as: :search,
		via: [:get, :post]
	match "submit_sequence" => 'query#submit_sequence',
		as: :submit_sequence,
		via: [:post]
	


	resources :protein, only: [:show, :index] do
		
	end

	root to: 'query#search'

end
