Rails.application.routes.draw do


	


	# static routes
	get 'about' => 'simple#about', as: :about
	get 'statistics' => 'simple#statistics', as: :statistics
	get 'downloads' => 'simple#downloads', as: :downloads
	get 'contact'  => 'simple#contact', as: :contact
	get 'citation' => 'simple#citation', as: :cite
	get 'other_database' => 'simple#other_database', as: :other_database



	match "search" => 'query#search',
		as: :search,
		via: [:get, :post]

	resources :proteins, only: [:show, :index] do
		
	end

	root to: 'query#search'

end
