class Views::Base < Components::Base
  include Components

  PageInfo = Data.define(:title)

  def layout = Layout
  def page_title = "Clean Way"

  def around_template
    render layout.new(page_info) do
      super
    end
  end

  def page_info
    PageInfo.new(
      title: page_title
    )
  end
end
