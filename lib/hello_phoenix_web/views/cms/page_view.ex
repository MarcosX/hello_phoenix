defmodule HelloPhoenixWeb.CMS.PageView do
  use HelloPhoenixWeb, :view
  alias HelloPhoenix.CMS

  def author_name(%CMS.Page{author: author}) do
    author.user.name
  end
end
