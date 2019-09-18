module SortParamsParser
  extend ActiveSupport::Concern

  ALLOWED_DIRECTIONS = ['up','down'].freeze
  ALLOWED_OPTIONS    = [:default_column, :default_order].freeze

  def parse_sort_params(sortable_columns=[], options={})
    default_column = options[:default_column] || sortable_columns.first
    default_order  = options[:default_order]  || 'up'
    return if sortable_columns.blank?

    # Order by Column
    @c =
      if params[:c].present? && sortable_columns.map(&:to_sym).include?(params[:c].to_sym)
        params[:c]
      else
        params[:c] = default_column.to_s
      end

    # Order descending or ascending
    @d =
      if ALLOWED_DIRECTIONS.include?(params[:d])
        params[:d]
      else
        params[:d] = default_order.to_s
      end

    @sorted_column = @c
    @sorted_order  = @d == 'down' ? 'DESC' : 'ASC'
  end

  module ClassMethods
    def parse_sort_params(sortable_columns=[], options={})
      parse_options = options.slice(*ALLOWED_OPTIONS)
      ALLOWED_OPTIONS.each { |key| options.delete(key) }

      before_action(options) do
        parse_sort_params(sortable_columns, parse_options)
      end
    end
  end
end
