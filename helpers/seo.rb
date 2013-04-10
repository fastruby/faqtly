# encoding: utf-8
module Faqtly
  module SEO

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

    # Calculates the page meta tags for SEO.
    #
    # @return [String] Description value
    def meta_description
      result = ''
      if @question
        result += "#{@question.question} #{@question.answer}"
      elsif @tag
        result += "Preguntas sobre #{@tag.name}"
      elsif @questions
        result += "Preguntas sobre OmbuShop: " 
        result += @questions.map(&:question).join(', ')
      elsif @tags
        result += "Categorías de Preguntas sobre OmbuShop: "
        result += @tags.map(&:name).join(', ')
      else
        result += "Preguntas Frecuentas sobre OmbuShop. "
      end

      result = result[0..190]

      if params[:page]
        result += " - Página #{params[:page]}"
      end
      
      result
    end
    
  end
end