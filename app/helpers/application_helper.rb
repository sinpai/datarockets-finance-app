module ApplicationHelper
  def will_paginate(collection_or_options = nil, options = default_paginate_options)
    if collection_or_options.is_a? Hash
      options = collection_or_options
      collection_or_options = nil
    end
    options = options.merge renderer: BootstrapPagination::Rails unless options[:renderer]
    super *[collection_or_options, options].compact
  end

  private

  def default_paginate_options
    {renderer: WillPaginate::ActionView::Bootstrap4LinkRenderer}
  end
end
