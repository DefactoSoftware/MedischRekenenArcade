module ProblemHelper
  def help_button(controller)
    if controller == "problems"
      return "<a href='#'' id='helpQuestion'>
                <button class='btn btn-warning btn-embossed'>
                  #{t("practice.helpquestion")}
                </button>
              </a>".html_safe
    end
  end
end
