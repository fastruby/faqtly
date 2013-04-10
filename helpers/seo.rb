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

    # Calculates the page meta keywords tag for SEO.
    #
    # @return [String] CSV string
    def keywords
      result = ''
      base_keywords = "tienda online,tienda facebook,e-commerce"
      if @question
        result = "#{base_keywords},#{@question.keywords}"
      elsif @tag
        questions = @tag.questions
        keywords = questions.map(&:keywords).join(',')
        result = "#{base_keywords},#{keywords}"
      elsif @tags
        keywords = @tags.map{|x| "categoría #{x.name}"}.join(',')
        result = "#{base_keywords},#{keywords}"
      elsif @questions
        keywords = @questions.map(&:keywords).join(',')
        result = "#{base_keywords},#{keywords}"
      end
        
      result
    end

    # Calculates the page meta description tag for SEO.
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