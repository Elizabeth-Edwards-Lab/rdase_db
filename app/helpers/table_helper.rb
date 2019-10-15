module TableHelper
  def table_header_divider(title, options={}, &block)
    options[:colspan] ||= 2
    options[:id] ||= title.to_s.parameterize

    content_tag(:tr, id: options[:id]) do
      content_tag(:th, class: 'divider', colspan: options[:colspan]) do
        block_given? ? block.call : title
      end
    end
  end
    
 def table_search_actions
    content_tag(:div, class: 'search-buttons') do
      button_tag(glyphicon(:search), 
                 type: 'submit', class: 'table-search-submit btn btn-xs btn-primary') << ' ' <<
      link_to('Clear', request.path, id: 'table-search-reset', class: 'btn btn-default btn-xs')
    end
  end  

  def index_search_text(field, *args)
    params[:q] = {} if params[:q].blank?

    options = args.extract_options!
    options[:class] ||= ''
    options[:class] << "form-control input-tbl-search"

    text_field_tag "q[#{field}]", 
      params[:q][field],
      *(args << options)
  end

  def index_search_select(field, select_options, *args)
    options = args.extract_options!
    options[:class] ||= ''
    options[:class] << "form-control input-tbl-search"
    options[:include_blank] = true

    select_tag "q[#{field}]", 
      options_for_select(select_options, params[:q][field]), 
      *(args << options)
  end

  def table_search_text(form, query, *args)
    options = args.extract_options!
    options[:class] ||= ''
    options[:class] << "form-control input-tbl-search"

    form.text_field query, *(args << options)
  end

  def table_search_select(form, field, select_options, options={}, *args)
    options[:include_blank] ||= true
    html_options = args.extract_options!
    html_options[:class] ||= ''
    html_options[:class] << "form-control input-tbl-search"

    form.select field, 
      select_options,
      options,
      *(args << html_options)
  end

  def fontawesome(kind)
    content_tag(:span, ' ', class: "#{kind.to_s.dasherize}")
  end

  def glyphicon(kind)
    content_tag(:span, ' ', class: "glyphicon glyphicon-#{kind.to_s.dasherize}")
  end

  def table_sort_link(title, column, options = {})
    condition = options[:unless] if options.has_key?(:unless)
    sort_dir = params[:d] == 'up' ? 'down' : 'up'

    icon = ''
    if column.to_s == params[:c]
      # icon = params[:d] == 'up' ? glyphicon('circle-arrow-up') : glyphicon('circle-arrow-down')
      # <i class="fas fa-sort-up"></i>
      icon = params[:d] == 'up' ? fontawesome('fas fa-sort-up') : fontawesome('fas fa-sort-down')
    else
      icon = fontawesome('fas fa-sort-up')
    end
    
    link_to_unless(condition, title.html_safe, 
                   request.parameters.merge({ c: column, d: sort_dir }), 
                   rel: "nofollow", 
                   class: 'sort-link') << " #{icon}".html_safe
  end  
end



