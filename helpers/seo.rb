# encoding: utf-8
module Faqtly
  module SEO

    # Calculates the page title using a question. 
    # 
    # @return [String] Page title
    def page_title
      result = ''

      if @page_title
        result = @page_title
      elsif @question
        if @question.question.to_s.length < 50
          if t1 = @question.tags.first
            result = "#{t1.name.to_s} #{@question.question.to_s}" 
          else
            result = "OmbuShop: #{@question.question.to_s}" 
          end
          
        else
          result = "OmbuShop: #{@question.question.to_s}" 
        end
        
      elsif @tag
        result = "Preguntas Frecuentes: #{@tag.name.to_s}. "
      elsif @tags
        result = "OmbuShop: Categorías de Preguntas. "
      else
        result = "OmbuShop: Preguntas Frecuentes. "
      end

      result = result[0..70]

      if params[:page]
        result += "| Página #{params[:page]}"
      end

      result
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