defmodule Helloplug do

  #called once when the server is started
  def init(default_opts) do
    IO.puts "starting the server"
    default_opts
  end

  #called with every new request
  def call(conn, _opts) do
    IO.puts "saying hello world"
    Plug.Conn.send_resp(conn, 200, "Hello World")
  end
end
