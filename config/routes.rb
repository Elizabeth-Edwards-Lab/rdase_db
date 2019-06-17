Rails.application.routes.draw do


	


	# Named routes
	get 'about' => 'simple#about', as: :about
	# get 'release-notes' => 'simple#release_notes', as: :release_notes
	# get 'citing' => 'simple#citing', as: :citing
	# get 'news' => 'simple#news', as: :news
	get 'statistics' => 'simple#statistics', as: :statistics
	# get 'sources' => 'simple#sources', as: :sources
	get 'downloads' => 'simple#downloads', as: :downloads
	get 'contact'  => 'simple#contact', as: :contact
	get 'help' => 'simple#help', as: :help
	# get 'textquery' => 'simple#textquery', as: :textquery



	match "search" => 'query#search',
		as: :search,
		via: [:get, :post]

	root to: 'query#search'
end
