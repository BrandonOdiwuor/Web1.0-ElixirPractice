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

  defp route("GET", ["home"], conn) do
    #this is the route for "/home"
    conn |> Plug.Conn.send_resp(200, "Hello World, welcome to home page")
  end
  defp route("GET", ["story"], conn) do
    #this is the route for "/story"
    conn |> Plug.Conn.send_resp(200, "Hello World, welcome to story page")
  end
  defp route("GET", ["about_us"], conn) do
    #this is the route for "/about_us"
    conn |> Plug.Conn.send_resp(200, "Hello World, welcome to about-us page")
  end
  defp route(_, _, conn) do
    #Error if page no page could be matched to the request
    conn |> Plug.Conn.send_resp(404, "Sorry could not find the requested page")
  end
end
