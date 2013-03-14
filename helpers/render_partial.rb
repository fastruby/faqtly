# Borrowed from Tanner Burson: http://github.com/tannerburson
# http://github.com/adamstac/sinatra-plugins/blob/master/render_partial.rb

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

    # Calculates the page title using a question. 
    # 
    # @param [Question,nil] 
    # @return [String] Page title
    def page_title(question = nil, tag = nil)
      if question
        title = question.question.to_s
      elsif tag
        title = "Preguntas Frecuentes: #{tag.name.to_s}."
      else
        title = "OmbuShop, Tu Tienda Online. Preguntas Frecuentes."
      end

      title
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