module ApplicationHelper
  def flash_background_color(name)
    case name.to_sym
    when :notice
      'bg-[#006D77]/10 border border-[#006D77]/20'
    when :alert
      'bg-red-100 border border-red-200'
    when :success
      'bg-green-100 border border-green-200'
    else
      'bg-gray-100 border border-gray-200'
    end
  end

  def flash_text_color(name)
    case name.to_sym
    when :notice
      'text-[#264653]'
    when :alert
      'text-red-800'
    when :success
      'text-green-800'
    else
      'text-gray-800'
    end
  end

  def flash_button_color(name)
    case name.to_sym
    when :notice
      'text-[#006D77]'
    when :alert
      'text-red-500'
    when :success
      'text-green-500'
    else
      'text-gray-500'
    end
  end

  def flash_icon(name)
    case name.to_sym
    when :notice
      '<svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-[#006D77]" viewBox="0 0 20 20" fill="currentColor">
        <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7-4a1 1 0 11-2 0 1 1 0 012 0zM9 9a1 1 0 000 2v3a1 1 0 001 1h1a1 1 0 100-2v-3a1 1 0 00-1-1H9z" clip-rule="evenodd" />
      </svg>'.html_safe
    when :alert
      '<svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-red-500" viewBox="0 0 20 20" fill="currentColor">
        <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd" />
      </svg>'.html_safe
    when :success
      '<svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-green-500" viewBox="0 0 20 20" fill="currentColor">
        <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd" />
      </svg>'.html_safe
    else
      '<svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-gray-500" viewBox="0 0 20 20" fill="currentColor">
        <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7-4a1 1 0 11-2 0 1 1 0 012 0zM9 9a1 1 0 000 2v3a1 1 0 001 1h1a1 1 0 100-2v-3a1 1 0 00-1-1H9z" clip-rule="evenodd" />
      </svg>'.html_safe
    end
  end
end