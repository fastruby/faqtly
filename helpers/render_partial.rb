# encoding: utf-8
module Faqtly
  module RenderPartial
    def url_path(*path_parts)
      [path_prefix, path_parts].join('/').squeeze('/')
    end

    alias_method :u, :url_path

    def path_prefix
      request.env['SCRIPT_NAME']
    end

    def partial(page, options={})
      haml page, options.merge!(layout: false), options[:locals]
    end

    # Returns the previous and next links if necessary. 
    # 
    # It uses `request.path`; params[:page] and opts[:scope]
    # to determine the result.
    #
    # @return [String] HTML with previous, next links
    def pagination(opts = {})
      result = ""
      scope = opts[:scope] || Question


      if scope && (size = scope.page_count) > 1
        page = (params[:page] || 1).to_i

        if page > 1

          result += partial :'shared/_previous', locals: {page: page}

          if page != size
            result += partial :'shared/_next', locals: {page: page}
          end
        else
          if size > 1
            result += partial :'shared/_next', locals: {page: page}
          end
        end

        result = "<div class='pagination'>#{result}</div>"
      end

      result
    end

  end
end