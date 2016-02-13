defmodule Helloplug do

  #called once when the server is started
  def init(default_opts) do
    IO.puts "starting the server"
    default_opts
  end

  #called with every new request
  def call(conn, _opts) do
    IO.puts "saying hello world"
    #matching diffrent requests to diffrent pages
    route(conn.method, conn.path_info, conn)
  end

  #precompiling the templates into a function
  require EEx
  EEx.function_from_file :defp, :index, "templates/index.eex", []
  EEx.function_from_file :defp, :story, "templates/story.eex", []
  EEx.function_from_file :defp, :about_us, "templates/about_us.eex", []


  defp route("GET", ["home"], conn) do
    #this is the route for "/home"
    page_content = index()
    conn |> Plug.Conn.put_resp_content_type("text/html") |> Plug.Conn.send_resp(200, page_content)
  end
  defp route("GET", ["story"], conn) do
    #this is the route for "/story"
    page_content = story()
    conn |> Plug.Conn.put_resp_content_type("text/html") |> Plug.Conn.send_resp(200, page_content)
  end
  defp route("GET", ["about_us"], conn) do
    #this is the route for "/about_us"
    page_content = about_us()
    conn |> Plug.Conn.put_resp_content_type("text/html") |> Plug.Conn.send_resp(200, page_content)
  end
  defp route(_, _, conn) do
    #Error if page no page could be matched to the request
    conn |> Plug.Conn.send_resp(404, "Sorry could not find the requested page")
  end
end
